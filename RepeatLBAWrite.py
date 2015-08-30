%get a statistical results of Finance trace.
%Measure how many times of writing in a same LBA.
clear;clc

[ASU,LBA,size,type,time] = ParseTrace('./F1_WSort.spc', 1, 650001);

UniqueLBA =[];
VisitTime = [];

curLBA =LBA(1);
curLBATimes=0;
for i = 1: 650000
    i
    if(curLBA == LBA(i))
        curLBATimes = curLBATimes+1;
        i = i+1;
        continue;
    else
        %Store:
        UniqueLBA = [UniqueLBA; curLBA];
        VisitTime = [VisitTime; curLBATimes];
        curLBA=LBA(i);
        curLBATimes = 1;     
    end
end

Res=[UniqueLBA VisitTime];
fprintf('------------Percentage of LBAs-----------\n');

fprintf('In total, %d LBAs are visited\n', length(UniqueLBA));
fprintf('Among them %f are written only once.\n', length(find(VisitTime == 1))/length(UniqueLBA));
fprintf('Among them %f are between 1-10.\n', ...
    length(find(VisitTime >1 & VisitTime <10))/length(UniqueLBA));
fprintf('Among them %f are more betwwen 10-100.\n', ...
    length(find(VisitTime >=10 & VisitTime <100))/length(UniqueLBA));
fprintf('Among them %f are between 100-1000.\n', ...
    length(find(VisitTime >100 & VisitTime < 1000))/length(UniqueLBA));
fprintf('Among them %f are updated more than 1000 times.\n', ...
    length(find(VisitTime >1000))/length(UniqueLBA));

fprintf('------------Percentage of COmmands-----------\n');
fprintf('In total, %d Commands are issued\n', length(LBA));
fprintf('Among them %f are for written only once.\n', length(find(VisitTime == 1))/length(LBA));
fprintf('Among them %f are between 1-10.\n', ...
    sum(VisitTime(find(VisitTime >1 & VisitTime <=10)))  /length(LBA));
fprintf('Among them %f are more betwwen 10-100.\n', ...
    sum(VisitTime(find(VisitTime >10 & VisitTime <= 100)))  /length(LBA));
fprintf('Among them %f are between 100-1000.\n', ...
    sum(VisitTime(find(VisitTime >100 & VisitTime <=1000)))  /length(LBA));
fprintf('Among them %f are updated more than 1000 times.\n', ...
    sum(VisitTime(find(VisitTime >1000 )))  /length(LBA));






