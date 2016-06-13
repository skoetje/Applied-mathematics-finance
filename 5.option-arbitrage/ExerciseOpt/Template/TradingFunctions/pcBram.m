function pcBram(aBot,aStrike)
% Checks to find riskless money opportunities
% 


    % buy put
    % sell call
 
if isempty(myCallOptionDepth)==0 && isempty(myPutOptionDepth)==0,
%% Arbitrage when put-call parity does not hold between
% equal strike price stocks

    %Preambule
    myStrike=aStrike;
    
    myCallTrades = find(strcmp(aBot.ownTrades.ISIN,myCallOptionDepth.ISIN));
    myPutTrades = find(strcmp(aBot.ownTrades.ISIN,myPutOptionDepth.ISIN));
    
    myCallPosition= sum(aBot.ownTrades.volume(myCallTrades).*aBot.ownTrades.side(myCallTrades));
    myPutPosition= sum(aBot.ownTrades.volume(myPutTrades).*aBot.ownTrades.side(myPutTrades));
 
    %Check Call-Put parity
    %Buying call options
    if isempty(myCallOptionDepth.askVolume)==0 && isempty(myPutOptionDepth.bidVolume)==0,
        myCallAskP=myCallOptionDepth.askLimitPrice;
        myCallAskV=myCallOptionDepth.askVolume;
        myPutBidP=myPutOptionDepth.bidLimitPrice;
        myPutBidV=myPutOptionDepth.bidVolume;
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.SendNewOrder(myCallAskP, myCallAskV,  1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, myPutBidV,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
           
            end
            % Update book
            myCallOptionDepth.askVolume = myCallOptionDepth.askVolume-myCallAskV;
            myPutOptionDepth.bidVolume = myPutOptionDepth.bidVolume-myPutBidV;
        end
    end
 
    %Buying put options
    if isempty(myCallOptionDepth.bidVolume)==0 && isempty(myPutOptionDepth.askVolume)==0,
        myCallBidP=myCallOptionDepth.bidLimitPrice;
        myCallBidV=myCallOptionDepth.bidVolume;
        myPutAskP=myPutOptionDepth.askLimitPrice;
        myPutAskV=myPutOptionDepth.askVolume;
        
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.SendNewOrder(myCallBidP, myCallBidV,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, myPutAskV,  1, {myPutOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
        
            end
 
            % Update book
            myCallOptionDepth.bidVolume = myCallOptionDepth.bidVolume-myCallBidV;
            myPutOptionDepth.askVolume = myPutOptionDepth.askVolume-myPutAskV;
        end
    end
end


%% Arbitrage when call price is lower bound

if isempty(myCallOptionDepth.askVolume)==0,
        myCallAskP=myCallOptionDepth.askLimitPrice;
        myCallAskV=myCallOptionDepth.askVolume;
            
        if myCallAskP < mySpotBid-myStrike,        
            if myCallaskV > 0,
        aBot.SendNewOrder(myCallAskP, myCallAskV,  1, {aBot.Call1000Depth.ISIN}, {'IMMEDIATE'}, 9);
        myCallOptionDepth.askVolume(1) = myCallOptionDepth.askVolume(1)-myCallAskV;
            end
        end
end


%% Arbitrage when put price is lower bound

if isempty(myPutOptionDepth.askVolume)==0,
        myPutAskP=myPutOptionDepth.askLimitPrice;
        myPutAskV=myPutOptionDepth.askVolume;
            
        if myPutAskP < myStrike-mySpotBid,        
            if myPutAskV > 0,
        aBot.SendNewOrder(myPutAskP, myPutAskV,  1, {aBot.Put1000Depth.ISIN}, {'IMMEDIATE'}, 9);
        myPutOptionDepth.askVolume(1) = myPutOptionDepth.askVolume(1)-myPutAskV;
            end
        end
end
end
 
