function Report(aBot)
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
    if isempty(page) == 1,
        myING(i,1) = aTrades.volume(i)* aTrades.side(i);
        myING(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    else
        myOptions(i,1,page) = aTrades.volume(i)* aTrades.side(i);
        myOptions(i,2,page) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    end
end

% Get the position and values
position = zeros(optionNo+1,1);
value = zeros (optionNo+1,1);

position(1) = sum(myING(:,1));
value(1) = sum(myING(:,2));

for i = 1:optionNo;
    position(i+1)=sum(myOptions(:,1,i));
    value(i+1)=sum(myOptions(:,2,i));   
end

% make table
ING = {'ING'};
assets = cat(1,ING,GetAllOptionISINs());
    
table(position,value,'RowNames',assets)

%table(position,Total,'RowNames',assets)

Payments = length(aTrades.ISIN);
PaymentsStock = sum(strcmp(aTrades.ISIN,'ING'));
PaymentsOption = sum(strcmp(aTrades.ISIN,'ING20160916CALL1000'));
Profit = position(10)*0.6915+position(11)*0.2523+position(1)*10.4399+sum(value);
Deltapos = round(0.6742*position(10)+position(1));
Gammapos = round(Gamma(aBot,10,aBot.Time(end),1)*position(10)+position(1));
DeltaC = 0.6742;
DeltaP = -0.3256;
Gamma2 = 0.3193;

fprintf('Payments: %d\n',Payments);
fprintf('Payments Stock: %d\n',PaymentsStock);
fprintf('Payments Options: %d\n',PaymentsOption);
fprintf('Delta position: %d\n',Deltapos);
fprintf('Gamma position: %d\n',Gammapos);
fprintf('Estimated profit: %f\n',Profit);
fprintf('Call Delta: %f\n',DeltaC);
fprintf('Put Delta: %f\n',DeltaP);
fprintf('Gamma: %f\n',Gamma2);
end
