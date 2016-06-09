function Rehedger(aBot,aTime)
%First consider only strikes of 10
myStrike=10;
myExpiry=(1000000-aTime)/1000000;

if isempty(aBot.StockDepth)==0,
    if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0 && isempty(aBot.Call1000Depth)==0,
        mySpot = Valuate(aBot.StockDepth.askLimitPrice(1), aBot.StockDepth.askVolume(1), aBot.StockDepth.bidLimitPrice(1), aBot.StockDepth.bidVolume(1), 0.01);
        myCallDeltaChange = (mySpot-10.42)*0.3193;
        
        if myCallDeltaChange > 0,
            if isempty(aBot.Call1000Depth.askVolume)==0,
                myBidStockV=aBot.StockDepth.bidVolume(1);
                myBidStockP=aBot.StockDepth.bidLimitPrice(1);
                myPreOptionAmount=aBot.Call1000Depth.askVolume(1);
                if round(myBidStockV/myCallDeltaChange)<=myPreOptionAmount && myBidStockV>0 && myPreOptionAmount>=round(myBidStockV/myCallDeltaChange),

                    %Calculate how many call options we should buy
                    myOptionAmount=round(myBidStockV/myCallDeltaChange);
                    myOptionPrice=aBot.Call1000Depth.askLimitPrice;
                    myCallDeltaChange
                    %Send buy/sell orders
                    aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume  - myOptionAmount;
                    aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 1);

                    aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
                    aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, 2);
                end
            end
        elseif myCallDeltaChange < 0,
            if isempty(aBot.Call1000Depth.bidVolume)==0,
                myAskStockV=aBot.StockDepth.askVolume(1);
                myAskStockP=aBot.StockDepth.askLimitPrice(1);
                myPreOptionAmount=aBot.Call1000Depth.bidVolume(1);
                if round(myAskStockV/-myCallDeltaChange)<=myPreOptionAmount && myAskStockV>0 && myPreOptionAmount>=round(myAskStockV/-myCallDeltaChange),

                    %Calculate how many call options we should buy
                    myOptionAmount=round(myAskStockV/-myCallDeltaChange);
                    myOptionPrice=aBot.Call1000Depth.bidLimitPrice;

                    %Send buy/sell orders
                    aBot.Call1000Depth.bidVolume = aBot.Call1000Depth.bidVolume  - myOptionAmount;
                    aBot.SendNewOrder(myOptionPrice, myOptionAmount,  -1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 3);

                    aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1) - myAskStockV;
                    aBot.SendNewOrder(myAskStockP, myAskStockV,  1, {'ING'}, {'IMMEDIATE'}, 4);
                end
            end
        end
    end
end
end