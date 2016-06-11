function StartHedge2(aBot,aTime,aStrike)

myStrike=aStrike;
myCallDelta=DeltaStart(aBot,myStrike,aTime,1);
myDivision=1000;

myBidStockV=aBot.StockDepth.bidVolume(1);
myBidStockP=aBot.StockDepth.bidLimitPrice(1);

if round(myBidStockV/myCallDelta)<=myDivision,

    myOptionAmount=round(myBidStockV/myCallDelta);
    myOptionPrice=aBot.Call1000Depth.askLimitPrice;

    if myBidStockP>nanmean(aBot.BidHistory(1:end))+nanstd(aBot.BidHistory(1:end)) && myOptionPrice<10.0,
        aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume  - myOptionAmount;
        aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, aTime);

        aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
        aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, aTime);
    end
end

if round(myBidStockV/myCallDelta)>myDivision,

    myOptionAmount=myDivision;
    myBidStockV=round(myDivision*myCallDelta);
    myOptionPrice=aBot.Call1000Depth.askLimitPrice;

    if myBidStockP>nanmean(aBot.BidHistory(1:end))+nanstd(aBot.BidHistory(1:end)) && myOptionPrice<10.0,
        aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume  - myOptionAmount;
        aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, aTime);

        aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
        aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, aTime);
    end
end

end