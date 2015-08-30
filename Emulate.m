% Simulate the number of pages required to stored a series of deltas in SLC pages
%% SEGMENTED.

% @ Input: initial data compression ratio: a randome number
% @ Inpute: a series of delta's size
% @ need to choose suitable  ECC structure.

clear;clc

WHOLE_PAGE_LENGTH = 4096 * 9/8 * 8;
Header_Length =4*8+70; %bits



%% EMULATING
%Delta Compression Ratio
DeltaSizes = abs(floor(4096 * random('norm', 0.2, 0.03, 1000, 1)));
%Original Data compression ratio
R_data_Set = abs(random('norm', 0.6, 0.05, 1, length(DeltaSizes)));

%% 
%Segmented Approach
PageCount =0;
i =1;
curPageUsed = 0;

while( i <= length(DeltaSizes))
    if(curPageUsed==0)
        %Add compressed original data.
        R_data = R_data_Set(PageCount+1); 
        curPageUsed = Header_Length + floor( R_data * 4096 * 8);
%         fprintf('Cur compressed data with ECC and Header cost %d bits.\n', curPageUsed);
    end
    
    if(curPageUsed < WHOLE_PAGE_LENGTH)
        curDeltaBits = getLength_bits(DeltaSizes(i));
        curPageUsed = curPageUsed +curDeltaBits + Header_Length;
%         fprintf('Cur Delta(%d) with ECC and Header cost %d bits.\n',i,curDeltaBits+Header_Length );
        i = i+1;
    else
        i = i-1;
        curDeltaBits=getLength_bits(DeltaSizes(i));
        curPageUsed = curPageUsed -curDeltaBits - Header_Length;        
        fprintf('%d page Used up: curPageUsed bits %d out of 36864(or 147456) bits. i is %d\n', PageCount, curPageUsed, i);
        curPageUsed =0;
        PageCount = PageCount+1;
    end
end

disp('-----------------Segmented END.--------------------------')    


%% CLUSTERED Approach

PageCount =0;
i =1;
curPageUsed = 0;

while( i <= length(DeltaSizes))
    if(curPageUsed==0)
        R_data = R_data_Set(PageCount+1 : PageCount+4); 
        curPageUsed = 4* Header_Length + floor( R_data * 4096 * 8);
%         fprintf('Cur compressed data with ECC and Header cost %d bits.\n', curPageUsed);
    end
    
    if(curPageUsed < 4 * WHOLE_PAGE_LENGTH)
        curDeltaBits = getLength_bits(DeltaSizes(i));
        curPageUsed = curPageUsed +curDeltaBits + Header_Length;
%         fprintf('Cur Delta(%d) with ECC and Header cost %d bits.\n',i,curDeltaBits+Header_Length );
        i = i+1;
    else
        i = i-1;
        curDeltaBits=getLength_bits(DeltaSizes(i));
        curPageUsed = curPageUsed -curDeltaBits - Header_Length;        
        fprintf('%d page Used up: curPageUsed bits %d out of 36864(or 147456) bits. i is %d\n', PageCount, curPageUsed, i);
        curPageUsed =0;
        PageCount = PageCount+4;
    end
end

disp('\nClustered END.')    
