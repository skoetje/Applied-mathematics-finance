function Report_Analysis(aBot)

% Preambule
aTrades = aBot.ownTrades;
myING = zeros(length(aTrades.side),2);
options = GetAllOptionISINs();
optionNo = numel(GetAllOptionISINs());
myOptions = zeros(length(aTrades.side),2,optionNo);
position = zeros(optionNo+1,1);
value = zeros (optionNo+1,1);

% Retrieve done trades
for i = 1:length(aTrades.side),
    page = find(strcmp(aTrades.ISIN(i),options));
    if isempty(page) == 1,
        myING(i,1) = aTrades.volume(i)* aTrades.side(i);
        myING(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    else
        myOptions(i,1,page) = aTrades.volume(i)* aTrades.side(i);
        myOptions(i,2,page) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    end
end

% Get the total positions and values
position(1) = sum(myING(:,1));
value(1) = sum(myING(:,2));
for i = 1:optionNo;
    position(i+1)=sum(myOptions(:,1,i));
    value(i+1)=sum(myOptions(:,2,i));
end

% Creation of the table
ING = {'ING'};
assets = cat(1,ING,GetAllOptionISINs());
table(position,value,'RowNames',assets)

% Calculation specifics
fprintf('Average Call Delta: %d\n',mean(aBot.CallDeltas));

end
