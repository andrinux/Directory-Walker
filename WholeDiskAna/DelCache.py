#Delete cache folders

import os
import sys
import commands

def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if not os.path.isdir(path):
    	if ('cache' in path and (not 'dalvik' in path)):
    		os.system('rm -r '+path)
    		print ('Delete: ' +path)
    else:
      	LoopDir(path,level+1)

rootDir='/media/Seagate/Nexus7Partitions/4.4.3/'
level=0
LoopDir(rootDir,level)


