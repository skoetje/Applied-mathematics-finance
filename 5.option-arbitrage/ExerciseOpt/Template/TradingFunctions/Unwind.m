function Unwind(aBot,aTime)

myFeedLength=3300;
myThreshold=myFeedLength/2;
myFactor=0.5;
myTradeFactor=1.1;
myDeviation=0.01;
myExponent=10;

for myBoolean=0:1,
    if aTime>myThreshold,

        for i=1:length(aBot.myStrikeVec),
            myStrike=aBot.myStrikeVec(i);
            myOptionDepth=OptionDepth(aBot,myStrike,myBoolean);
            if isempty(myOptionDepth)==0,
                myOptionTrades = find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN));
                myOptionSells = myOptionTrades(ismember(find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN)),find(aBot.ownTrades.side==-1)));
                myOptionBuys = myOptionTrades(ismember(find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN)),find(aBot.ownTrades.side==1)));

                myOptionPosition= sum(aBot.ownTrades.volume(myOptionTrades).*aBot.ownTrades.side(myOptionTrades));
                if isempty(myOptionDepth)==0,
                    if isempty(myOptionDepth.bidVolume)==0 && myOptionPosition > 0,
                        myOptionPrice = myOptionDepth.bidLimitPrice;
                        myOptionVolume = round(myOptionPosition/myTradeFactor);
                        myOptionBuyPrices = aBot.ownTrades.price(myOptionBuys);
                        myOptionSellPrices = aBot.ownTrades.price(myOptionSells);

                        if myOptionPrice > myDeviation+nanmean(myOptionBuyPrices)-myFactor*nanmean(aBot.ownTrades.price(myOptionSells))*((aTime-myThreshold)/(myFeedLength-myThreshold))^myExponent && myOptionVolume<=myOptionDepth.bidVolume,
                            
                            if myBoolean==0,
                                if myStrike==8,    
                                    aBot.Put800Depth.bidVolume = aBot.Put800Depth.bidVolume-myOptionVolume;
                                elseif myStrike==9,  
                                    aBot.Put900Depth.bidVolume = aBot.Put900Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==9.5,  
                                    aBot.Put950Depth.bidVolume = aBot.Put950Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==9.75,   
                                    aBot.Put975Depth.bidVolume = aBot.Put975Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==10,   
                                    aBot.Put1000Depth.bidVolume = aBot.Put1000Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==10.25,   
                                    aBot.Put1025Depth.bidVolume = aBot.Put1025Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==10.50,   
                                    aBot.Put1050Depth.bidVolume = aBot.Put1050Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==11,  
                                    aBot.Put1100Depth.bidVolume = aBot.Put1100Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==12,   
                                    aBot.Put1200Depth.bidVolume = aBot.Put1200Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==14,  
                                    aBot.Put1400Depth.bidVolume = aBot.Put1400Depth.bidVolume-myOptionVolume; 
                                end
                            elseif myBoolean==1,
                                if myStrike==8, 
                                    aBot.Call800Depth.bidVolume = aBot.Call800Depth.bidVolume-myOptionVolume;  
                                elseif myStrike==9,
                                    aBot.Call900Depth.bidVolume = aBot.Call900Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==9.5,
                                    aBot.Call950Depth.bidVolume = aBot.Call950Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==9.75,
                                    aBot.Call975Depth.bidVolume = aBot.Call975Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==10,
                                    aBot.Call1000Depth.bidVolume = aBot.Call1000Depth.bidVolume-myOptionVolume;
                                elseif myStrike==10.25,
                                    aBot.Call1025Depth.bidVolume = aBot.Call1025Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==10.50,
                                    aBot.Call1050Depth.bidVolume = aBot.Call1050Depth.bidVolume-myOptionVolume;
                                elseif myStrike==11,
                                    aBot.Call1100Depth.bidVolume = aBot.Call1100Depth.bidVolume-myOptionVolume; 
                                elseif myStrike==12,
                                    aBot.Call1200Depth.bidVolume = aBot.Call1200Depth.bidVolume-myOptionVolume;
                                elseif myStrike==14,
                                    aBot.Call1400Depth.bidVolume = aBot.Call1400Depth.bidVolume-myOptionVolume; 
                                end
                            end
                            
                            %myOptionDepth.bidVolume = myOptionDepth.bidVolume - myOptionVolume;
                            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
                            aBot.SendNewOrder(myOptionPrice, myOptionVolume,  -1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, -aTime);
                        end
                    end        
                    if isempty(myOptionDepth.askVolume)==0 && myOptionPosition < 0,
                        myOptionPrice = myOptionDepth.askLimitPrice;
                        myOptionVolume = -round(myOptionPosition/myTradeFactor);
                        myOptionBuyPrices = aBot.ownTrades.price(myOptionBuys);
                        myOptionSellPrices = aBot.ownTrades.price(myOptionSells);

                        if myOptionPrice < -myDeviation+nanmean(myOptionSellPrices)+myFactor*nanmean(aBot.ownTrades.price(myOptionBuys))*((aTime-myThreshold)/(myFeedLength-myThreshold))^myExponent && myOptionVolume<=myOptionDepth.askVolume,
                            
                            if myBoolean==0,
                                if myStrike==8,    
                                    aBot.Put800Depth.askVolume = aBot.Put800Depth.askVolume-myOptionVolume;
                                elseif myStrike==9,  
                                    aBot.Put900Depth.askVolume = aBot.Put900Depth.askVolume-myOptionVolume; 
                                elseif myStrike==9.5,  
                                    aBot.Put950Depth.askVolume = aBot.Put950Depth.askVolume-myOptionVolume; 
                                elseif myStrike==9.75,   
                                    aBot.Put975Depth.askVolume = aBot.Put975Depth.askVolume-myOptionVolume; 
                                elseif myStrike==10,   
                                    aBot.Put1000Depth.askVolume = aBot.Put1000Depth.askVolume-myOptionVolume; 
                                elseif myStrike==10.25,   
                                    aBot.Put1025Depth.askVolume = aBot.Put1025Depth.askVolume-myOptionVolume; 
                                elseif myStrike==10.50,   
                                    aBot.Put1050Depth.askVolume = aBot.Put1050Depth.askVolume-myOptionVolume; 
                                elseif myStrike==11,  
                                    aBot.Put1100Depth.askVolume = aBot.Put1100Depth.askVolume-myOptionVolume; 
                                elseif myStrike==12,   
                                    aBot.Put1200Depth.askVolume = aBot.Put1200Depth.askVolume-myOptionVolume; 
                                elseif myStrike==14,  
                                    aBot.Put1400Depth.askVolume = aBot.Put1400Depth.askVolume-myOptionVolume; 
                                end
                            elseif myBoolean==1,
                                if myStrike==8, 
                                    aBot.Call800Depth.askVolume = aBot.Call800Depth.askVolume-myOptionVolume;  
                                elseif myStrike==9,
                                    aBot.Call900Depth.askVolume = aBot.Call900Depth.askVolume-myOptionVolume; 
                                elseif myStrike==9.5,
                                    aBot.Call950Depth.askVolume = aBot.Call950Depth.askVolume-myOptionVolume; 
                                elseif myStrike==9.75,
                                    aBot.Call975Depth.askVolume = aBot.Call975Depth.askVolume-myOptionVolume; 
                                elseif myStrike==10,
                                    aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume-myOptionVolume;
                                elseif myStrike==10.25,
                                    aBot.Call1025Depth.askVolume = aBot.Call1025Depth.askVolume-myOptionVolume; 
                                elseif myStrike==10.50,
                                    aBot.Call1050Depth.askVolume = aBot.Call1050Depth.askVolume-myOptionVolume;
                                elseif myStrike==11,
                                    aBot.Call1100Depth.askVolume = aBot.Call1100Depth.askVolume-myOptionVolume; 
                                elseif myStrike==12,
                                    aBot.Call1200Depth.askVolume = aBot.Call1200Depth.askVolume-myOptionVolume;
                                elseif myStrike==14,
                                    aBot.Call1400Depth.askVolume = aBot.Call1400Depth.askVolume-myOptionVolume; 
                                end
                            end
                                                        
                            %myOptionDepth.askVolume = myOptionDepth.askVolume - myOptionVolume;
                            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
                            aBot.SendNewOrder(100, myOptionVolume,  1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, -aTime);
                        end
                    end
                end
            end
        end

    end
end

% Unwinding of Stocks
end