classdef AnalysisRobot < AutoTrader
    properties
        StockDepth
        CallOptionDepth
        PutOptionDepth
        
        StockOfferVol
        StockOfferPrice
        StockBidVol
        StockBidPrice
        
        CallOptionOfferVol
        CallOptionOfferPrice
        CallOptionBidVol
        CallOptionBidPrice
        
        PutOptionOfferVol
        PutOptionOfferPrice
        PutOptionBidVol
        PutOptionBidPrice
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            
            %Switch between whether the depth concerns option or stock
            switch aDepth.ISIN
                case 'ING'; aBot.StockDepth = aDepth;
                otherwise; 
                    if sum(aDepth.ISIN(12:14)=='PUT')==3,
                        aBot.PutOptionDepth = aDepth;
                    else
                        aBot.CallOptionDepth = aDepth;
                    end
            end
            
            myStock=aBot.StockDepth;
            myCallOption=aBot.CallOptionDepth;
            myPutOption=aBot.PutOptionDepth;
            
            %Calculate current depth
            myStockOfferVol=NaN;
            myStockOfferPrice=NaN;
            myStockBidVol=NaN;
            myStockBidPrice=NaN;
            myCallOptionOfferVol=NaN;
            myCallOptionOfferPrice=NaN;
            myCallOptionBidVol=NaN;
            myCallOptionBidPrice=NaN;    
            myPutOptionOfferVol=NaN;
            myPutOptionOfferPrice=NaN;
            myPutOptionBidVol=NaN;
            myPutOptionBidPrice=NaN;            
            
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
            
            if (isempty(myCallOption)==0),
                if (isempty(myCallOption.askLimitPrice)==0),
                    myCallOptionOfferPrice=myCallOption.askLimitPrice(1);
                    myCallOptionOfferVol=myCallOption.askVolume(1);
                end
                if (isempty(myCallOption.bidLimitPrice)==0),
                    myCallOptionBidPrice=myCallOption.bidLimitPrice(1);
                    myCallOptionBidVol=myCallOption.bidVolume(1);
                end
            end
            
            if (isempty(myPutOption)==0),
                if (isempty(myPutOption.askLimitPrice)==0),
                    myPutOptionOfferPrice=myPutOption.askLimitPrice(1);
                    myPutOptionOfferVol=myPutOption.askVolume(1);
                end
                if (isempty(myPutOption.bidLimitPrice)==0),
                    myPutOptionBidPrice=myPutOption.bidLimitPrice(1);
                    myPutOptionBidVol=myPutOption.bidVolume(1);
                end
            end
            
            %Record offer/bid prices and volumes
            aBot.StockOfferVol(end+1)=myStockOfferVol;
            aBot.StockOfferPrice(end+1)=myStockOfferPrice;
            aBot.StockBidVol(end+1)=myStockBidVol;
            aBot.StockBidPrice(end+1)=myStockBidPrice;
            
            aBot.CallOptionOfferVol(end+1)=myCallOptionOfferVol;
            aBot.CallOptionOfferPrice(end+1)=myCallOptionOfferPrice;
            aBot.CallOptionBidVol(end+1)=myCallOptionBidVol;
            aBot.CallOptionBidPrice(end+1)=myCallOptionBidPrice;
            
            aBot.PutOptionOfferVol(end+1)=myPutOptionOfferVol;
            aBot.PutOptionOfferPrice(end+1)=myPutOptionOfferPrice;
            aBot.PutOptionBidVol(end+1)=myPutOptionBidVol;
            aBot.PutOptionBidPrice(end+1)=myPutOptionBidPrice;
        end
    end
end