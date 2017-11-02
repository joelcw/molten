library(ggplot2)
library(plyr)
library(dplyr)

####For melted/molten over time
####Read the file of weihachtsgurke output into an R data frame.
#### Note that you need to remove the headers from the weihachtsgurke file and convert my special seperator 9U2 into a comma before you can read that file in. This has been done already, though.

foo <- read.csv("~/CurrentLx/OldNorse/gentdigs/meltedMolten.pyccle.csv")

#metaEebo <- read.csv("~/CurrentLx/OldNorse/gentdigs/pyccle-eebo-phase1/dates-author-eebo.csv")

#getting the columns in the right order
#metaEebo2 <- data.frame(metaEebo$file,metaEebo$date,metaEebo$author,metaEebo$dob,metaEebo$dod)

#colnames(metaEebo2) <- c("file","date","author","dob","dod")

#metaEcco <- read.csv("~/CurrentLx/OldNorse/gentdigs/pyccle-ecco/dates-author-ecco.csv")

#combining all meta data into one data frame
#allmeta <- rbind(metaEebo2,metaEcco)

#gets rid of dupliate rows, which WOULD CAUSE PROBLEMS WHEN MERGING THEM!
#cleanmeta <- unique(allmeta)

#write.csv(cleanmeta, file="~/CurrentLx/OldNorse/gentdigs/pyccleMeta.csv", row.names = FALSE)

cleanmeta <- read.csv("~/CurrentLx/OldNorse/gentdigs/pyccleMeta.csv")

####Give appropriate column names to the columns

colnames(foo) <- c("file","Context","Form","Match","Sentence")

#fulldata <- join(foo,cleanmeta,by="file", type="left")

fulldata <- merge(foo, cleanmeta, by=c("file"), all.y=FALSE)

#fulldata <- left_join(foo,cleanmeta,by="file")

write.csv(fulldata, file="~/CurrentLx/OldNorse/gentdigs/fulldataset.csv", row.names = FALSE)

fulldata <- read.csv(file="~/CurrentLx/OldNorse/gentdigs/fulldataset.csv")
library(gdata)


#convert to numeric

fulldata$date <- as.numeric(as.character(fulldata$date))
fulldata$dob <- as.numeric(as.character(fulldata$dob))
fulldata$dod <- as.numeric(as.character(fulldata$dod))

"finished converting to numeric"


library(RColorBrewer)


####Experimenting with cubic splines

library(splines)
library(MASS)

#Trying a plot without binning:

p <- ggplot(fulldata, aes(date, Context, color=Form, group=Form)) + labs(y = "Participle or Adjectival", x = "\nYear") + geom_point() + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Set1") 

ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/ContextByDateUnbinnedWithDots.pdf", width = 8, height = 5)

#Trying a plot with a different x and group

p <- ggplot(fulldata, aes(date, Form, color=Context, group=Context)) + labs(y = "Melted or Molten", x = "\nYear") + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Set1") + geom_point()

ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/FormByDateUnbinnedWithDots.pdf", width = 8, height = 5)





##Create a binary numeric variable for Form so I can use the scale_y_continuous for cosmetic reasons, to try another plot below

fulldata$FormNum <- ifelse(fulldata$Form == "molten", 1, 0)
fulldata$FormNum <- as.numeric(as.character(fulldata$FormNum))

##Trying another plot without binning, in the style of whether/if plots:

p <- ggplot(fulldata, aes(date, FormNum, color=Context, group=Context)) + scale_y_continuous(name = "Proportion Molten (vs. Melted)", breaks=seq(0,1,by=0.1), labels=c("Melted",seq(0.1,0.9,by = 0.1),"Molten") ) + scale_x_continuous(name = "\nYear") + stat_sum(aes(size=..n.., alpha=.2)) + scale_size_area(max_size=12) + stat_smooth(alpha = 0.2) + scale_alpha_continuous(guide="none", limits = c(0,.9)) + scale_color_brewer(palette = "Dark2") + theme_bw() + theme(panel.border = element_blank())

ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/FormByDateUnbinnedWithDots2.pdf", width = 8, height = 5)

#Putting melted/molten on y, without binning, same style as above:

##Create a binary numeric variable for Context so I can use the scale_y_continuous for cosmetic reasons, to try another plot below

fulldata$ContextNum <- ifelse(fulldata$Context == "part", 1, 0)
fulldata$ContextNum <- as.numeric(as.character(fulldata$ContextNum))

p <- ggplot(fulldata, aes(date, ContextNum, color=Form, group=Form)) + scale_y_continuous(name = "Probability of Participle (vs Adj)", breaks=seq(0,1,by=0.1), labels=c("Adj",seq(0.1,0.9,by = 0.1),"Part") ) + scale_x_continuous(name = "\nYear") + stat_sum(aes(size=..n.., alpha=.5)) + scale_size_area(max_size=12) + stat_smooth(alpha = 0.2) + scale_alpha_continuous(guide="none", limits = c(0,.9)) + scale_color_brewer(palette = "Set1") + theme_bw() + theme(panel.border = element_blank())

ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/ContextByDateUnbinnedWithDots2.pdf", width = 8, height = 5)

