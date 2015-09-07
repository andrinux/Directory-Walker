%This script is used to analyze the parsed blktrace with filename remapped
%
% .po file(format is constrained) in NEXUS S
%
%Divided by Two part, Reading then writing
%The Action Type inside trace should be 'C'

% clear; clc
% Choose the trace item type here:
% R is for Read, W is for Write, WS for synchronous write
% Actions include A-D-C
AnalyzeType='R';
ActionType='D';

%% Open file and preprocess
filename='./Sep15/N7/R_Complete.log'
[Time Action Type BlkNo BlkCnt ProcId Proc BlkType FileName]= ParseData(filename);

disp('Reading Analyzing Begin......')
disp('================R/W ratio=========================')
Idx=find(strcmp(Action,ActionType) & strcmp(Type, 'R') & BlkCnt~=0);
str=sprintf('[Reading] IO Trace: %d, Data Count (kB): %d', length(Idx), sum(BlkCnt(Idx))/2); disp(str);
Idx=find(strcmp(Action,ActionType) & strcmp(Type, 'W') & BlkCnt~=0);
str=sprintf('[Async Writing] IO Trace: %d, Data Count (kB): %d', length(Idx), sum(BlkCnt(Idx))/2); disp(str);
Idx=find(strcmp(Action,ActionType) & strcmp(Type, 'WS') & BlkCnt~=0);
str=sprintf('[Sync Writing] IO Trace: %d, Data Count (kB): %d', length(Idx), sum(BlkCnt(Idx))/2); disp(str);


%% IO Size Distribution (1)4K (2) 4~16K (3) 16-64K (4)64~256K (5)>256K
Idx=find(strcmp(Action, ActionType) & strcmp(Type, AnalyzeType) & BlkCnt~=0);
BlkCntLocal=BlkCnt(Idx)/2; %Convert BlockCnt to Size in KB
disp('TotalIO: '); Total=length(Idx)
SizeLocal=zeros(Total,1);
Amount_vs_Size=zeros(5,1); %5x1 array to store the data amount
for i=1:Total
    Cnt=BlkCntLocal(i);
    if Cnt <= 4
        SizeLocal(i)=1;
        Amount_vs_Size(1)=Amount_vs_Size(1)+Cnt;
    end
    if Cnt >4 & Cnt<=16
        SizeLocal(i)=2;
        Amount_vs_Size(2)=Amount_vs_Size(2)+Cnt;
    end
    if Cnt >16 & Cnt <=64
        SizeLocal(i)=3;
        Amount_vs_Size(3)=Amount_vs_Size(3)+Cnt;
    end
    if Cnt>64 & Cnt <= 256
        SizeLocal(i)=4;
        Amount_vs_Size(4)=Amount_vs_Size(4)+Cnt;
    end
    if Cnt > 256
        SizeLocal(i)=5;
        Amount_vs_Size(5)=Amount_vs_Size(5)+Cnt;
    end
        
end
disp('IO Distribution of Reading');
disp('(1)4K (2) 4~16K (3) 16-64K (4)64~256K (5)>256K')
disp('IO Size type distribution')
tabulate(SizeLocal);
str=sprintf('Data amount of 4KB reading: %d', Amount_vs_Size(1)); disp(str)
str=sprintf('Data amount of 4~16KB reading: %d', Amount_vs_Size(2)); disp(str)
str=sprintf('Data amount of 16~64KB reading: %d', Amount_vs_Size(3)); disp(str)
str=sprintf('Data amount of 64~256KB reading: %d', Amount_vs_Size(4)); disp(str)
str=sprintf('Data amount of >256KB reading: %d', Amount_vs_Size(5)); disp(str)
%BlkCntLocal is the all the trace's block count
SizeDistri(BlkCntLocal)

disp('==============Reading Strength along time======================')

%% Reading Strength along time
step=0.5;
timespan=Time(length(Time))
segs=ceil(timespan/step);%the number of segments
Idx=find(strcmp(Action,ActionType) & strcmp(Type, AnalyzeType) & BlkCnt~=0);
BlkCntLocal=BlkCnt(Idx)/2; %Convert BlockCnt to Size in KB
TimeLocal=Time(Idx);
DataStrength=zeros(1, segs);
IOStrength=zeros(1, segs);
for i=1: length(Idx)
    SegNo=ceil(TimeLocal(i)/step);
    IOStrength(SegNo)=IOStrength(SegNo)+1;
    DataStrength(SegNo)=DataStrength(SegNo)+BlkCntLocal(i);
end
figure;
subplot(2,1,1); plot((step)*(1:segs), DataStrength, 'r')
xlabel('time/sec'); ylabel('KB') ;title('Read intensity: Data amount(KB) in each time segment')
subplot(2,1,2); plot((step)*(1:segs), IOStrength, 'b')
xlabel('time/sec'); title('Read intensity: IO count in each time segment')

%% End
