classdef AnalysisRobot < AutoTrader
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
        Call900Struct
        Call950Struct
        Call975Struct
        Call1000Struct
        Call1025Struct
        Call1050Struct
        Call1100Struct
        Call1200Struct
        Call1400Struct
        
        Put800Struct
        Put900Struct
        Put950Struct
        Put975Struct
        Put1000Struct
        Put1025Struct
        Put1050Struct
        Put1100Struct
        Put1200Struct
        Put1400Struct
        
        CallDeltaVec
        PutDeltaVec
        CallGammaVec
        PutGammaVec
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
            
            %We also record the Deltas and gammas
            
            aBot.CallDeltaVec(TimePoint)=Delta(aBot,10,TimePoint,1);
            aBot.PutDeltaVec(TimePoint)=Delta(aBot,10,TimePoint,0);
            aBot.CallGammaVec(TimePoint)=Gamma(aBot,10,TimePoint,1);
            aBot.PutGammaVec(TimePoint)=Gamma(aBot,10,TimePoint,0);
            
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
            for i=1:20,
                if i==1,
                    myOption=aBot.Call800Depth;
                elseif i==2,
                    myOption=aBot.Put800Depth;
                elseif i==3,
                    myOption=aBot.Call900Depth;
                elseif i==4,
                    myOption=aBot.Put900Depth;
                elseif i==5,
                    myOption=aBot.Call950Depth;
                elseif i==6,
                    myOption=aBot.Put950Depth;
                elseif i==7,
                    myOption=aBot.Call975Depth;
                elseif i==8,
                    myOption=aBot.Put975Depth;
                elseif i==9,
                    myOption=aBot.Call1000Depth;
                elseif i==10,
                    myOption=aBot.Put1000Depth;
                elseif i==11,
                    myOption=aBot.Call1025Depth;
                elseif i==12,
          
                    myOption=aBot.Put1025Depth;
                elseif i==13,
                    myOption=aBot.Call1050Depth;
                elseif i==14,
                    myOption=aBot.Put1050Depth;
                elseif i==15,
                    myOption=aBot.Call1100Depth;
                elseif i==16,
                    myOption=aBot.Put1100Depth;
                elseif i==17,
                    myOption=aBot.Call1200Depth;
                elseif i==18,
                    myOption=aBot.Put1200Depth;
                elseif i==19,
                    myOption=aBot.Call1400Depth;
                elseif i==20,
                    myOption=aBot.Put1400Depth;
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
                elseif i==3,
                    aBot.Call900Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call900Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call900Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call900Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==4,
                    aBot.Put900Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put900Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put900Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put900Struct(TimePoint,4)=myOptionBidPrice;    
                elseif i==5,
                    aBot.Call950Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call950Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call950Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call950Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==6,
                    aBot.Put950Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put950Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put950Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put950Struct(TimePoint,4)=myOptionBidPrice;    
                elseif i==7,
                    aBot.Call975Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call975Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call975Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call975Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==8,
                    aBot.Put975Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put975Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put975Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put975Struct(TimePoint,4)=myOptionBidPrice;   
                elseif i==9,
                    aBot.Call1000Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call1000Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call1000Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call1000Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==10,
                    aBot.Put1000Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put1000Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put1000Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put1000Struct(TimePoint,4)=myOptionBidPrice;  
                elseif i==11,
                    aBot.Call1025Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call1025Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call1025Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call1025Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==12,
                    aBot.Put1025Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put1025Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put1025Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put1025Struct(TimePoint,4)=myOptionBidPrice; 
                elseif i==13,
                    aBot.Call1050Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call1050Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call1050Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call1050Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==14,
                    aBot.Put1050Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put1050Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put1050Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put1050Struct(TimePoint,4)=myOptionBidPrice; 
                elseif i==15,
                    aBot.Call1100Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call1100Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call1100Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call1100Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==16,
                    aBot.Put1100Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put1100Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put1100Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put1100Struct(TimePoint,4)=myOptionBidPrice;  
                elseif i==17,
                    aBot.Call1200Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call1200Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call1200Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call1200Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==18,
                    aBot.Put1200Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put1200Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put1200Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put1200Struct(TimePoint,4)=myOptionBidPrice;     
                elseif i==19,
                    aBot.Call1400Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Call1400Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Call1400Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Call1400Struct(TimePoint,4)=myOptionBidPrice;
                elseif i==20,
                    aBot.Put1400Struct(TimePoint,1)=myOptionOfferVol;
                    aBot.Put1400Struct(TimePoint,2)=myOptionOfferPrice;
                    aBot.Put1400Struct(TimePoint,3)=myOptionBidVol;
                    aBot.Put1400Struct(TimePoint,4)=myOptionBidPrice;              
                end
            end
        end
    end
end