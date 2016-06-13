function PCCheck(aBot,timeFactor)
% Checks to find riskless money opportunities
% 


    % buy put
    % sell call
 
if isempty(aBot.Call1000Depth)==0 && isempty(aBot.Put1000Depth)==0 && isempty(aBot.StockDepth)==0,
%% Arbitrage when put-call parity does not hold between
% equal strike price stocks

    % if p + s < c + x
    
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
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1000Depth.askVolume(1) = aBot.Call1000Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put1000Depth.bidVolume(1) = aBot.Put1000Depth.bidVolume(1)-(myPutBidV*timeFactor);
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
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1000Depth.bidVolume(1) = aBot.Call1000Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put1000Depth.askVolume(1) = aBot.Put1000Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end


%% Arbitrage when call price is lower bound

if isempty(aBot.Call1000Depth.askVolume)==0,
        myCallAskP=aBot.Call1000Depth.askLimitPrice;
        myCallAskV=aBot.Call1000Depth.askVolume;
            
        if myCallAskP < mySpotBid-myStrike,        
            if myCallaskV > 0,
        aBot.SendNewOrder(myCallAskP, myCallAskV,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 9);
        aBot.Call1000Depth.askVolume(1) = aBot.Call1000Depth.askVolume(1)-myCallAskV;
            end
        end
end


%% Arbitrage when put price is lower bound

if isempty(aBot.Put1000Depth.askVolume)==0,
        myPutAskP=aBot.Put1000Depth.askLimitPrice;
        myPutAskV=aBot.Put1000Depth.askVolume;
            
        if myPutAskP < myStrike-mySpotBid,        
            if myPutAskV > 0,
        aBot.SendNewOrder(myPutAskP, myPutAskV,  1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 9);
        aBot.Put1000Depth.askVolume(1) = aBot.Put1000Depth.askVolume(1)-myPutAskV;
            end
        end
end
end
 
