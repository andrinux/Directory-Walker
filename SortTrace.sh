grep ',w,' Finance_1.spc > Finance_1_W.tmp

sort Finance_1_W.tmp > Finance_1_S.tmp
sort -d Finance_1_S.tmp > F1_WSort.spc

rm *.tmp

#Proces the trace of Home/MSN
cat home |cut -d ' ' -f 1-8 >new
sort -k4 new >sortNew

#Process Trace of Finance
grep ‘,w,’ Finance2.spc > F2_W.spc
sort -n -k1 -n -k2 -n -k5 -t , F2_W.spc >F2_WS.spc
