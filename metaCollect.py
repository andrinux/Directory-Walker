#Collect the metadata of all the files in a folder
import os
import sys
import commands
count = 0;

#================================================
def dumpInode(filename):
    global count;
    (status,output)=commands.getstatusoutput('ls -i '+filename);
    inodeStr=output.split(' ')[0]
    #print inodeStr
    os.system("./debugfs '<" + inodeStr +">'")
    os.system("cat inode.bin >> all.bin")
    os.system("mv inode.bin ./collect/inode_"+str(count)+".bin");
    count = count + 1;


def display(path, level):
    print path;
    dumpInode(path);

#====================
def LoopDir(rootDir,level):   
    for lists in os.listdir(rootDir):       
        path = os.path.join(rootDir, lists)
        if os.path.isdir(path):
            display(path, level)
            LoopDir(path,level+1)
        else:
            display(path, level)

#Main
rootDir='/project/linux-2.6.32.24/'
level=0
LoopDir(rootDir,level)
