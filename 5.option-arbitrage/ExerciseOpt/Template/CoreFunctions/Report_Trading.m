function Report_Trading(aBot)

% Preambule
aTrades = aBot.ownTrades;
myING = zeros(length(aTrades.side),2);
options = GetAllOptionISINs();
optionNo = numel(GetAllOptionISINs());
myOptions = zeros(length(aTrades.side),2,optionNo);
position = zeros(optionNo+1,1);
value = zeros (optionNo+1,1);
myStrikeVec=aBot.myStrikeVec;

% Retrieve Trades
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
position(1) = sum(myING(:,1));
value(1) = sum(myING(:,2));
for i = 1:optionNo;
    position(i+1)=sum(myOptions(:,1,i));
    value(i+1)=sum(myOptions(:,2,i));
end

% Calculate manual unwind
myCurrentAskPrices=zeros(21,1);
myCurrentBidPrices=zeros(21,1);

myCurrentAskPrices(1)=aBot.StockDepth.askLimitPrice(1);
myCurrentBidPrices(1)=aBot.StockDepth.bidLimitPrice(1);

k=0;
p=0;
for i=1:20,
    if mod(i,2)==1,
        k=k+1;
        myCurrentBidPrices(i+1)=NaN;
        myCurrentAskPrices(i+1)=NaN;
        myOptionDepth=OptionDepth(aBot,myStrikeVec(k),1);
        if isempty(myOptionDepth)==0,
            if isempty(myOptionDepth.askLimitPrice)==0,
                myCurrentAskPrices(i+1)=myOptionDepth.askLimitPrice(1);
            end
            if isempty(myOptionDepth.bidLimitPrice)==0,
                myCurrentBidPrices(i+1)=myOptionDepth.bidLimitPrice(1);
            end
        end
    elseif mod(i,2)==0,
        p=p+1;
        myOptionDepth=OptionDepth(aBot,myStrikeVec(k),0);
        myCurrentBidPrices(i+1)=NaN;
        myCurrentAskPrices(i+1)=NaN;
        if isempty(myOptionDepth)==0,
            if isempty(myOptionDepth.askLimitPrice)==0,
                myCurrentAskPrices(i+1)=myOptionDepth.askLimitPrice(1);
            end
            if isempty(myOptionDepth.bidLimitPrice)==0,
                myCurrentBidPrices(i+1)=myOptionDepth.bidLimitPrice(1);
            end
        end
    end
end
myUnwindCosts=zeros(21,1);
for i=1:21,
    if position(i)>0,
        myUnwindCosts(i)=position(i)*myCurrentBidPrices(i);
    elseif position(i)<0,
        myUnwindCosts(i)=position(i)*myCurrentAskPrices(i);
    end
end


%  Create Table
Position=round(position);
Cash=round(value);
Unwind=round(myUnwindCosts);
Profit=round(value+myUnwindCosts);
ING = {'ING'};
assets = cat(1,ING,GetAllOptionISINs());
table(Position,Cash,Unwind,Profit,'RowNames',assets)

% Specific Prints
fprintf('Amount of stock trades: %d\n',length(find(strcmp(aTrades.ISIN,'ING'))));
fprintf('Amount of option trades: %d\n',length(aTrades.ISIN)-length(find(strcmp(aTrades.ISIN,'ING'))));
fprintf('Cash position (end): %d\n',round(sum(value)));
fprintf('Cash position (after unwind): %d\n',round(sum(value)+nansum(myUnwindCosts)));
fprintf('Sent orders: %d\n',length(aBot.sentOrders.volume));
fprintf('Accepted Orders: %d\n',length(aBot.acceptedOrders.volume));
fprintf('Own Trades: %d\n',length(aBot.ownTrades.volume));
end