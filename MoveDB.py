#Move the database to other place

import os
import sys
import commands

def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if os.path.isdir(path):
    	LoopDir(path,1+level)
    else:
    	if ('.db' in path):
    		os.system('mv '+path +' /media/Seagate/database' +path)
    		print ('Moved: ' +path)

rootDir='/media/Seagate/data'
level=0
LoopDir(rootDir,level)


