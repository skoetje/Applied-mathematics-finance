classdef AnalysisRobot_Strike800 < AutoTrader
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
        
        StockOfferVol
        StockOfferPrice
        StockBidVol
        StockBidPrice
        
        Call800Struct
        Put800Struct
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            aBot.Time(length(aBot.Time)+1)=length(aBot.Time)+1;
            TimePoint=aBot.Time(end);
            
            %Switch between whether the depth concerns option or stock
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
            
            %First we record the results of the shares
            myStock=aBot.StockDepth;
            myStockOfferVol=NaN;
            myStockOfferPrice=NaN;
            myStockBidVol=NaN;
            myStockBidPrice=NaN;

            if (isempty(myStock)==0),
                if (isempty(myStock.askLimitPrice)==0),
                    myStockOfferPrice=myStock.askLimitPrice(1);
                    myStockOfferVol=myStock.askVolume(1);
                end
                if (isempty(myStock.bidLimitPrice)==0),
                    myStockBidPrice=myStock.bidLimitPrice(1);
                    myStockBidVol=myStock.bidVolume(1);
                end
            end

            aBot.StockOfferVol(end+1)=myStockOfferVol;
            aBot.StockOfferPrice(end+1)=myStockOfferPrice;
            aBot.StockBidVol(end+1)=myStockBidVol;
            aBot.StockBidPrice(end+1)=myStockBidPrice;
            
            %Now onto the option recording            
            for i=1:2,
                if i==1,
                    myOption=aBot.Call800Depth;
                elseif i==2,
                    myOption=aBot.Put800Depth;
                end

                %Calculate current depth
                myOptionOfferVol=NaN;
                myOptionOfferPrice=NaN;
                myOptionBidVol=NaN;
                myOptionBidPrice=NaN;          

                if (isempty(myOption)==0),
                    if (isempty(myOption.askLimitPrice)==0),
                        myOptionOfferPrice=myOption.askLimitPrice(1);
                        myOptionOfferVol=myOption.askVolume(1);
                    end
                    if (isempty(myOption.bidLimitPrice)==0),
                        myOptionBidPrice=myOption.bidLimitPrice(1);
                        myOptionBidVol=myOption.bidVolume(1);
                    end
                end
               
                %Record offer/bid prices and volumes
                if i==1,
                    aBot.Call800Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call800Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call800Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call800Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==2,
                    aBot.Put800Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put800Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put800Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put800Struct(TimePoint,4)=myOptionBidPrice;                    
                end
            end
        end
    end
end