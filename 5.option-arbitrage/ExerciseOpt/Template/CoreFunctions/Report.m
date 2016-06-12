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
myStrikeVec=aBot.myStrikeVec;

position(1) = sum(myING(:,1));
value(1) = sum(myING(:,2));
for i = 1:optionNo;
    position(i+1)=sum(myOptions(:,1,i));
    value(i+1)=sum(myOptions(:,2,i));
end
% All Call positions:
Callpositions=zeros(length(myStrikeVec),1);
for i=1:length(myStrikeVec),
    Callpositions(i)=position(2*i);
end
%  table
ING = {'ING'};
assets = cat(1,ING,GetAllOptionISINs());
    
table(position,value,'RowNames',assets)

%table(position,Total,'RowNames',assets)
Payments = length(aTrades.ISIN);
PaymentsStock = sum(strcmp(aTrades.ISIN,'ING'));
PaymentsOption = length(aBot.ownTrades.volume)-PaymentsStock;
Deltapos = round(nansum(aBot.DeltaConstantG(end,:).*transpose(Callpositions))+position(1));
Gammapos = round(Gamma(aBot,10,aBot.Time(end),1)*position(10)+position(1));
BidStock = aBot.StockDepth.bidLimitPrice(1);
AskStock = aBot.StockDepth.askLimitPrice(1);

BidCall = aBot.Call1000Depth.bidLimitPrice(1);
AskCall = aBot.Call1000Depth.askLimitPrice(1);
BidPut = aBot.Put1000Depth.bidLimitPrice(1);
AskPut = aBot.Put1000Depth.askLimitPrice(1);

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
%Profit=StockValue+OptionValue+OptionValueP+sum(value);
Limitpricevec=zeros(10,1);
for i=1:length(aBot.myStrikeVec),
    myStrike=aBot.myStrikeVec(i);
    myOptionDepth=OptionDepth(aBot,myStrike,1);
    if isempty(myOptionDepth.bidLimitPrice)==0,
        Limitpricevec(i)=myOptionDepth.bidLimitPrice(1);
    elseif isempty(myOptionDepth.bidLimitPrice)==1,
        Limitpricevec(i)=0;
    end
end

Premium=sum(value(1:16));
PrePremium=-sum(Callpositions.*Limitpricevec);
PremiumLoss=Premium-PrePremium;
CashAlt=sum(value)+PrePremium;

ProfitVec=zeros(length(aBot.myStrikeVec),1);
for i=1:length(aBot.myStrikeVec),
    myStrike = aBot.myStrikeVec(i);
    myOptionDepth = OptionDepth(aBot,myStrike,1);
    if isempty(myOptionDepth.bidLimitPrice)==0,
        ProfitVec(i)= myOptionDepth.bidLimitPrice(1)*Callpositions(i);
    elseif isempty(myOptionDepth.bidLimitPrice)==1,
        ProfitVec(i)= 0;
    end
end

Profit=sum(value)+sum(ProfitVec)+aBot.StockDepth.askLimitPrice(1)*position(1);


fprintf('Payments: %d\n',Payments);
fprintf('Payments Stock: %d\n',PaymentsStock);
fprintf('Payments Options: %d\n',PaymentsOption);
fprintf('Delta position: %d\n',Deltapos);
fprintf('Gamma position: %d\n',Gammapos);
fprintf('Premium (end prices): %f\n',Premium);
fprintf('Premium (start prices): %f\n',PrePremium);
fprintf('Premium change: %f\n',PremiumLoss);
fprintf('Cash Position before unwind: %f\n',sum(value));
%fprintf('Cash Altering due to hedging: %f\n',CashAlt);
fprintf('Cash Position after unwind: %f\n',Profit);
fprintf('Sent orders: %d\n',length(aBot.sentOrders.volume));
fprintf('Accepted Orders: %d\n',length(aBot.acceptedOrders.volume));
fprintf('Own Trades: %d\n',length(aBot.ownTrades.volume));
end
