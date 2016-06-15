function CallPut(aBot,aStrike)

myStockDepth=aBot.StockDepth;
myCallDepth=OptionDepth(aBot,aStrike,1);
myPutDepth=OptionDepth(aBot,aStrike,0);
myStrike=aStrike;
myDiscrepancy=0.0;

% Check emptiness
if isempty(myStockDepth)==0 && isempty(myCallDepth)==0 && isempty(myPutDepth)==0,
    
    % Lower bound
    if isempty(myStockDepth.bidVolume)==0 && isempty(myCallDepth.askVolume)==0 && isempty(myPutDepth.bidVolume)==0,
        
        % Check CP parity
        if myDiscrepancy+myCallDepth.askLimitPrice+aStrike<=myStockDepth.bidLimitPrice(1)+myPutDepth.bidLimitPrice,
            
            myTradeVolume = min([myStockDepth.bidVolume(1),myCallDepth.askVolume,myPutDepth.bidVolume]);
            
            if myTradeVolume>0,
                
                % Update book
                aBot.StockDepth.bidVolume(1)=aBot.StockDepth.bidVolume(1)-myTradeVolume;
                aBot.SendNewOrder(myStockDepth.bidLimitPrice(1), myTradeVolume,  -1, {'ING'}, {'IMMEDIATE'}, 1);
                
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
                
                
                aBot.SendNewOrder(100, myTradeVolume,  1, {myCallDepth.ISIN}, {'IMMEDIATE'}, 1);
                
                aBot.SendNewOrder(0.01, myTradeVolume,  -1, {myPutDepth.ISIN}, {'IMMEDIATE'}, 2);
                
            end
        end
    end
    
    % Upper bound
    if isempty(myStockDepth.askVolume)==0 && isempty(myCallDepth.bidVolume)==0 && isempty(myPutDepth.askVolume)==0,
        
        % Check CP parity
        if -myDiscrepancy+myCallDepth.bidLimitPrice+aStrike>myStockDepth.askLimitPrice(1)+myPutDepth.askLimitPrice,
            
            myTradeVolume = min([myStockDepth.askVolume(1),myCallDepth.bidVolume,myPutDepth.askVolume]);
            
            if myTradeVolume>0,
                
                % Update book
                aBot.StockDepth.askVolume(1)=aBot.StockDepth.askVolume(1)-myTradeVolume;
                aBot.SendNewOrder(myStockDepth.askLimitPrice(1), myTradeVolume,  1, {'ING'}, {'IMMEDIATE'}, 1);
                
                if myStrike==8, 
                    aBot.Call800Depth.bidVolume = aBot.Call800Depth.bidVolume-myTradeVolume;   
                    aBot.Put800Depth.askVolume = aBot.Put800Depth.askVolume-myTradeVolume;
                elseif myStrike==9,
                    aBot.Call900Depth.bidVolume = aBot.Call900Depth.bidVolume-myTradeVolume;   
                    aBot.Put900Depth.askVolume = aBot.Put900Depth.askVolume-myTradeVolume; 
                elseif myStrike==9.5,
                    aBot.Call950Depth.bidVolume = aBot.Call950Depth.bidVolume-myTradeVolume;   
                    aBot.Put950Depth.askVolume = aBot.Put950Depth.askVolume-myTradeVolume; 
                elseif myStrike==9.75,
                    aBot.Call975Depth.bidVolume = aBot.Call975Depth.bidVolume-myTradeVolume;   
                    aBot.Put975Depth.askVolume = aBot.Put975Depth.askVolume-myTradeVolume; 
                elseif myStrike==10,
                    aBot.Call1000Depth.bidVolume = aBot.Call1000Depth.bidVolume-myTradeVolume;   
                    aBot.Put1000Depth.askVolume = aBot.Put1000Depth.askVolume-myTradeVolume; 
                elseif myStrike==10.25,
                    aBot.Call1025Depth.bidVolume = aBot.Call1025Depth.bidVolume-myTradeVolume;   
                    aBot.Put1025Depth.askVolume = aBot.Put1025Depth.askVolume-myTradeVolume; 
                elseif myStrike==10.50,
                    aBot.Call1050Depth.bidVolume = aBot.Call1050Depth.bidVolume-myTradeVolume;   
                    aBot.Put1050Depth.askVolume = aBot.Put1050Depth.askVolume-myTradeVolume; 
                elseif myStrike==11,
                    aBot.Call1100Depth.bidVolume = aBot.Call1100Depth.bidVolume-myTradeVolume;   
                    aBot.Put1100Depth.askVolume = aBot.Put1100Depth.askVolume-myTradeVolume; 
                elseif myStrike==12,
                    aBot.Call1200Depth.bidVolume = aBot.Call1200Depth.bidVolume-myTradeVolume;   
                    aBot.Put1200Depth.askVolume = aBot.Put1200Depth.askVolume-myTradeVolume; 
                elseif myStrike==14,
                    aBot.Call1400Depth.bidVolume = aBot.Call1400Depth.bidVolume-myTradeVolume;   
                    aBot.Put1400Depth.askVolume = aBot.Put1400Depth.askVolume-myTradeVolume; 
                end                
                
                
                aBot.SendNewOrder(0.01, myTradeVolume,  -1, {myCallDepth.ISIN}, {'IMMEDIATE'}, 1);
                
                aBot.SendNewOrder(100, myTradeVolume, 1, {myPutDepth.ISIN}, {'IMMEDIATE'}, 2);
                
            end
        end
    end
end
end