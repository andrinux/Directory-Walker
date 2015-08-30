grep ',w,' Finance_1.spc > Finance_1_W.tmp

sort Finance_1_W.tmp > Finance_1_S.tmp
sort -d Finance_1_S.tmp > F1_WSort.spc

rm *.tmp
