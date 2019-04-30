function [result] = find_sebseq(dates, close_prices)

start_index = 0;
end_index = 0;
result = 0;

m = length(close_prices);

for i = 1:m
    if(close_prices(1,i + 1) >= close_prices(1, i))
        end_index = end_index + 1;
    else 
        start_index = i;
        end_index = i;
        printf(dates(1,start_index));
        printf(dates(1,end_index));
        printf("\n\n");