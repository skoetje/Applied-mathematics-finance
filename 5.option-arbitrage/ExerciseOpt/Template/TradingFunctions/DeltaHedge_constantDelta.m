function DeltaHedge_constantDelta(aBot,aTime)
%First consider only strikes of 10
myStrike=10;
myExpiry=(1000000-aTime)/1000000;
myCallDelta=0.6742;
myPutDelta=-0.3256;
CountPut=0;

if isempty(aBot.StockDepth)==0,
    %Buy call options and sell stock
    if isempty(aBot.Call1000Depth)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        if isempty(aBot.Call1000Depth.askVolume)==0,
            myBidStockV=aBot.StockDepth.bidVolume(1);
            myBidStockP=aBot.StockDepth.bidLimitPrice(1);
            myPreOptionAmount=aBot.Call1000Depth.askVolume(1);
            if round(myBidStockV/myCallDelta)<=myPreOptionAmount && myBidStockV~=0 && myPreOptionAmount>=round(myBidStockV/myCallDelta),
                
                %Calculate how many call options we should buy
                myOptionAmount=round(myBidStockV/myCallDelta);
                myOptionPrice=aBot.Call1000Depth.askLimitPrice;

                %Send buy/sell orders
                aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume  - myOptionAmount;
                aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);

                aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
                aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
                
            elseif round(myBidStockV/myCallDelta)>myPreOptionAmount,
                myBidStockVNew=round(myPreOptionAmount*myCallDelta);
                
                %Calculate how many call options we should buy
                myOptionAmount=myPreOptionAmount;
                myOptionPrice=aBot.Call1000Depth.askLimitPrice(1);

                %Send buy/sell orders
                aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume  - myOptionAmount;
                aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);

                aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockVNew;
                aBot.SendNewOrder(myBidStockP, myBidStockVNew,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
        end
    end

    %Buy put options and buy stock
    if isempty(aBot.Put1000Depth)==0 && isempty(aBot.StockDepth.askVolume)==0 && CountPut==1,
        if isempty(aBot.Put1000Depth.askVolume)==0,
            myAskStockV=aBot.StockDepth.askVolume(1);
            myAskStockP=aBot.StockDepth.askLimitPrice(1);
            
            if -round(myAskStockV/myPutDelta)<=1000,
            
                %Calculate how many call options we should buy
                myOptionAmount=-round(myAskStockV/myPutDelta);
                myOptionPrice=aBot.Put1000Depth.askLimitPrice;

                %Send buy/sell orders
                aBot.Put1000Depth.askVolume = aBot.Put1000Depth.askVolume  - myOptionAmount;
                aBot.SendNewOrder(myOptionPrice, myOptionAmount,  1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 0);

                aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1) - myAskStockV;
                aBot.SendNewOrder(myAskStockP, myAskStockV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            elseif -round(myAskStockV/myPutDelta)>1000,
                myAskStockV=-1000*myPutDelta;
            
                %Calculate how many call options we should buy
                myOptionAmount=1000;
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
end