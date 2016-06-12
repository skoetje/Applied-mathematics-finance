function StartHedge2(aBot,aTime,aStrike,aInitialAmount,aBoolean)
if aTime>50,
    myStrike=aStrike;
    myOptionDepth = OptionDepth(aBot,myStrike,aBoolean);
    myCallDelta = DeltaStart(aBot,myStrike,aTime,1);
    myInitialAmount=aInitialAmount;

    myBidStockV=aBot.StockDepth.bidVolume(1);
    myBidStockP=aBot.StockDepth.bidLimitPrice(1);

    if round(myBidStockV/myCallDelta)<=myInitialAmount && sum(strcmp(myOptionDepth.ISIN,aBot.ownTrades.ISIN))==0,

        myOptionAmount=round(myBidStockV/myCallDelta);
        myOptionPrice=myOptionDepth.askLimitPrice;

        if myBidStockP>nanmean(aBot.BidHistory(1:end)) && myOptionPrice<10.0 && myOptionAmount~=0,
            myOptionDepth.askVolume = myOptionDepth.askVolume  - myOptionAmount;
            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
            aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, aTime);

            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
            aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, aTime);
        end
    end

    if round(myBidStockV/myCallDelta)>myInitialAmount && sum(strcmp(myOptionDepth.ISIN,aBot.ownTrades.ISIN))==0,

        myOptionAmount=myInitialAmount;
        myBidStockV=round(myInitialAmount*myCallDelta);
        myOptionPrice=myOptionDepth.askLimitPrice;

        if myBidStockP>nanmean(aBot.BidHistory(1:end)) && myOptionPrice<10.0,
            myOptionDepth.askVolume = myOptionDepth.askVolume  - myOptionAmount;
            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
            aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, aTime);

            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
            aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, aTime);
        end
    end
end
end