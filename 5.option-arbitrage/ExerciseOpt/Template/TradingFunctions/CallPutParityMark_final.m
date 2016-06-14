function CallPutParityMark(aBot,aStrike)

myCallOptionDepth = OptionDepth(aBot,aStrike,1);
myPutOptionDepth = OptionDepth(aBot,aStrike,0);

if isempty(myCallOptionDepth)==0 && isempty(myPutOptionDepth)==0 && isempty(aBot.StockDepth)==0,
    %Preambule
    myInterest=0;
    myStrike=aStrike;
    
    %Check positions
    myCallTrades = find(strcmp(aBot.ownTrades.ISIN,myCallOptionDepth.ISIN));
    myPutTrades = find(strcmp(aBot.ownTrades.ISIN,myPutOptionDepth.ISIN));
    
    myCallPosition= sum(aBot.ownTrades.volume(myCallTrades).*aBot.ownTrades.side(myCallTrades));
    myPutPosition= sum(aBot.ownTrades.volume(myPutTrades).*aBot.ownTrades.side(myPutTrades));
    
    %Check Call-Put parity
    %Buying call options
    if isempty(myCallOptionDepth.askVolume)==0 && isempty(myPutOptionDepth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=myCallOptionDepth.askLimitPrice;
        myCallAskV=myCallOptionDepth.askVolume;
        myPutBidP=myPutOptionDepth.bidLimitPrice;
        myPutBidV=myPutOptionDepth.bidVolume;
        myStockP=aBot.StockDepth.bidLimitPrice(1);
        myStockV=aBot.StockDepth.bidVolume(1);
        
        if myCallAskP+myStrike<(myPutBidP+mySpotBidP)/1.0001 && myCallPosition<3000 && myPutPosition>-3000;
            % Update book
            myCallOptionDepth.askVolume = myCallOptionDepth.askVolume-myCallAskV;
            myPutOptionDepth.bidVolume = myPutOptionDepth.bidVolume-myPutBidV;
            %aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, myCallAskV,  1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, myPutBidV,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
        end
    end

    %Buying put options
    if isempty(myCallOptionDepth.bidVolume)==0 && isempty(myPutOptionDepth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=myCallOptionDepth.bidLimitPrice;
        myCallBidV=myCallOptionDepth.bidVolume;
        myPutAskP=myPutOptionDepth.askLimitPrice;
        myPutAskV=myPutOptionDepth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);

        if myCallBidP+myStrike>(myPutAskP+mySpotAskP)*1.0001 && myPutPosition<3000 && myCallPosition>-3000;        
            % Update book
            myCallOptionDepth.bidVolume = myCallOptionDepth.bidVolume-myCallBidV;
            myPutOptionDepth.askVolume = myPutOptionDepth.askVolume-myPutAskV;
            %aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, myCallBidV,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, myPutAskV,  1, {myPutOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
        end
    end
end
end

