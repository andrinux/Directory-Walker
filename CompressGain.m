clear; clc

allData=load('~/app-so.txt');
LZ=allData(:,1);
Static=allData(:,2);
Dynamic=allData(:,3)*1.07;
% 
% LZ(find(LZ>1))=1;
% Static(find(Static>1))=1;
% Dynamic(find(Dynamic>1))=1;

Static=Static(find(Static<1));
Dynamic=Dynamic(find(Dynamic<1));


%Two at most
cur=1;
Data=Static;
Stored=[];
while(cur<length(Static))
    curSum=Data(cur)+Data(cur+1);
    if(curSum<1)
        Stored=[Stored curSum];
        cur=cur+2;
    else
        Stored=[Stored Data(cur)];
        cur=cur+1;
    end
end

disp('Space Saving:')
1-length(Stored)/length(Static)
disp('Store Efficiency:')
sum(Stored)/length(Stored)

%%====================================
%Two at most
cur=1;
Data=Dynamic;
Stored=[];
Seg=[];
while(cur<length(Dynamic))
    curSum=Data(cur)+Data(cur+1);
    if(curSum<1)
        Stored=[Stored curSum];
        cur=cur+2;
        Seg=[Seg 2];
    else
        Stored=[Stored Data(cur)];
        cur=cur+1;
        Seg=[Seg 1];
    end
end

disp('Space Saving:')
1-length(Stored)/length(Dynamic)
disp('Store Efficiency:')
sum(Stored)/length(Stored)

[m,n]=hist(LZ, 50);
[m1, n1]=hist(Dynamic, 50);
plot(n, m, 'r-x'); hold on
plot(n1, m1, 'b-*'); hold on

        