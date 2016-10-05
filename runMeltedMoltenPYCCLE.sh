rm  meltedMolten.eeboIA0.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A0*.tag -s meltedMolten.w -o meltedMolten.eeboIA0.csv

echo "done with IA0" 

rm meltedMolten.eeboIA1.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A1*.tag -s meltedMolten.w -o meltedMolten.eeboIA1.csv

echo "done with IA1"
 
rm meltedMolten.eeboIA2.csv
wng pyccle-eebo-phase1/texts/textsA0toA2/A2*.tag -s meltedMolten.w -o meltedMolten.eeboIA2.csv

echo "done with IA2"
 
rm meltedMolten.eeboIA3.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A3*.tag -s meltedMolten.w -o meltedMolten.eeboIA3.csv

echo "done with IA3"
 
rm meltedMolten.eeboIA4.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A4*.tag -s meltedMolten.w -o meltedMolten.eeboIA4.csv

echo "done with IA4"
 
rm meltedMolten.eeboIA5.csv
wng pyccle-eebo-phase1/texts/textsA3toA5/A5*.tag -s meltedMolten.w -o meltedMolten.eeboIA5.csv

echo "done with IA5" 

rm meltedMolten.eeboIA6and7.csv meltedMolten.eeboIA67.csv
wng pyccle-eebo-phase1/texts/textsA6toA8/A[67]*.tag -s meltedMolten.w -o meltedMolten.eeboIA6and7.csv

echo "done with IA67"
 
rm meltedMolten.eeboIA8.csv
wng pyccle-eebo-phase1/texts/textsA6toA8/A8*.tag -s meltedMolten.w -o meltedMolten.eeboIA8.csv

echo "done with IA8" 

rm meltedMolten.eeboIA9B.csv
wng pyccle-eebo-phase1/texts/textsA9toB/*.tag -s meltedMolten.w -o meltedMolten.eeboIA9B.csv

echo "done with IA9B"
 
rm meltedMolten.ecco.csv
wng pyccle-ecco/texts/*.tag -s meltedMolten.w -o meltedMolten.ecco.csv

echo "done with ecco"




rm  meltedMolten.eeboIIA0.csv
wng pyccle-eebo-phase2/texts/textsA0toA2/A0*.tag -s meltedMolten.w -o meltedMolten.eeboIIA0.csv

echo "done with IIA0" 

rm meltedMolten.eeboIIA1.csv
wng pyccle-eebo-phase2/texts/textsA0toA2/A1*.tag -s meltedMolten.w -o meltedMolten.eeboIIA1.csv

echo "done with IIA1"
 
rm meltedMolten.eeboIIA2.csv
wng pyccle-eebo-phase2/texts/textsA0toA2/A2*.tag -s meltedMolten.w -o meltedMolten.eeboIIA2.csv

echo "done with IIA2"
 
rm meltedMolten.eeboIIA3.csv
wng pyccle-eebo-phase2/texts/textsA3toA5/A3*.tag -s meltedMolten.w -o meltedMolten.eeboIIA3.csv

echo "done with IIA3"
 
rm meltedMolten.eeboIIA4.csv
wng pyccle-eebo-phase2/texts/textsA3toA5/A4*.tag -s meltedMolten.w -o meltedMolten.eeboIIA4.csv

echo "done with IIA4"
 
rm meltedMolten.eeboIIA5.csv
wng pyccle-eebo-phase2/texts/textsA3toA5/A5*.tag -s meltedMolten.w -o meltedMolten.eeboIIA5.csv

echo "done with IIA5" 

rm meltedMolten.eeboIIA6and7.csv meltedMolten.eeboIIA67.csv
wng pyccle-eebo-phase2/texts/textsA6toA8/A[67]*.tag -s meltedMolten.w -o meltedMolten.eeboIIA6and7.csv

echo "done with IIA67"
 
rm meltedMolten.eeboIIA8.csv
wng pyccle-eebo-phase2/texts/textsA6toA8/A8*.tag -s meltedMolten.w -o meltedMolten.eeboIIA8.csv

echo "done with IIA8" 

rm meltedMolten.eeboIIA9B.csv
wng pyccle-eebo-phase2/texts/textsA9toB/*.tag -s meltedMolten.w -o meltedMolten.eeboIIA9B.csv

echo "done with IIA9B"





rm meltedMolten.pyccle.raw.csv
cat meltedMolten.eebo*.csv meltedMolten.ecco.csv > meltedMolten.pyccle.raw.csv

echo "done with cat" 

rm meltedMolten.pyccle.csv
python fixFormat.py < meltedMolten.pyccle.raw.csv > meltedMolten.pyccle.csv

echo "done with fixing format"


echo "total number of moltens is:"


egrep "molten" meltedMolten.pyccle.csv | wc -l

echo "total N is the following:"

wc -l meltedMolten.pyccle.csv