clear; clc

% Modification with new definition of Utilization ratio(see comments below)
% Created on July-28-2015
% This is used to calculate the Footprint Reduction and Utilizaiton Ratio
% for 4kB packing.

withApkPeel=load('~/sum-Peel-5.0_10.txt');
noApkPeel=load('~/LoopDir/Android-5.0_10-ratio.txt');
noApkPeelLen=length(noApkPeel);

LZ=noApkPeel(:,1);
Static=noApkPeel(:,2);
Dynamic=noApkPeel(:,3); %Note Dynamic

%To calculate the footprint reduction:
%(1) NO   APK PEELING, compare to ~/LoopDir/Android-5.0-ratio.txt
%(2) With APK PEELING, compare to ~/sum-Peel-5.0.txt

%Reset the uncompressable block as no compression.
LZ(find(LZ>1))=1;
Static(find(Static>1))=1;
Dynamic(find(Dynamic>1))=1;


%====================LZ no APK Peeling===================
%Two at most
cur=1;
Data=LZ;
Stored=[];
Combined=[];  % Used to Calculate the utilization ratio.

while(cur<length(Data))
    curSum=Data(cur)+Data(cur+1);
    if(curSum<1)
        Stored=[Stored curSum];
        Combined=[Combined curSum];
        cur=cur+2;
    else
        Stored=[Stored 1];
        cur=cur+1;
    end
end

disp('LZ 4KB Packing Footprint Reduction:')
1-length(Stored)/noApkPeelLen
disp('LZ 4KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)


%==============Dynamic Huffman no APK Peeling=========================

%Two at most
cur=1;
Data=Dynamic;
Stored=[];
Combined=[];  % Used to Calculate the utilization ratio.

while(cur<length(Data))
    curSum=Data(cur)+Data(cur+1);
    if(curSum<1)
        Stored=[Stored curSum];
        Combined=[Combined curSum];
        cur=cur+2;
    else
        Stored=[Stored 1];
        cur=cur+1;
    end
end

disp('LZ+Huffman 4KB Packing Footprint Reduction:')
1-length(Stored)/noApkPeelLen
disp('LZ+Huffman 4KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)


%===============WITH APK PEELING==================
Dynamic=withApkPeel(:,3);
Dynamic(find(Dynamic>1))=1;

%Two at most
cur=1;
Data=Dynamic;
Stored=[];
Combined=[];  % Used to Calculate the utilization ratio.

while(cur<length(Data))
    curSum=Data(cur)+Data(cur+1);
    if(curSum<1)
        Stored=[Stored curSum];
        Combined=[Combined curSum];
        cur=cur+2;
    else
        Stored=[Stored 1];
        cur=cur+1;
    end
end

disp('LZ+Huffman with APK Peeling, 4KB Packing Footprint Reduction:')
1-length(Stored)/noApkPeelLen
disp('LZ+Huffman with APK Peeling, 4KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)
