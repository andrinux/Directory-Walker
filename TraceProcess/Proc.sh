blkparse -f "%5T.%9t\t%a\t%d\t%8S\t%4n\t%4p\t%20C\t%c\n" angry.blktrace.* >Trace.log
#grep -E 'R[[:blank:]]|W[[:blank:]]|WS[[:blank:]]' Trace.log > Trace_RWWS_All.log.tmp
grep -v 'cfq' Trace.log >  Trace_RWWS_All.log.tmp
sort -n Trace_RWWS_All.log.tmp | uniq >Trace_RWWS_All.log
grep -E '[[:blank:]]WS|[[:blank:]]WBS' Trace_RWWS_All.log > Trace_WS_All.log
grep  '[[:blank:]]W' Trace_RWWS_All.log > Trace_W_All.log
grep  -E 'A[[:blank:]]|D[[:blank:]]|C[[:blank:]]' Trace_WS_All.log > Trace_WS_ADC.log
grep  -E 'A[[:blank:]]|D[[:blank:]]|C[[:blank:]]' Trace_W_All.log  > Trace_W_ADC.log
grep  -E 'D[[:blank:]]|C[[:blank:]]' Trace_WS_All.log > Trace_WS_DC.log
rm *.tmp
echo 'Parsing Finished'

#=====================Old Version, work for Proc.m==============================
#blkparse -a fs -a issue -a complete -a queue -f "%5T.%9t\t%a\t%d\t%8S\t%4n\t%4p\t%20C\n" result.blktrace.* >Trace.log
#grep -v 'N' Trace.log >Trace_RW.log
#sort -n Trace_RW.log | uniq >Trace_RW_De.log.tmp
#grep -v '^[a-zA-Z]' Trace_RW_De.log.tmp > Trace_RW_De.log
#grep '[0-9]\.[0-9]' Trace_RW_De.log >Trace_RWWS_All.log 


#grep -E 'D|C' Trace_RWWS_All.log > Trace_RWWS_DC.log
#grep      'D'  Trace_RWWS_DC.log > Trace_RWWS_D.log

#echo 'Parsing Finished'

#Following Segment is to obtain ADC Traces
#grep  'WS' Trace_RWWS_All.log > Trace_WS_All.log.tmp
#grep  -E 'A[[:blank:]]|D[[:blank:]]|C[[:blank:]]' Trace_WS_All.log.tmp > Trace_WS_ADC.log

#grep -v 'I' 
#rm *.tmp

#following is to obatin DC Traces
#grep    'WS'   Trace_RWWS_DC.log > Trace_WS_DC.log.tmp
#grep -v 'FWS'  Trace_WS_DC.log.tmp > Trace_WS_DC.log2
#grep -v 'I'    Trace_WS_DC.log2 > Trace_WS_DC.log
#rm *.tmp Trace_WS_DC.log2

