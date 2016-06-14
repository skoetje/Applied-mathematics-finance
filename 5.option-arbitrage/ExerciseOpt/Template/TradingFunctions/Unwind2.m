function Unwind2(aBot,aStrike,aTime)

myThreshold=10000;

% Time check
if aTime>myThreshold,
    myStockDepth=aBot.StockDepth;
    myCallDepth=OptionDepth(aBot,aStrike,1);
    myPutDepth=OptionDepth(aBot,aStrike,0);
    myStrike=aStrike;
    myDiscrepancy=0.01;

    % Check emptiness
    if isempty(myStockDepth)==0 && isempty(myCallDepth)==0 && isempty(myPutDepth)==0,

        % Check Trades
        if isempty(aBot.ownTrades.volume)==0,
            
            % Lower bound
            if isempty(myStockDepth.bidVolume)==0 && isempty(myCallDepth.askVolume)==0 && isempty(myPutDepth.bidVolume)==0,
                
                myStockTrades=find(strcmp(aBot.ownTrades.ISIN,'ING'));
                myStockBuys=myStockTrades(ismember(myStockTrades,find(aBot.ownTrades.side==1)));
                
                if isempty(myStockBuys)==0,
                    myStockPosition= sum(aBot.ownTrades.volume(myStockTrades).*aBot.ownTrades.side(myStockTrades));
                    myStockShift = myStockDepth.bidLimitPrice(1) - aBot.ownTrades.price(myStockBuys(end));
                    aBot.StockShifts(aTime)=myStockShift;
                    
                    myCallTrades = find(strcmp(aBot.ownTrades.ISIN,myCallDepth.ISIN));
                    myCallSells = myCallTrades(ismember(find(strcmp(aBot.ownTrades.ISIN,myCallDepth.ISIN)),find(aBot.ownTrades.side==-1)));
                    aBot.CallSells=myCallSells;
                    
                    myPutTrades = find(strcmp(aBot.ownTrades.ISIN,myPutDepth.ISIN));
                    myPutBuys = myPutTrades(ismember(find(strcmp(aBot.ownTrades.ISIN,myPutDepth.ISIN)),find(aBot.ownTrades.side==1)));
                    aBot.PutBuys=myPutBuys;

                    if isempty(myCallSells)==0 && isempty(myPutBuys)==0,
                        myCallShift = myCallDepth.askLimitPrice-aBot.ownTrades.price(myCallSells(end));
                        myPutShift = myPutDepth.bidLimitPrice-aBot.ownTrades.price(myPutBuys(end));
                        aBot.Differences(aTime)=myPutShift+myStockShift-myCallShift;
                        
                        if myPutShift+myStockShift>myCallShift+myDiscrepancy && myStockPosition>0,

                            myTradeVolume = min([myStockDepth.bidVolume(1),myCallDepth.askVolume,myPutDepth.bidVolume]);

                            if myTradeVolume>0,

                                % Update book
                                aBot.StockDepth.bidVolume(1)=aBot.StockDepth.bidVolume(1)-myTradeVolume;
                                aBot.SendNewOrder(myStockDepth.bidLimitPrice(1), myTradeVolume,  -1, {'ING'}, {'IMMEDIATE'}, 0);

                                if myStrike==8, 
                                    aBot.Call800Depth.askVolume = aBot.Call800Depth.askVolume-myTradeVolume;   
                                    aBot.Put800Depth.bidVolume = aBot.Put800Depth.bidVolume-myTradeVolume;
                                elseif myStrike==9,
                                    aBot.Call900Depth.askVolume = aBot.Call900Depth.askVolume-myTradeVolume;   
                                    aBot.Put900Depth.bidVolume = aBot.Put900Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==9.5,
                                    aBot.Call950Depth.askVolume = aBot.Call950Depth.askVolume-myTradeVolume;   
                                    aBot.Put950Depth.bidVolume = aBot.Put950Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==9.75,
                                    aBot.Call975Depth.askVolume = aBot.Call975Depth.askVolume-myTradeVolume;   
                                    aBot.Put975Depth.bidVolume = aBot.Put975Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==10,
                                    aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume-myTradeVolume;   
                                    aBot.Put1000Depth.bidVolume = aBot.Put1000Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==10.25,
                                    aBot.Call1025Depth.askVolume = aBot.Call1025Depth.askVolume-myTradeVolume;   
                                    aBot.Put1025Depth.bidVolume = aBot.Put1025Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==10.50,
                                    aBot.Call1050Depth.askVolume = aBot.Call1050Depth.askVolume-myTradeVolume;   
                                    aBot.Put1050Depth.bidVolume = aBot.Put1050Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==11,
                                    aBot.Call1100Depth.askVolume = aBot.Call1100Depth.askVolume-myTradeVolume;   
                                    aBot.Put1100Depth.bidVolume = aBot.Put1100Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==12,
                                    aBot.Call1200Depth.askVolume = aBot.Call1200Depth.askVolume-myTradeVolume;   
                                    aBot.Put1200Depth.bidVolume = aBot.Put1200Depth.bidVolume-myTradeVolume; 
                                elseif myStrike==14,
                                    aBot.Call1400Depth.askVolume = aBot.Call1400Depth.askVolume-myTradeVolume;   
                                    aBot.Put1400Depth.bidVolume = aBot.Put1400Depth.bidVolume-myTradeVolume; 
                                end                


                                aBot.SendNewOrder(100, myTradeVolume,  1, {myCallDepth.ISIN}, {'IMMEDIATE'}, 0);

                                aBot.SendNewOrder(0.01, myTradeVolume,  -1, {myPutDepth.ISIN}, {'IMMEDIATE'}, 0);
                            end
                        end
                    end
                end
            end
        end
    end
end
end