#!/usr/bin/python
#
# This scripts is used to extract and remove the dex files and lib files with apk
# Method: call the system function of zip, recursively walk all the path

import os
import sys
import commands
import math


# usage: path must be a path of a ordinary file, not directory
def getType(path):
  if(os.path.isdir(path)):
    print 'Get Type Err: Should be a file.'
    return
  names = path.split('/')
  filename = names[-1]
  filetype = filename.split('.')
  if (len(filetype) == 1):
    curType = 'none'
  else:
    curType = filetype[-1]  
  return curType

def rmDexLib(path):
    os.system('zip -d '+ path + ' *.dex')
    os.system('zip -d '+ path + ' ./lib/*.*')

def checkFile(path):
  global count
  curType = getType(path)
  if curType == "apk":
    rmDexLib(path)

def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if os.path.isdir(path):
      LoopDir(path,level+1)
    else:
      checkFile(path)



rootDir = '/media/Seagate/Nexus7-APK-Peel/5.0_10/data/'
level = 0
LoopDir(rootDir,level)
