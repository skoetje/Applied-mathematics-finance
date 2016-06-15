function RehedgerStocks2(aBot,aTime,aStrikeVec)

myDeltaPosition = DeltaPosition(aBot,aStrikeVec);
myPercentage = 0.01;

if myDeltaPosition>myPercentage*sum(aBot.ownTrades.volume(find(strcmp(aBot.ownTrades.ISIN,'ING')))),
    myBidStockV=abs(round(myDeltaPosition));
    myBidStockP=aBot.StockDepth.bidLimitPrice(1);
    aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
    aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
    aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, -aTime);
end
if myDeltaPosition<-myPercentage*sum(aBot.ownTrades.volume(find(strcmp(aBot.ownTrades.ISIN,'ING')))),
    myAskStockV=abs(round(myDeltaPosition));
    myAskStockP=aBot.StockDepth.askLimitPrice(1);
    aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1) - myAskStockV;
    aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
    aBot.SendNewOrder(myAskStockP, myAskStockV,  1, {'ING'}, {'IMMEDIATE'}, -aTime);
end
end