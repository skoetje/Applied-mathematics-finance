function CallPutParityMark(aBot,aStrike)

myCallOptionDepth = OptionDepth(aBot,aStrike,1);
myPutOptionDepth = OptionDepth(aBot,aStrike,0);
myStrike=aStrike;
myFactor=1.00;

if isempty(myCallOptionDepth)==0 && isempty(myPutOptionDepth)==0 && isempty(aBot.StockDepth)==0,
    
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
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);

        if myCallAskP+myStrike<(myPutBidP+mySpotBidP)/myFactor;% && myCallPosition<3000 && myPutPosition>-3000;
            if myCallAskV>0 && myPutBidV >0 && myCallAskV<=myCallOptionDepth.askVolume && myPutBidV<=myPutOptionDepth.askVolume, 
                
                if myStrike==8, 
                    aBot.Call800Depth.askVolume = aBot.Call800Depth.askVolume-myCallAskV;   
                    aBot.Put800Depth.bidVolume = aBot.Put800Depth.bidVolume-myPutBidV;
                elseif myStrike==9,
                    aBot.Call900Depth.askVolume = aBot.Call900Depth.askVolume-myCallAskV;   
                    aBot.Put900Depth.bidVolume = aBot.Put900Depth.bidVolume-myPutBidV; 
                elseif myStrike==9.5,
                    aBot.Call950Depth.askVolume = aBot.Call950Depth.askVolume-myCallAskV;   
                    aBot.Put950Depth.bidVolume = aBot.Put950Depth.bidVolume-myPutBidV; 
                elseif myStrike==9.75,
                    aBot.Call975Depth.askVolume = aBot.Call975Depth.askVolume-myCallAskV;   
                    aBot.Put975Depth.bidVolume = aBot.Put975Depth.bidVolume-myPutBidV; 
                elseif myStrike==10,
                    aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume-myCallAskV;   
                    aBot.Put1000Depth.bidVolume = aBot.Put1000Depth.bidVolume-myPutBidV; 
                elseif myStrike==10.25,
                    aBot.Call1025Depth.askVolume = aBot.Call1025Depth.askVolume-myCallAskV;   
                    aBot.Put1025Depth.bidVolume = aBot.Put1025Depth.bidVolume-myPutBidV; 
                elseif myStrike==10.50,
                    aBot.Call1050Depth.askVolume = aBot.Call1050Depth.askVolume-myCallAskV;   
                    aBot.Put1050Depth.bidVolume = aBot.Put1050Depth.bidVolume-myPutBidV; 
                elseif myStrike==11,
                    aBot.Call1100Depth.askVolume = aBot.Call1100Depth.askVolume-myCallAskV;   
                    aBot.Put1100Depth.bidVolume = aBot.Put1100Depth.bidVolume-myPutBidV; 
                elseif myStrike==12,
                    aBot.Call1200Depth.askVolume = aBot.Call1200Depth.askVolume-myCallAskV;   
                    aBot.Put1200Depth.bidVolume = aBot.Put1200Depth.bidVolume-myPutBidV; 
                elseif myStrike==14,
                    aBot.Call1400Depth.askVolume = aBot.Call1400Depth.askVolume-myCallAskV;   
                    aBot.Put1400Depth.bidVolume = aBot.Put1400Depth.bidVolume-myPutBidV; 
                end
                %aBot.StockDepth.bidVolume = aBot.StockDepth.bidVolume - 
                
                aBot.SendNewOrder(100, myCallAskV,  1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 1);
                aBot.SendNewOrder(0.01, myPutBidV,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 2);
                %aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
                %aBot.SendNewOrder(100, 2,  1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
                %aBot.SendNewOrder(0.01, 2,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            end
        end
    end
    myCallOptionDepth = OptionDepth(aBot,aStrike,1);
    myPutOptionDepth = OptionDepth(aBot,aStrike,0);

    %Buying put options
    if isempty(myCallOptionDepth.bidVolume)==0 && isempty(myPutOptionDepth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=myCallOptionDepth.bidLimitPrice;
        myCallBidV=myCallOptionDepth.bidVolume;
        myPutAskP=myPutOptionDepth.askLimitPrice;
        myPutAskV=myPutOptionDepth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
        
        if myCallBidP+myStrike>(myPutAskP+mySpotAskP)*myFactor,
        if myPutPosition<10000000000;% && myCallPosition>-3000;        
            if myCallBidV>0 && myPutAskV >0 && myCallBidV<=myCallOptionDepth.bidVolume && myPutAskV<=myPutOptionDepth.askVolume,
                
                if myStrike==8, 
                    myBidVolume=aBot.Call800Depth.bidVolume;
                    myAskVolume=aBot.Put800Depth.askVolume;
                    aBot.Call800Depth.bidVolume = aBot.Call800Depth.bidVolume-myCallBidV;   
                    aBot.Put800Depth.askVolume = aBot.Put800Depth.askVolume-myPutAskV;
                elseif myStrike==9,
                    myBidVolume=aBot.Call900Depth.bidVolume;
                    myAskVolume=aBot.Put900Depth.askVolume;
                    aBot.Call900Depth.bidVolume = aBot.Call900Depth.bidVolume-myCallBidV;   
                    aBot.Put900Depth.askVolume = aBot.Put900Depth.askVolume-myPutAskV; 
                elseif myStrike==9.5,
                    myBidVolume=aBot.Call950Depth.bidVolume;
                    myAskVolume=aBot.Put950Depth.askVolume;
                    aBot.Call950Depth.bidVolume = aBot.Call950Depth.bidVolume-myCallBidV;   
                    aBot.Put950Depth.askVolume = aBot.Put950Depth.askVolume-myPutAskV; 
                elseif myStrike==9.75,
                    myBidVolume=aBot.Call975Depth.bidVolume;
                    myAskVolume=aBot.Put975Depth.askVolume;
                    aBot.Call975Depth.bidVolume = aBot.Call975Depth.bidVolume-myCallBidV;   
                    aBot.Put975Depth.askVolume = aBot.Put975Depth.askVolume-myPutAskV; 
                elseif myStrike==10,
                    myBidVolume=aBot.Call1000Depth.bidVolume;
                    myAskVolume=aBot.Put1000Depth.askVolume;
                    aBot.Call1000Depth.bidVolume = aBot.Call1000Depth.bidVolume-myCallBidV;   
                    aBot.Put1000Depth.askVolume = aBot.Put1000Depth.askVolume-myPutAskV; 
                elseif myStrike==10.25,
                    myBidVolume=aBot.Call1025Depth.bidVolume;
                    myAskVolume=aBot.Put1025Depth.askVolume;
                    aBot.Call1025Depth.bidVolume = aBot.Call1025Depth.bidVolume-myCallBidV;   
                    aBot.Put1025Depth.askVolume = aBot.Put1025Depth.askVolume-myPutAskV; 
                elseif myStrike==10.50,
                    myBidVolume=aBot.Call1050Depth.bidVolume;
                    myAskVolume=aBot.Put1050Depth.askVolume;
                    aBot.Call1050Depth.bidVolume = aBot.Call1050Depth.bidVolume-myCallBidV;   
                    aBot.Put1050Depth.askVolume = aBot.Put1050Depth.askVolume-myPutAskV; 
                elseif myStrike==11,
                    myBidVolume=aBot.Call1100Depth.bidVolume;
                    myAskVolume=aBot.Put1100Depth.askVolume;
                    aBot.Call1100Depth.bidVolume = aBot.Call1100Depth.bidVolume-myCallBidV;   
                    aBot.Put1100Depth.askVolume = aBot.Put1100Depth.askVolume-myPutAskV; 
                elseif myStrike==12,
                    myBidVolume=aBot.Call1200Depth.bidVolume;
                    myAskVolume=aBot.Put1200Depth.askVolume;
                    aBot.Call1200Depth.bidVolume = aBot.Call1200Depth.bidVolume-myCallBidV;   
                    aBot.Put1200Depth.askVolume = aBot.Put1200Depth.askVolume-myPutAskV; 
                elseif myStrike==14,
                    myBidVolume=aBot.Call1400Depth.bidVolume;
                    myAskVolume=aBot.Put1400Depth.askVolume;
                    aBot.Call1400Depth.bidVolume = aBot.Call1400Depth.bidVolume-myCallBidV;   
                    aBot.Put1400Depth.askVolume = aBot.Put1400Depth.askVolume-myPutAskV; 
                end
                                
                aBot.SendNewOrder(0.01, myCallBidV,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 3);
                aBot.SendNewOrder(100, myPutAskV,  1, {myPutOptionDepth.ISIN}, {'IMMEDIATE'}, 4);
                %aBot.SendNewOrder(0.01, myBidVolume,  -1, {myCallOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
                %aBot.SendNewOrder(100, myAskVolume,  1, {myPutOptionDepth.ISIN}, {'IMMEDIATE'}, 0);
            end
        end
        end
    end
end
end

