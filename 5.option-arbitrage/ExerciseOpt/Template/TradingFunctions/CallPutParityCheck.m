function CallPutParityCheck(aBot)

if isempty(aBot.Call1000Depth)==0 && isempty(aBot.Put1000Depth)==0 && isempty(aBot.StockDepth)==0,
    %Preambule
    myInterest=0;
    myStrike=str2num(aBot.Call1000Depth.ISIN(16:end))/100;

    %Check Call-Put parity
    %Buying call options
    if isempty(aBot.Call1000Depth.askVolume)==0 && isempty(aBot.Put1000Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call1000Depth.askLimitPrice;
        myCallAskV=aBot.Call1000Depth.askVolume;
        myPutBidP=aBot.Put1000Depth.bidLimitPrice;
        myPutBidV=aBot.Put1000Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);

        if myCallAskP+myStrike<myPutBidP+mySpotBidP;        
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, myCallAskV,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, myPutBidV,  -1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);

            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1000Depth.askVolume(1) = aBot.Call1000Depth.askVolume(1)-myCallAskV;
            aBot.Put1000Depth.bidVolume(1) = aBot.Put1000Depth.bidVolume(1)-myPutBidV;
        end
    end

    %Buying put options
    if isempty(aBot.Call1000Depth.bidVolume)==0 && isempty(aBot.Put1000Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call1000Depth.bidLimitPrice;
        myCallBidV=aBot.Call1000Depth.bidVolume;
        myPutAskP=aBot.Put1000Depth.askLimitPrice;
        myPutAskV=aBot.Put1000Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);

        if myCallBidP+myStrike>myPutAskP+mySpotAskP;        
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, myCallBidV,  -1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, myPutAskV,  1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);

            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1000Depth.bidVolume(1) = aBot.Call1000Depth.bidVolume(1)-myCallBidV;
            aBot.Put1000Depth.askVolume(1) = aBot.Put1000Depth.askVolume(1)-myPutAskV;
        end
    end
end


end

