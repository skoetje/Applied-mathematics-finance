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
%Profit = position(10)*0.6915+position(11)*0.2523+position(1)*10.4399+sum(value);
Deltapos = round(Delta2(aBot,10,aBot.Time(end),1)*position(10)+position(1));
Gammapos = round(Gamma(aBot,10,aBot.Time(end),1)*position(10)+position(1));
BidStock = aBot.StockDepth.bidLimitPrice(1);
AskStock = aBot.StockDepth.askLimitPrice(1);
BidCall = aBot.Call1000Depth.bidLimitPrice(1);
AskCall = aBot.Call1000Depth.askLimitPrice(1);
BidPut = aBot.Put1000Depth.bidLimitPrice(1);
AskPut = aBot.Put1000Depth.askLimitPrice(1);
DeltaC = 0.6742;
DeltaP = -0.3256;
Gamma2 = 0.3193;

if position(11)<=0,
    OptionValueP=AskPut*position(11);
elseif position(11)>0,
    OptionValueP=BidPut*position(11);
end
if position(10)<=0,
    OptionValue=AskCall*position(10);
elseif position(10)>0,
    OptionValue=BidCall*position(10);
end
if position(1)<=0,
    StockValue=AskStock*position(1);
elseif position(1)>0,
    StockValue=BidStock*position(1);
end
Profit=StockValue+OptionValue+OptionValueP+sum(value);
Premium=aBot.ownTrades.volume(1)*aBot.Call1000Depth.bidLimitPrice(1)-aBot.ownTrades.volume(2)*aBot.StockDepth.askLimitPrice(1);
PrePremium=aBot.ownTrades.volume(1)*aBot.ownTrades.price(1)-aBot.ownTrades.volume(2)*aBot.ownTrades.price(2);


fprintf('Payments: %d\n',Payments);
fprintf('Payments Stock: %d\n',PaymentsStock);
fprintf('Payments Options: %d\n',PaymentsOption);
fprintf('Delta position: %d\n',Deltapos);
fprintf('Gamma position: %d\n',Gammapos);
fprintf('Premium (end prices): %f\n',Premium);
fprintf('Premium (start prices): %f\n',PrePremium);
fprintf('Cash Position before end: %f\n',sum(value));
fprintf('Profit after unwind: %f\n',Profit);
fprintf('Call Delta: %f\n',DeltaC);
fprintf('Put Delta: %f\n',DeltaP);
fprintf('Gamma: %f\n',Gamma2);
end