####Bin the data by half-century:
####Create a new variable in the data frame which will bin the data by half-century. The only point to doing this is to make a pretty graph of percentages across time.

fulldata$date2 <- floor(fulldata$date/50)*50


####Create a new data frame for the percentage plot which averages percentages for each half-century. Again, this is not useful for real data analysis -- just for making this particular plot.

plot.data <- ddply(fulldata, .(date2,Form),summarize, responseProp = mean(ContextNum, na.rm = T), n = sum(!is.na(ContextNum)))

"finished plot.data"

plot.data

p <- ggplot(plot.data, aes(date2, responseProp, color=Form, group=Form)) + labs(y = "Proportion Use as Verbal Participle", x = "\nTime Period") + geom_point(aes(size = n)) + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Dark2") + ylim(0,1)

"finished plot"
"N for all =" 
sum(plot.data$n)


ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/ContextByDateBinned.pdf", width = 8, height = 5)


###Binned, but with Form on y this time:

##Create a binary numeric variable for Form

fulldata$FormNum <- ifelse(fulldata$Form == "molten", 1, 0)
fulldata$FormNum <- as.numeric(as.character(fulldata$FormNum))

plot.data <- ddply(fulldata, .(date2,Context),summarize, responseProp = mean(FormNum, na.rm = T), n = sum(!is.na(FormNum)))


p <- ggplot(plot.data, aes(date2, responseProp, color=Context, group=Context)) + labs(y = "Proportion Molten", x = "\nTime Period") + geom_point(aes(size = n)) + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Dark2") + ylim(0,1)


ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/FormByDateBinned.pdf", width = 8, height = 5)

#####Stats

library(lme4)

#Zing the numeric predictors so the mixed effects model doesnt barf so much:

fulldata$zDate <- scale(fulldata$date, center=TRUE, scale=TRUE)

molten.fit <- glmer(Form~(1|file)+(1|author)+zDate*Context, family = binomial, data=fulldata)
molten.fit2 <- glmer(Form~(1|file)+(1|author)+zDate+Context, family = binomial, data=fulldata)
summary(molten.fit)
anova(molten.fit2, molten.fit, test = "Chisq")


####For melted/molten by individual speaker over time

#create a column for average of dob and dod, to make a mid-point of life for each author, and then plot summaries. One of the reasons for using a mid-life year is that it's less likely anyone's mid-life year will be the same as anyone else's, so you're more likely to be plotting individual systems (without having to hard-code that).

fulldata$midlife <- (fulldata$dob+fulldata$dod)/2
fulldata$FormNum <- as.numeric(as.character(fulldata$FormNum))

#create plot data that averages contexts for each author

plot.data <- ddply(fulldata, .(midlife,Form),summarize, responseProp = mean(ContextNum, na.rm = T), n = sum(!is.na(ContextNum)))

"finished plot.data"

plot.data

#Note, this plot also connects speakers with the same midlife date, with "+ geom_line(aes(group=midlife, colour="Speaker"), alpha=0.5)"

p <- ggplot(plot.data, aes(midlife, responseProp, color=Form, group=Form)) + labs(y = "Proportion Use as Verbal Participle", x = "\nMid-life Year") + geom_point(aes(size = n)) + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Set1") + ylim(0,1) + theme_bw() + theme(panel.border = element_blank()) + geom_line(aes(group=midlife, colour="Speaker"), alpha=0.5)



ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/ContextByDateAuthor.pdf", width = 8, height = 5)

#To figure out how many speakers you've included, do 

plot.data

plot.data[plot.data$midlife != "NA",]

#To figure out how many tokens total are with those speakers
sum(plot.data[plot.data$midlife != "NA",]$n,na.rm = TRUE)

#As above, but cutting off some early speakers because it squishes the window of the graph

p <- ggplot(plot.data, aes(midlife, responseProp, color=Form, group=Form)) + labs(y = "Proportion Use as Verbal Participle", x = "\nMid-life Year") + geom_point(aes(size = n)) + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Set1") + ylim(0,1) + xlim(1513,1805) + theme_bw() + theme(panel.border = element_blank()) + geom_line(aes(group=midlife, colour="Speaker"), alpha=0.5)



ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/ContextByDateAuthor1513.pdf", width = 8, height = 5)


#As above, but only 1550-1700 so you can see more action

p <- ggplot(plot.data, aes(midlife, responseProp, color=Form, group=Form)) + labs(y = "Proportion Use as Verbal Participle", x = "\nMid-life Year") + geom_point(aes(size = n)) + scale_size_area(max_size=12) + stat_smooth() + scale_alpha_continuous(guide="none", limits = c(0,.7)) + scale_color_brewer(palette = "Set1") + ylim(0,1) + xlim(1550,1700) + theme_bw() + theme(panel.border = element_blank()) + geom_line(aes(group=midlife, colour="Speaker"), alpha=0.5)



ggsave(p, file = "~/CurrentLx/OldNorse/gentdigs/ContextByDateAuthor1550.pdf", width = 8, height = 5)