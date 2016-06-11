function RehedgerStocks2(aBot,aTime)

myStrike= 10;
myDeltaPosition = DeltaPosition(aBot,myStrike);
myPercentage = 0.006;

if myDeltaPosition>myPercentage*aBot.ownTrades.volume(1),
    myBidStockV=abs(round(myDeltaPosition));
    myBidStockP=aBot.StockDepth.bidLimitPrice(1);
    aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
    aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, aTime);
end
if myDeltaPosition<-myPercentage*aBot.ownTrades.volume(1),
    myAskStockV=abs(round(myDeltaPosition));
    myAskStockP=aBot.StockDepth.askLimitPrice(1);
    aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1) - myAskStockV;
    aBot.SendNewOrder(myAskStockP, myAskStockV,  1, {'ING'}, {'IMMEDIATE'}, aTime);
end
end