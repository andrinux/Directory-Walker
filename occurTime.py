#!/usr/bin/env python
#Filename:occurTimes.py
codelist=[]
f=file('input.txt','r')
map={}
for i in f.readlines():
     i = i.strip()
     if map.has_key(i)==False:
        map.setdefault(i,1)
     else:
        count=map.get(i)+1
        map[i]=count
print map
print "\n \n"
###########################################
#      sort map                           #
#      sort map                           #
###########################################
map=sorted(map.iteritems(),key=lambda asd:asd[1],reverse=True)
print map
print "\n\n"

fo=file('output.txt','w')
for i in map:
     i_list = list(i)
     print i_list[0]
     print i_list[1]
     fo.write(i_list[0])
     fo.write("\n")
     fo.write(str(i_list[1]))
     fo.write("\n")
f.close()
fo.close()


