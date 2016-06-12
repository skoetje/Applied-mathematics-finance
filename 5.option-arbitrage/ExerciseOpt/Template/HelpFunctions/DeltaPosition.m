function myDeltaPosition = DeltaPosition(aBot,aStrikeVec)

% myLTtime=round(aBot.sentOrders.ownOrderId(end));
% mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
% myPastSpot=aBot.SpotHistory(myLTtime);
% mySpotMovement=mySpot-myPastSpot;
% myDeltaChange=aBot.CallDeltaVecAFT(myLTtime)+myGamma*mySpotMovement;
% myDeltaPosition = myDeltaChange*aBot.ownTrades.volume(1);



%myDeltaPosition = aBot.ownTrades.volume(1)*Delta_CGamma(aBot,aStrike,1)+sum(aBot.ownTrades.volume(2:end).*aBot.ownTrades.side(2:end));

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
position = zeros(length(aStrikeVec)+1,1);
value = zeros (length(aStrikeVec)+1,1);
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

%For different options at a time
myStrikeVec=aStrikeVec;
myDeltaPositionVec=zeros(length(myStrikeVec),1);
for i=1:length(myStrikeVec),
    myDeltaPositionVec(i)=round(aBot.DeltaConstantG(end,i)*Callpositions(i));
end
% myDeltaPositionWeightedVec=zeros(length(myStrikeVec),1);
% for i=1:length(myStrikeVec),
%     myDeltaPositionWeightedVec(i)=myDeltaPositionVec(i)+position(1)*(myDeltaPositionVec(i)/sum(myDeltaPositionVec));
% end
myDeltaPosition=nansum(aBot.DeltaConstantG(end,:).*transpose(Callpositions))+position(1);
end