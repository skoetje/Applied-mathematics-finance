function myDeltaPosition = DeltaPosition(aBot,aStrikeVec)

aTrades = aBot.ownTrades;
myExpiry=((169000-aBot.Time(end))+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);
myING = zeros(length(aTrades.side),2);
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
    myDeltaPositionVec(i)=round(DeltaStart2(aBot,myStrike,myExpiry,1)*Callpositions(i));
end

myDeltaPosition=nansum(aBot.DeltaConstantG(end,:).*transpose(Callpositions))+position(1);
end