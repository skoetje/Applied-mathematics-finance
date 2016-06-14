classdef AnalysisRobot_final < AutoTrader
    properties
        Time
        StockDepth
        
        Call800Depth
        Call900Depth
        Call950Depth
        Call975Depth
        Call1000Depth
        Call1025Depth
        Call1050Depth
        Call1100Depth
        Call1200Depth
        Call1400Depth
        
        Put800Depth
        Put900Depth
        Put950Depth
        Put975Depth
        Put1000Depth
        Put1025Depth
        Put1050Depth
        Put1100Depth
        Put1200Depth
        Put1400Depth
        
        StockAskPrices
        StockBidPrices
        StockAskVolumes
        StockBidVolumes
                        
        CallOptionAskPrices
        CallOptionBidPrices
        CallOptionAskVolumes
        CallOptionBidVolumes
        CallOptionVolatility
        
        PutOptionAskPrices
        PutOptionBidPrices
        PutOptionAskVolumes
        PutOptionBidVolumes
        PutOptionVolatility
                
        CallDeltas
        PutDeltas
        CallGammas
        PutGammas
        CallVegas
        PutVegas
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            if isempty(aBot.Time)==1,
                aBot.Time(1)=1;
            end
            TimePoint=aBot.Time(end);
            myStrikeVector=[8,9,9.5,9.75,10,10.25,10.5,11,12,14];
            
            % Check cases
            switch aDepth.ISIN
                case 'ING'; aBot.StockDepth = aDepth;
                case 'ING20160916PUT800'; aBot.Put800Depth = aDepth;
                case 'ING20160916CALL800'; aBot.Call800Depth = aDepth;
                case 'ING20160916PUT900'; aBot.Put900Depth = aDepth;
                case 'ING20160916CALL900'; aBot.Call900Depth = aDepth;
                case 'ING20160916PUT950'; aBot.Put950Depth = aDepth;
                case 'ING20160916CALL950'; aBot.Call950Depth = aDepth;
                case 'ING20160916PUT975'; aBot.Put975Depth = aDepth;
                case 'ING20160916CALL975'; aBot.Call975Depth = aDepth;
                case 'ING20160916PUT1000'; aBot.Put1000Depth = aDepth;
                case 'ING20160916CALL1000'; aBot.Call1000Depth = aDepth;
                case 'ING20160916PUT1025'; aBot.Put1025Depth = aDepth;
                case 'ING20160916CALL1025'; aBot.Call1025Depth = aDepth;
                case 'ING20160916PUT1050'; aBot.Put1050Depth = aDepth;
                case 'ING20160916CALL1050'; aBot.Call1050Depth = aDepth;
                case 'ING20160916PUT1100'; aBot.Put1100Depth = aDepth;
                case 'ING20160916CALL1100'; aBot.Call1100Depth = aDepth;
                case 'ING20160916PUT1200'; aBot.Put1200Depth = aDepth;
                case 'ING20160916CALL1200'; aBot.Call1200Depth = aDepth;
                case 'ING20160916PUT1400'; aBot.Put1400Depth = aDepth;
                case 'ING20160916CALL1400'; aBot.Call1400Depth = aDepth;
            end
            
            %We also record the Deltas and gammas
            %for i=1:10
                %myStrike=myStrikeVector(i);
                %aBot.CallDeltas(TimePoint,i)=DeltaStart(aBot,myStrike,TimePoint,1);
                %aBot.CallGammas(TimePoint,i)=Gamma(aBot,myStrike,TimePoint,1);
                %aBot.CallVegas(TimePoint,i)=Vega_disc(aBot,myStrike,TimePoint,1);
                %aBot.PutDeltas(TimePoint,i)=DeltaStart(aBot,myStrike,TimePoint,0);
                %aBot.PutGammas(TimePoint,i)=Gamma(aBot,myStrike,TimePoint,0);
                %aBot.PutVegas(TimePoint,i)=Vega_disc(aBot,myStrike,TimePoint,0);
            %end
            
            % Recording Stock
            myStock=aBot.StockDepth;
            myStockAskVolume=NaN;
            myStockAskPrice=NaN;
            myStockBidVolume=NaN;
            myStockBidPrice=NaN;

            if isempty(myStock)==0,
                if isempty(myStock.askLimitPrice)==0,
                    myStockAskPrice=myStock.askLimitPrice(1);
                    myStockAskVolume=myStock.askVolume(1);
                end
                if isempty(myStock.bidLimitPrice)==0,
                    myStockBidPrice=myStock.bidLimitPrice(1);
                    myStockBidVolume=myStock.bidVolume(1);
                end
            end

            aBot.StockAskVolumes(end+1)=myStockAskVolume;
            aBot.StockAskPrices(end+1)=myStockAskPrice;
            aBot.StockBidVolumes(end+1)=myStockBidVolume;
            aBot.StockBidPrices(end+1)=myStockBidPrice;
            
            % Recording Options
            for i=1:10,
                myStrike=myStrikeVector(i);
                myCallOptionDepth=OptionDepth(aBot,myStrike,1);
                myPutOptionDepth=OptionDepth(aBot,myStrike,0);
                
                for j=1:2,
                    myOption = [];
                    if j==1,
                        myOption = myPutOptionDepth;
                    elseif j==2,
                        myOption = myCallOptionDepth;
                    end
                    myOptionAskPrice=NaN;
                    %myOptionAskVolume=NaN;
                    myOptionBidPrice=NaN;
                    %myOptionBidVolume=NaN;
                    myOptionVolatility=NaN;

                    if (isempty(myOption)==0),
                        if (isempty(myOption.askLimitPrice)==0),
                            myOptionAskPrice=myOption.askLimitPrice(1);
                            %myOptionAskVolume=myOption.askVolume(1);
                        end
                        if (isempty(myOption.bidLimitPrice)==0),
                            myOptionBidPrice=myOption.bidLimitPrice(1);
                            %myOptionBidVolume=myOption.bidVolume(1);
                        end
                        if isempty(myOption.bidLimitPrice)==0 && isempty(myOption.askLimitPrice)==0,
                            myOptionSpot = (myOptionBidPrice+myOptionAskPrice)/2;
                            myStockSpot= (myStockAskPrice+myStockBidPrice)/2;
                            %myOptionVolatility = ImpliedVolatility(myStockSpot,myStrike,TimePoint,myOptionSpot,j-1);
                            myExpiry = ((169000-TimePoint)+3600*24*daysact('13-jun-2016',  '16-sep-2016'))/(3600*24*252);
                            if j==1,
                            myOptionVolatility = blsimpv(myStockSpot,myStrike,myExpiry,0,myOptionSpot,1,0,1e-9,true);
                            elseif j==2,
                            myOptionVolatility = blsimpv(myStockSpot,myStrike,myExpiry,0,myOptionSpot,1,0,1e-9,false);    
                            end
                            
                        end
                    end
                    
                    if j==1,
                        aBot.CallOptionAskPrices(TimePoint,i)=myOptionAskPrice;
                        aBot.CallOptionBidPrices(TimePoint,i)=myOptionBidPrice;
                        %aBot.CallOptionAskVolumes(TimePoint,i)=myOptionAskVolume;
                        %aBot.CallOptionBidVolumes(TimePoint,i)=myOptionBidVolume;
                        aBot.CallOptionVolatility(TimePoint,i)=myOptionVolatility;
                    elseif j==2,
                        aBot.PutOptionAskPrices(TimePoint,i)=myOptionAskPrice;
                        aBot.PutOptionBidPrices(TimePoint,i)=myOptionBidPrice;
                        %aBot.PutOptionAskVolumes(TimePoint,i)=myOptionAskVolume;
                        %aBot.PutOptionBidVolumes(TimePoint,i)=myOptionBidVolume;
                        aBot.PutOptionVolatility(TimePoint,i)=myOptionVolatility;
                    end
                end
            end            
            
            if sum(TimePoint/100 == linspace(0,1000,1001))==1,
                TimePoint
            end
            aBot.Time(length(aBot.Time)+1)=length(aBot.Time)+2;
        end
    end
end