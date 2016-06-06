function DeltaHedge(aBot,aTime)
%First consider only strikes of 10
myStrike=10;
myExpiry=(1000000-aTime)/1000000;

if isempty(aBot.StockDepth)==0,
    %Buy call options and sell stock
    if isempty(aBot.Call1000Depth)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        if isempty(aBot.Call1000Depth.askVolume)==0,
            myBidStockV=aBot.StockDepth.bidVolume(1);
            myBidStockP=aBot.StockDepth.bidLimitPrice(1);
            
            %Calculate how many call options we should buy
            myOptionAmount=min(1000,round(myBidStockV/Delta(aBot,myStrike,myExpiry,1)));
            myOptionPrice=aBot.Call1000Depth.askLimitPrice;
            
            %Send buy/sell orders
            aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume  - myOptionAmount;
            aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
            aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
        end
    end

    %Buy put options and buy stock
    if isempty(aBot.Put1000Depth)==0 && isempty(aBot.StockDepth.askVolume)==0,
        if isempty(aBot.Put1000Depth.askVolume)==0,
            myAskStockV=aBot.StockDepth.askVolume(1);
            myAskStockP=aBot.StockDepth.askLimitPrice(1);
            
            %Calculate how many call options we should buy
            myOptionAmount=min(1000,-round(myAskStockV/Delta(aBot,myStrike,myExpiry,0)));
            myOptionPrice=aBot.Put1000Depth.askLimitPrice;
            
            %Send buy/sell orders
            aBot.Put1000Depth.askVolume = aBot.Put1000Depth.askVolume  - myOptionAmount;
            aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1) - myAskStockV;
            aBot.SendNewOrder(myAskStockP, myAskStockV,  1, {'ING'}, {'IMMEDIATE'}, 0);
        end
    end
end
end