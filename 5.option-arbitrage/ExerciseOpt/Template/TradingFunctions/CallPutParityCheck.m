function CallPutParityCheck(aBot,timeFactor)
% Checks to find riskless money opportunities
% 
% buy put
    % sell call
     myInterest=0;

if isempty(aBot.Call1000Depth)==0 && isempty(aBot.Put1000Depth)==0 && isempty(aBot.StockDepth)==0,
%% Arbitrage when put-call parity does not hold between
% equal strike price stocks

    % if p + s < c + x
    
    %Preambule
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

%%%%%%%%%%%%%%% Other options, this should be narrowed down though

if isempty(aBot.Call800Depth)==0 && isempty(aBot.Put800Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call800Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call800Depth.askVolume)==0 && isempty(aBot.Put800Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call800Depth.askLimitPrice;
        myCallAskV=aBot.Call800Depth.askVolume;
        myPutBidP=aBot.Put800Depth.bidLimitPrice;
        myPutBidV=aBot.Put800Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call800Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put800Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call800Depth.askVolume(1) = aBot.Call800Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put800Depth.bidVolume(1) = aBot.Put800Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call800Depth.bidVolume)==0 && isempty(aBot.Put800Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call800Depth.bidLimitPrice;
        myCallBidV=aBot.Call800Depth.bidVolume;
        myPutAskP=aBot.Put800Depth.askLimitPrice;
        myPutAskV=aBot.Put800Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call800Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put800Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call800Depth.bidVolume(1) = aBot.Call800Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put800Depth.askVolume(1) = aBot.Put800Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end



if isempty(aBot.Call900Depth)==0 && isempty(aBot.Put900Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call900Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call900Depth.askVolume)==0 && isempty(aBot.Put900Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call900Depth.askLimitPrice;
        myCallAskV=aBot.Call900Depth.askVolume;
        myPutBidP=aBot.Put900Depth.bidLimitPrice;
        myPutBidV=aBot.Put900Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call900Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put900Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call900Depth.askVolume(1) = aBot.Call900Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put900Depth.bidVolume(1) = aBot.Put900Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call900Depth.bidVolume)==0 && isempty(aBot.Put900Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call900Depth.bidLimitPrice;
        myCallBidV=aBot.Call900Depth.bidVolume;
        myPutAskP=aBot.Put900Depth.askLimitPrice;
        myPutAskV=aBot.Put900Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call900Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put900Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call900Depth.bidVolume(1) = aBot.Call900Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put900Depth.askVolume(1) = aBot.Put900Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 


if isempty(aBot.Call950Depth)==0 && isempty(aBot.Put950Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call950Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call950Depth.askVolume)==0 && isempty(aBot.Put950Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call950Depth.askLimitPrice;
        myCallAskV=aBot.Call950Depth.askVolume;
        myPutBidP=aBot.Put950Depth.bidLimitPrice;
        myPutBidV=aBot.Put950Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call950Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put950Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call950Depth.askVolume(1) = aBot.Call950Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put950Depth.bidVolume(1) = aBot.Put950Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call950Depth.bidVolume)==0 && isempty(aBot.Put950Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call950Depth.bidLimitPrice;
        myCallBidV=aBot.Call950Depth.bidVolume;
        myPutAskP=aBot.Put950Depth.askLimitPrice;
        myPutAskV=aBot.Put950Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call950Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put950Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call950Depth.bidVolume(1) = aBot.Call950Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put950Depth.askVolume(1) = aBot.Put950Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 

if isempty(aBot.Call975Depth)==0 && isempty(aBot.Put975Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call975Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call975Depth.askVolume)==0 && isempty(aBot.Put975Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call975Depth.askLimitPrice;
        myCallAskV=aBot.Call975Depth.askVolume;
        myPutBidP=aBot.Put975Depth.bidLimitPrice;
        myPutBidV=aBot.Put975Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call975Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put975Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call975Depth.askVolume(1) = aBot.Call975Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put975Depth.bidVolume(1) = aBot.Put975Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call975Depth.bidVolume)==0 && isempty(aBot.Put975Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call975Depth.bidLimitPrice;
        myCallBidV=aBot.Call975Depth.bidVolume;
        myPutAskP=aBot.Put975Depth.askLimitPrice;
        myPutAskV=aBot.Put975Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call975Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put975Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call975Depth.bidVolume(1) = aBot.Call975Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put975Depth.askVolume(1) = aBot.Put975Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 

if isempty(aBot.Call1025Depth)==0 && isempty(aBot.Put1025Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call1025Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call1025Depth.askVolume)==0 && isempty(aBot.Put1025Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call1025Depth.askLimitPrice;
        myCallAskV=aBot.Call1025Depth.askVolume;
        myPutBidP=aBot.Put1025Depth.bidLimitPrice;
        myPutBidV=aBot.Put1025Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call1025Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put1025Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1025Depth.askVolume(1) = aBot.Call1025Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put1025Depth.bidVolume(1) = aBot.Put1025Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call1025Depth.bidVolume)==0 && isempty(aBot.Put1025Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call1025Depth.bidLimitPrice;
        myCallBidV=aBot.Call1025Depth.bidVolume;
        myPutAskP=aBot.Put1025Depth.askLimitPrice;
        myPutAskV=aBot.Put1025Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call1025Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put1025Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1025Depth.bidVolume(1) = aBot.Call1025Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put1025Depth.askVolume(1) = aBot.Put1025Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 

if isempty(aBot.Call1050Depth)==0 && isempty(aBot.Put1050Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call1050Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call1050Depth.askVolume)==0 && isempty(aBot.Put1050Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call1050Depth.askLimitPrice;
        myCallAskV=aBot.Call1050Depth.askVolume;
        myPutBidP=aBot.Put1050Depth.bidLimitPrice;
        myPutBidV=aBot.Put1050Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call1050Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put1050Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1050Depth.askVolume(1) = aBot.Call1050Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put1050Depth.bidVolume(1) = aBot.Put1050Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call1050Depth.bidVolume)==0 && isempty(aBot.Put1050Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call1050Depth.bidLimitPrice;
        myCallBidV=aBot.Call1050Depth.bidVolume;
        myPutAskP=aBot.Put1050Depth.askLimitPrice;
        myPutAskV=aBot.Put1050Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call1050Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put1050Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1050Depth.bidVolume(1) = aBot.Call1050Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put1050Depth.askVolume(1) = aBot.Put1050Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 

if isempty(aBot.Call1100Depth)==0 && isempty(aBot.Put1100Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call1100Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call1100Depth.askVolume)==0 && isempty(aBot.Put1100Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call1100Depth.askLimitPrice;
        myCallAskV=aBot.Call1100Depth.askVolume;
        myPutBidP=aBot.Put1100Depth.bidLimitPrice;
        myPutBidV=aBot.Put1100Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call1100Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put1100Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1100Depth.askVolume(1) = aBot.Call1100Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put1100Depth.bidVolume(1) = aBot.Put1100Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call1100Depth.bidVolume)==0 && isempty(aBot.Put1100Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call1100Depth.bidLimitPrice;
        myCallBidV=aBot.Call1100Depth.bidVolume;
        myPutAskP=aBot.Put1100Depth.askLimitPrice;
        myPutAskV=aBot.Put1100Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call1100Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put1100Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1100Depth.bidVolume(1) = aBot.Call1100Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put1100Depth.askVolume(1) = aBot.Put1100Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 

if isempty(aBot.Call1200Depth)==0 && isempty(aBot.Put1200Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call1200Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call1200Depth.askVolume)==0 && isempty(aBot.Put1200Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call1200Depth.askLimitPrice;
        myCallAskV=aBot.Call1200Depth.askVolume;
        myPutBidP=aBot.Put1200Depth.bidLimitPrice;
        myPutBidV=aBot.Put1200Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call1200Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put1200Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1200Depth.askVolume(1) = aBot.Call1200Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put1200Depth.bidVolume(1) = aBot.Put1200Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call1200Depth.bidVolume)==0 && isempty(aBot.Put1200Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call1200Depth.bidLimitPrice;
        myCallBidV=aBot.Call1200Depth.bidVolume;
        myPutAskP=aBot.Put1200Depth.askLimitPrice;
        myPutAskV=aBot.Put1200Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call1200Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put1200Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1200Depth.bidVolume(1) = aBot.Call1200Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put1200Depth.askVolume(1) = aBot.Put1200Depth.askVolume(1)-(myPutAskV*timeFactor);
        end
    end
end
 

if isempty(aBot.Call1400Depth)==0 && isempty(aBot.Put1400Depth)==0 && isempty(aBot.StockDepth)==0,
    myStrike=str2num(aBot.Call1400Depth.ISIN(16:end))/100;
 
    if isempty(aBot.Call1400Depth.askVolume)==0 && isempty(aBot.Put1400Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
        myCallAskP=aBot.Call1400Depth.askLimitPrice;
        myCallAskV=aBot.Call1400Depth.askVolume;
        myPutBidP=aBot.Put1400Depth.bidLimitPrice;
        myPutBidV=aBot.Put1400Depth.bidVolume;
        mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
        mySpotBidV=aBot.StockDepth.bidVolume(1);
 
        if myCallAskP+myStrike<myPutBidP+mySpotBidP,        
            if myCallAskV>0 && myPutBidV >0, 
            aBot.TotalStock(end+1)=mySpotBidV*-1;
            aBot.SendNewOrder(myCallAskP, timeFactor*myCallAskV,  1, {aBot.Call1400Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutBidP, timeFactor*myPutBidV,  -1, {aBot.Put1400Depth.ISIN}, {'IMMEDIATE'}, 0);
           % aBot.SendNewOrder(mySpotBidP, mySpotBidV,  -1, {'ING'}, {'IMMEDIATE'}, 0);
            end
            % Update book
            aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1)-mySpotBidV;
            aBot.Call1400Depth.askVolume(1) = aBot.Call1400Depth.askVolume(1)-(myCallAskV*timeFactor);
            aBot.Put1400Depth.bidVolume(1) = aBot.Put1400Depth.bidVolume(1)-(myPutBidV*timeFactor);
        end
    end
 
    %Buying put options
    if isempty(aBot.Call1400Depth.bidVolume)==0 && isempty(aBot.Put1400Depth.askVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        myCallBidP=aBot.Call1400Depth.bidLimitPrice;
        myCallBidV=aBot.Call1400Depth.bidVolume;
        myPutAskP=aBot.Put1400Depth.askLimitPrice;
        myPutAskV=aBot.Put1400Depth.askVolume;
        mySpotAskP=aBot.StockDepth.askLimitPrice(1);
        mySpotAskV=aBot.StockDepth.askVolume(1);
 
        if myCallBidP+myStrike>myPutAskP+mySpotAskP,       
            if myCallBidV>0 && myPutAskV >0,
            aBot.TotalStock(end+1)=mySpotAskV*1;
            aBot.SendNewOrder(myCallBidP, timeFactor*myCallBidV,  -1, {aBot.Call1400Depth.ISIN}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myPutAskP, timeFactor*myPutAskV,  1, {aBot.Put1400Depth.ISIN}, {'IMMEDIATE'}, 0);
            %aBot.SendNewOrder(mySpotAskP, mySpotAskV,  1, {'ING'}, {'IMMEDIATE'}, 0);
            end
 
            % Update book
            aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1)-mySpotAskV;
            aBot.Call1400Depth.bidVolume(1) = aBot.Call1400Depth.bidVolume(1)-(myCallBidV*timeFactor);
            aBot.Put1400Depth.askVolume(1) = aBot.Put1400Depth.askVolume(1)-(myPutAskV*timeFactor);
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
 
