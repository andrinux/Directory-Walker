#This is scripts to find all the possible filetypes using their file extension
#Basic is to loop over all the paths

#Use Map to find all the filetypes and its total size. K is filetype, V is size
import os
import sys
import commands


typeMap = dict();

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

#Return Value is in Byte/KByte?
def getSize(path):
	filesize =4 * float( os.path.getsize(path)/4096)
	if(filesize < 4):
		filesize = 4
	return filesize


# Update the map information by adding a new type or update size
# usage: path must be a path of a ordinary file, not directory
def updateMap(path):
	global typeMap;
	#check general file or directory
	if(os.path.isdir(path)):
		print 'Err: Should be a file.'
		return;
	curType = getType(path);
	filesize = getSize(path)
	if curType == 'none':
		print path + " ==> " + str(filesize)
	if typeMap.has_key(curType):
		typeMap[curType] += filesize
	else:
		typeMap[curType] = filesize


def LoopDir(rootDir,level):   
  for lists in os.listdir(rootDir):       
    path = os.path.join(rootDir, lists)
    if os.path.isdir(path):
      #display(path, level)
      LoopDir(path,level+1)
    else:
      #display(path, level)
      updateMap(path)


rootDir = '/home/xuebinzhang/zlib-1.2.8/win32';
level = 0;
LoopDir(rootDir,level)

print typeMap
