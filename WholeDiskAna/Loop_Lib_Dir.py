#!/usr/bin/python
# -*- coding: utf-8 -*-
#Loop all the folder to analysis the average compression 
#ratio of files

import os
import sys
import commands

def display(path, level):
  #Try the compression here and get the average compression ratio
  for i in range(0, level):
    print ' ',
  if(os.path.isdir(path)):
    print('d:'),
  elif(os.path.isfile(path)):
    print('r:'),
  else:
    print('o:'),
  print( str(level)+ ':'+ path + ':'),
  (status,output)=commands.getstatusoutput('./Comp tmp.txt <'+path);
  line=path.strip();
  os.system('cat tmp.txt >> ' + App + '_lib.log')
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

#Main
App='CandyCrush'
os.system('touch ' + App + '_lib.log')
rootDir='/home/xuebinzhang/AppTest/NewSize/'+App;
print rootDir;
print (App + '_lib.log')
level=0
LoopDir(rootDir,level)
