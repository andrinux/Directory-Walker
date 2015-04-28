#Analyze the file amount of all kinds of filetype
import os
import sys
import commands

#Existing Type: AllSize=AllSize+filesize/1024.0;
#dex, odex, apk, so, bin, jar, conf, xml, none, 0, others
#png
#.db .db-journal
# obb ogg txt ps ttf

#####################################################################
#
#This file has two functions, for cache files and other regular files
#
#####################################################################

AllSize=0;

def checkType(path, level):
  global AllSize;
  target='png'
  if(os.path.isdir(path)):
    print 'Error: Should be a file.'
  else:
    filesize=os.path.getsize(path)
    filesize=filesize/1024.0;
    parts=path.strip().split('/')
    filename=parts[-1];
    types=filename.split('.')
    if(len(types)>1 and (not 'cache' in path)):
    #if(len(types)>1):
      filetype=types[-1];
      if(cmp(filetype, target)==0):
        AllSize=AllSize+filesize
        print (str(filesize) + ':' +path)

def caclCache(path, level):
  global AllSize;
  if(os.path.isdir(path)):
    print 'Error: Should be a file.'
  else:
    if(('cache' in path) or ('Cache' in path) )and (not 'dalvik' in path):
      filesize=os.path.getsize(path)
      filesize=filesize/1024.0;
      AllSize=AllSize+filesize
      print (str(filesize) + ':' +path)

def calcBin(path, level):
  global AllSize;
  if(os.path.isdir(path)):
    print 'Error: Should be a file.'
  else:
    if('bin' in path) and ('system' in path):
      filesize=os.path.getsize(path)
      filesize=filesize/1024.0;
      AllSize=AllSize+filesize
      print (str(filesize) + ':' +path)

def noType(path, level):
  global AllSize;
  target='zip'
  if(os.path.isdir(path)):
    print 'Error: Should be a file.'
  else:
    filesize=os.path.getsize(path)
    filesize=filesize/1024.0;
    parts=path.strip().split('/')
    filename=parts[-1];
    types=filename.split('.')
    if(len(types)==1 and (not 'cache' in path)):
      AllSize=AllSize+filesize
      print (str(filesize) + ':' +path)


def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if os.path.isdir(path):
      LoopDir(path,level+1)
    else:
      checkType(path, level)
      #noType(path, level)
      #caclCache(path, level)
      #calcBin(path, level)

rootDir='/media/Seagate/DataSet/5.0_10'
level=0
LoopDir(rootDir,level)
print 'All:'+str(AllSize)
