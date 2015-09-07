#This is to parse the putput file of loopdir
# Calculate the average compression ratio
DataAmount=0.0;
FileCount=0;
LZAll=0.0
SHAll=0.0
DHAll=0.0
SmallFile=0;
AllFile=0;
with open('userdata.log', 'r') as data:
	print ('Parsing Begin:.....')
	for each_line in data:
		Exp_No="No such file" in each_line
		if Exp_No:
			continue;
		line=each_line.strip()
		#print line
		#if(line[0]=='r' and ("apk" in line) and (not ("dex") in line)):
		if(line[0]=='r'and ("lib" in line)):
			AllFile=AllFile+1;
			(ftype, level, path,size,LZ, SH, DH)=line[0:-2].split(":")
			print LZ, SH, DH,
			print ':', 
			LZ=float(LZ); SH=float(SH);DH=float(DH);size=float(size)
			if(size<4):
				SmallFile=SmallFile+1;
			if (abs(LZ)<1):
				LZAll=LZAll+LZ*size;
				SHAll=SHAll+SH*size;
				DHAll=DHAll+DH*size;
				FileCount=FileCount+size
			print path
		#else:
			#print 'Folder'

print "%d Files, %d Small Files: %.3f" %(AllFile, SmallFile, float(SmallFile)/AllFile)
print str(FileCount)+'KB'
print("Average Compression Ratio:")
print "Ave_LZ=%0.3f, Ave_SH=%0.3f, Ave_DH=%0.3f" \
		%(LZAll/FileCount, SHAll/FileCount, DHAll/FileCount)
