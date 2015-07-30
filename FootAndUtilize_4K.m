clear; clc

% Modification with new definition of Utilization ratio(see comments below)
% Created on July-28-2015
% This is used to calculate the Footprint Reduction and Utilizaiton Ratio
% for 4kB packing.

for Apps=10:10:50

    filename1=['~/sum-Peel-5.0_' num2str(Apps) '.txt']
    filename2=['~/LoopDir/Android-5.0_' num2str(Apps) '-ratio.txt']
    withApkPeel=load(filename1);
    noApkPeel=load(filename2);
    noApkPeelLen=length(noApkPeel);

    LZ=noApkPeel(:,1);
    Static=noApkPeel(:,2);
    Dynamic=noApkPeel(:,3);

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
    StoredLZ=[];
    CombinedLZ=[];  % Used to Calculate the utilization ratio.

    while(cur<length(Data))
        curSum=Data(cur)+Data(cur+1);
        if(curSum<1)
            StoredLZ=[StoredLZ curSum];
            CombinedLZ=[CombinedLZ curSum];
            cur=cur+2;
        else
            StoredLZ=[StoredLZ 1];
            cur=cur+1;
        end
    end

    disp('LZ 4KB Packing Footprint Reduction:')
    1-length(StoredLZ)/noApkPeelLen
    disp('LZ 4KB Packing Utilization Ratio:')
    sum(CombinedLZ)/length(CombinedLZ)
    disp('LZ 4KB Packing _All_ Utilization Ratio:')
    sum(StoredLZ)/length(StoredLZ)
    %==============Dynamic Huffman no APK Peeling=========================

    %Two at most
    cur=1;
    Data=Dynamic;
    StoredHuff=[];
    CombinedHuff=[];  % Used to Calculate the utilization ratio.

    while(cur<length(Data))
        curSum=Data(cur)+Data(cur+1);
        if(curSum<1)
            StoredHuff=[StoredHuff curSum];
            CombinedHuff=[CombinedHuff curSum];
            cur=cur+2;
        else
            StoredHuff=[StoredHuff 1];
            cur=cur+1;
        end
    end

    disp('LZ+Huffman 4KB Packing Footprint Reduction:')
    1-length(StoredHuff)/noApkPeelLen
    disp('LZ+Huffman 4KB Packing Utilization Ratio:')
    sum(CombinedHuff)/length(CombinedHuff)
    disp('LZ+Huffman 4KB Packing _All_ Utilization Ratio:')
    sum(StoredHuff)/length(StoredHuff)

    %===============WITH APK PEELING==================
    Dynamic=withApkPeel(:,3);
    Dynamic(find(Dynamic>1))=1;

    %Two at most
    cur=1;
    Data=Dynamic;
    StoredPeel=[];
    CombinedPeel=[];  % Used to Calculate the utilization ratio.

    while(cur<length(Data))
        curSum=Data(cur)+Data(cur+1);
        if(curSum<1)
            StoredPeel=[StoredPeel curSum];
            CombinedPeel=[CombinedPeel curSum];
            cur=cur+2;
        else
            StoredPeel=[StoredPeel 1];
            cur=cur+1;
        end
    end

    disp('LZ+Huffman with APK Peeling, 4KB Packing Footprint Reduction:')
    1-length(StoredPeel)/noApkPeelLen
    disp('LZ+Huffman with APK Peeling, 4KB Packing Utilization Ratio:')
    sum(CombinedPeel)/length(CombinedPeel)
    disp('LZ+Huffman+ApkPeeling 4KB Packing _All_ Utilization Ratio:')
    sum(StoredPeel)/length(StoredPeel)

end
