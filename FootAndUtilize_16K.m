clear; clc

% Modification with new definition of Utilization ratio(see comments below)
% Created on July-28-2015
% This is used to calculate the Footprint Reduction and Utilizaiton Ratio
% for 16kB packing.

withApkPeel=load('~/sum-Peel-5.0.txt');
noApkPeel=load('~/LoopDir/Android-5.0-ratio.txt');
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
while(cur+7 <= length(Data))
    sum4 = sum(Data(cur: cur+3));
    sum5 = sum(Data(cur: cur+4));
    sum6 = sum(Data(cur: cur+5));
    sum7 = sum(Data(cur: cur+6));
    sum8 = sum(Data(cur: cur+7));
    if(sum8 <= 4)
        Stored = [Stored sum8];
        Combined=[Combined sum8];
        cur = cur+8;
        continue;
    end
    
    if(sum7 <= 4)
        Stored = [Stored sum7];
        Combined=[Combined sum7];
        cur = cur+7;
        continue;
    end
    if(sum6 <= 4)
        Stored = [Stored sum6];
        Combined=[Combined sum6];
        cur = cur+6;
        continue;
    end
    if(sum5 <= 4)
        Stored = [Stored sum5];
        Combined=[Combined sum5];
        cur = cur+5;
        continue;
    end
    if(sum4 <= 4) % No compression at this case
        Stored = [Stored 4];
        %Combined=[Combined sum4];
        cur = cur+4;
        continue;
    end  
end


disp('LZ 16KB Packing Footprint Reduction:')
1-4*length(Stored)/noApkPeelLen
disp('LZ 16KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)/4
disp('LZ 16KB Packing _All_ Utilization Ratio:')
sum(Stored)/length(Stored)/4




%====================LZ+Huffman no APK Peeling===================


% %Four at most
cur=1;
Data=Dynamic;
Stored=[];
Combined=[];
while(cur+7 <= length(Data))
    sum4 = sum(Data(cur: cur+3));
    sum5 = sum(Data(cur: cur+4));
    sum6 = sum(Data(cur: cur+5));
    sum7 = sum(Data(cur: cur+6));
    sum8 = sum(Data(cur: cur+7));
    if(sum8 <= 4)
        Stored = [Stored sum8];
        Combined=[Combined sum8];
        cur = cur+8;
        continue;
    end
    
    if(sum7 <= 4)
        Stored = [Stored sum7];
        Combined=[Combined sum7];
        cur = cur+7;
        continue;
    end
    if(sum6 <= 4)
        Stored = [Stored sum6];
        Combined=[Combined sum6];
        cur = cur+6;
        continue;
    end
    if(sum5 <= 4)
        Stored = [Stored sum5];
        Combined=[Combined sum5];
        cur = cur+5;
        continue;
    end
    if(sum4 <= 4) % No compression at this case
        Stored = [Stored 4];
        %Combined=[Combined sum4];
        cur = cur+4;
        continue;
    end  
end


disp('LZ+Huffman 16KB Packing Footprint Reduction:')
1-4*length(Stored)/noApkPeelLen
disp('LZ+Huffman 16KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)/4
disp('LZ_Huffman 16KB Packing _All_ Utilization Ratio:')
sum(Stored)/length(Stored)/4


%====================LZ+Huffman WITH APK Peeling===================
Dynamic=withApkPeel(:,3);
Dynamic(find(Dynamic>1))=1;


% %Four at most
cur=1;
Data=Dynamic;
Stored=[];
Combined=[];
while(cur+7 <= length(Data))
    sum4 = sum(Data(cur: cur+3));
    sum5 = sum(Data(cur: cur+4));
    sum6 = sum(Data(cur: cur+5));
    sum7 = sum(Data(cur: cur+6));
    sum8 = sum(Data(cur: cur+7));
    if(sum8 <= 4)
        Stored = [Stored sum8];
        Combined=[Combined sum8];
        cur = cur+8;
        continue;
    end
    
    if(sum7 <= 4)
        Stored = [Stored sum7];
        Combined=[Combined sum7];
        cur = cur+7;
        continue;
    end
    if(sum6 <= 4)
        Stored = [Stored sum6];
        Combined=[Combined sum6];
        cur = cur+6;
        continue;
    end
    if(sum5 <= 4)
        Stored = [Stored sum5];
        Combined=[Combined sum5];
        cur = cur+5;
        continue;
    end
    if(sum4 <= 4) % No compression at this case
        Stored = [Stored 4];
        %Combined=[Combined sum4];
        cur = cur+4;
        continue;
    end  
end


disp('LZ+Huffman+APkPeeling16KB Packing Footprint Reduction:')
1-4*length(Stored)/noApkPeelLen
disp('LZ+Huffman+APkPeeling 16KB Packing Utilization Ratio:')
sum(Combined)/length(Combined)/4
disp('LZ+Huffman+APkPeeling 16KB Packing _All_ Utilization Ratio:')
sum(Stored)/length(Stored)/4
