#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import commands

def display(path, level):
  #Try the compression here and get the average compression ratio
  #The indent, blank symbols is the level
  for i in range(0, level):
    print ' ',
  if(os.path.isdir(path)):
    print('d:'),
  elif(os.path.isfile(path)):
    print('r:'),
  else:
    print('o:'),
  print( str(level)+ ':'+ path + ':'),
  (status,output)=commands.getstatusoutput('./Comp res.txt <'+path);
  if(os.path.isdir(path)):
    print ''
  elif(os.path.isfile(path)):
    print output+''
  else:
      print ''

def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if os.path.isdir(path):
      display(path, level)
      LoopDir(path,level+1)
    else:
      display(path, level)

rootDir='/media/Seagate/DataSet/5.0_50/data/media/obb/com.dirtybit.funrun2'
level=0
LoopDir(rootDir,level)
