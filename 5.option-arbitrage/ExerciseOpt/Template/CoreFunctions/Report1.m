function Report1(aBot)
aTrades = aBot.ownTrades;

myING = zeros(length(aTrades.side),2);
% Now make a 3d matrix, where the row and column denotes 
% the price and volume, and the page denotes the type
% of option
options = GetAllOptionISINs();
optionNo = numel(GetAllOptionISINs());
tradeNo = length(aTrades.side);

myOptions = zeros(length(aTrades.side),2,optionNo);

for i = 1:length(aTrades.side),
    page = find(strcmp(aTrades.ISIN(i),options));
    if page == 0,
        myING(i,1) = aTrades.volume(i)* aTrades.side(i);
        myING(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    
    else
        myOptions(i,1,page) = aTrades.volume(i)* aTrades.side(i);
        myOptions(i,2,page) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    end
end

% Get the position and values
position = zeros(optionNo+1);
value = zeros (optionNo+1);

for i = 1:optionNo;
    position(i+1)=sum(myOptions(:,1,i));
    value(i+1)=sum(myOptions(:,2,i));   
end

position(1) = sum(myING(:,1));
value(1) = sum(myING(:,2));

% make table
ING = {'ING'};
assets = cat(1,ING,GetAllOptionISINs());

table(position,value,'RowNames',assets)
end