#This is to seperate dex files to a specific folder

#Use Map to find all the filetypes and its total size. K is filetype, V is size
import os
import sys
import commands
import math

count = 100;
destType = "dex";
destPath = " /media/Seagate/Nexus7Partitions/types/old-"+destType+"/" 
# usage: path must be a path of a ordinary file, not directory
def getType(path):
	if(os.path.isdir(path)):
		print 'Get Type Err: Should be a file.'
		return;
	names = path.split('/')
	filename = names[-1]
	filetype = filename.split('.')
	if (len(filetype) == 1):
		curType = 'none'
	else:
		curType = filetype[-1]	
	return curType;

def checkFile(path):
	global count;
	curType = getType(path)
	if curType == destType:
		print path
		os.system('cp ' + path + destPath + str(count) +"." + destType)
		count += 1;


def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if os.path.isdir(path):
      LoopDir(path,level+1)
    else:
      checkFile(path)



rootDir = '/media/Seagate/Nexus7Partitions/5.0_30/data/app/';
level = 0;
LoopDir(rootDir,level)