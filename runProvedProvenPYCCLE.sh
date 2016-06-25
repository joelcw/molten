rm  provedProven.eeboA0.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A0*.tag -s provedProven.w -o provedProven.eeboA0.csv

echo "done with A0" 

rm provedProven.eeboA1.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A1*.tag -s provedProven.w -o provedProven.eeboA1.csv

echo "done with A1"
 
rm provedProven.eeboA2.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A2*.tag -s provedProven.w -o provedProven.eeboA2.csv

echo "done with A2"
 
rm provedProven.eeboA3.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A3*.tag -s provedProven.w -o provedProven.eeboA3.csv

echo "done with A3"
 
rm provedProven.eeboA4.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A4*.tag -s provedProven.w -o provedProven.eeboA4.csv

echo "done with A4"
 
rm provedProven.eeboA5.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A5*.tag -s provedProven.w -o provedProven.eeboA5.csv

echo "done with A5" 

rm provedProven.eeboA6and7.csv provedProven.eeboA67.csv
wng pyccle-eebo-phase1/texts/textsA6toA8/A[67]*.tag -s provedProven.w -o provedProven.eeboA6and7.csv

echo "done with A67"
 
rm provedProven.eeboA8.csv
wng pyccle-eebo-phase1/texts/textsA6toA8/A8*.tag -s provedProven.w -o provedProven.eeboA8.csv

echo "done with A8" 

rm provedProven.eeboA9B.csv
wng pyccle-eebo-phase1/texts/textsA9toB/*.tag -s provedProven.w -o provedProven.eeboA9B.csv

echo "done with A9B"
 
rm provedProven.ecco.csv
wng pyccle-ecco/texts/*.tag -s provedProven.w -o provedProven.ecco.csv

echo "done with ecco"

rm provedProven.pyccle.csv
cat provedProven.eebo*.csv provedProven.ecco.csv > provedProven.pyccle.csv

echo "done with cat" 
echo "total number of moltens is:"


egrep "proven" provedProven.pyccle.csv | wc -l

echo "total N is the following minus 10:"

wc -l provedProven.pyccle.csv