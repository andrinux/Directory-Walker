%Nexus 7 Trace Reading Intensity
clear;clc
filename='../Sep15/Read/Champion_R_ADC.log';
[Time,BlkNo,BlkCnt,ProcID,mmcqd0] = importN7Trace(filename);

step=1;
timespan=Time(length(Time));
segs=ceil(timespan/step);%the number of segments
Idx=1:length(BlkCnt);
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
