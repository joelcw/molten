rm  meltedMolten.eeboA0.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A0*.tag -s meltedMolten.w -o meltedMolten.eeboA0.csv

echo "done with A0" 

rm meltedMolten.eeboA1.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A1*.tag -s meltedMolten.w -o meltedMolten.eeboA1.csv

echo "done with A1"
 
rm meltedMolten.eeboA2.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A2*.tag -s meltedMolten.w -o meltedMolten.eeboA2.csv

echo "done with A2"
 
rm meltedMolten.eeboA3.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A3*.tag -s meltedMolten.w -o meltedMolten.eeboA3.csv

echo "done with A3"
 
rm meltedMolten.eeboA4.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A4*.tag -s meltedMolten.w -o meltedMolten.eeboA4.csv

echo "done with A4"
 
rm meltedMolten.eeboA5.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A5*.tag -s meltedMolten.w -o meltedMolten.eeboA5.csv

echo "done with A5" 

rm meltedMolten.eeboA6and7.csv meltedMolten.eeboA67.csv
wng pyccle-eebo-phase1/texts/textsA6toA8/A[67]*.tag -s meltedMolten.w -o meltedMolten.eeboA6and7.csv

echo "done with A67"
 
rm meltedMolten.eeboA8.csv
wng pyccle-eebo-phase1/texts/textsA6toA8/A8*.tag -s meltedMolten.w -o meltedMolten.eeboA8.csv

echo "done with A8" 

rm meltedMolten.eeboA9B.csv
wng pyccle-eebo-phase1/texts/textsA9toB/*.tag -s meltedMolten.w -o meltedMolten.eeboA9B.csv

echo "done with A9B"
 
rm meltedMolten.ecco.csv
wng pyccle-ecco/texts/*.tag -s meltedMolten.w -o meltedMolten.ecco.csv

echo "done with ecco"

rm meltedMolten.pyccle.csv
cat meltedMolten.eebo*.csv meltedMolten.ecco.csv > meltedMolten.pyccle.csv

echo "done with cat" 
echo "total number of moltens is:"


egrep "molten" meltedMolten.pyccle.csv | wc -l

echo "total N is the following minus 10:"

wc -l meltedMolten.pyccle.csv