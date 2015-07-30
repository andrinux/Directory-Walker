clear; clc

% Modification with new definition of Utilization ratio(see comments below)
% Created on July-28-2015
% This is used to calculate the Footprint Reduction and Utilizaiton Ratio
% for 8kB packing.


for Apps=20:10:50

disp(Apps);
filename1=['~/sum-Peel-5.0_' num2str(Apps) '.txt']
filename2=['~/LoopDir/Android-5.0_' num2str(Apps) '-ratio.txt']


withApkPeel=load(filename1);
noApkPeel=load(filename2);
noApkPeelLen=length(noApkPeel);

LZ=noApkPeel(:,1);
Static=noApkPeel(:,2);
Dynamic=noApkPeel(:,3);

%To calculate the footprint reduction:
%(1) NO   APK PEELING, compare to ~/LoopDir/Android-5.0_XX-ratio.txt
%(2) With APK PEELING, compare to ~/sum-Peel-5.0_XX.txt

% 
LZ(find(LZ>1))=1;
Static(find(Static>1))=1;
Dynamic(find(Dynamic>1))=1;

% LZ=LZ(find(LZ<1));
% Dynamic=Dynamic(find(Dynamic<1));


%====================LZ no APK Peeling===================

% %Four at most
cur=1;
Data=LZ;
Stored=[];
Combined=[];
while(cur+3 <= length(LZ))
    sum1 = sum(LZ(cur));
    sum2 = sum(LZ(cur: cur+1));
    sum3 = sum(LZ(cur: cur+2));
    sum4 = sum(LZ(cur: cur+3));
    if(sum4 <= 2)
        Stored = [Stored sum4];
        Combined=[Combined sum4];
        cur = cur+4;
        continue;
    end
    if(sum3 <= 2)
        Stored = [Stored sum3];
        Combined=[Combined sum3];
        cur = cur+3;
        continue;
    end
    if(sum2 <=2) % In this case, donnot use compression, just store directly
        Stored=[Stored 2];
        %Combined=[Combined sum2];
        cur = cur+2;
        continue;
    end
end

disp('LZ 8KB Packing Footprint Reduction:')
1-2*length(Stored)/noApkPeelLen
disp('LZ 8KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)/2



%====================LZ+Huffman no APK Peeling===================

% %Four at most
cur=1;
Data=Dynamic;
Stored=[];
Combined=[];
while(cur+3 <= length(Data))
    sum1 = sum(Data(cur));
    sum2 = sum(Data(cur: cur+1));
    sum3 = sum(Data(cur: cur+2));
    sum4 = sum(Data(cur: cur+3));
    if(sum4 <= 2)
        Stored = [Stored sum4];
        Combined=[Combined sum4];
        cur = cur+4;
        continue;
    end
    if(sum3 <= 2)
        Stored = [Stored sum3];
        Combined=[Combined sum3];
        cur = cur+3;
        continue;
    end
    if(sum2 <=2) % In this case, donnot use compression, just store directly
        Stored=[Stored 2];
        %Combined=[Combined sum2];
        cur = cur+2;
        continue;
    end
end

disp('LZ+Huffman 8KB Packing Footprint Reduction:')
1-2*length(Stored)/noApkPeelLen
disp('LZ+Huffman 8KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)/2



%====================LZ+Huffman WITH APK Peeling===================
Dynamic=withApkPeel(:,3);
Dynamic(find(Dynamic>1))=1;


% %Four at most
cur=1;
Data=Dynamic;
Stored=[];
Combined=[];
while(cur+3 <= length(Data))
    sum1 = sum(Data(cur));
    sum2 = sum(Data(cur: cur+1));
    sum3 = sum(Data(cur: cur+2));
    sum4 = sum(Data(cur: cur+3));
    if(sum4 <= 2)
        Stored = [Stored sum4];
        Combined=[Combined sum4];
        cur = cur+4;
        continue;
    end
    if(sum3 <= 2)
        Stored = [Stored sum3];
        Combined=[Combined sum3];
        cur = cur+3;
        continue;
    end
    if(sum2 <=2) % In this case, donnot use compression, just store directly
        Stored=[Stored 2];
        %Combined=[Combined sum2];
        cur = cur+2;
        continue;
    end
end

disp('LZ+Huffman+APK PEEL 8KB Packing Footprint Reduction:')
1-2*length(Stored)/noApkPeelLen
disp('LZ+Huffman+APK PEEL 8KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)/2

end
