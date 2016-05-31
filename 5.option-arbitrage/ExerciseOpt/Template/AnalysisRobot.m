classdef AnalysisRobot < AutoTrader
    properties
        StockDepth
        OptionDepth
        
        StockOfferVol
        StockOfferPrice
        StockBidVol
        StockBidPrice
        
        OptionOfferVol
        OptionOfferPrice
        OptionBidVol
        OptionBidPrice
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            
            %Switch between whether the depth concerns option or stock
            switch aDepth.ISIN
                case 'ING'; aBot.StockDepth = aDepth;
                otherwise; aBot.OptionDepth = aDepth;
            end
            myStock=aBot.StockDepth;
            myOption=aBot.OptionDepth;
            
            %Calculate 
            myStockOfferVol=NaN;
            myStockOfferPrice=NaN;
            myStockBidVol=NaN;
            myStockBidPrice=NaN;
            myOptionOfferVol=NaN;
            myOptionOfferPrice=NaN;
            myOptionBidVol=NaN;
            myOptionBidPrice=NaN;            
            
            if (isempty(myStock)==0),
                if (isempty(myStock.askLimitPrice)==0),
                    myStockOfferPrice=myStock.askLimitPrice(1);
                    myStockOfferVol=myStock.askVolume(1);
                end
            end
            
            %Record offer/bid prices and volumes
            aBot.StockOfferVol(end+1)=myStockOfferVol;
            aBot.StockOfferPrice(end+1)=myStockOfferPrice;
            aBot.StockBidVol(end+1)=myStockBidVol;
            aBot.StockBidPrice(end+1)=myStockBidPrice;
            
            aBot.OptionOfferVol(end+1)=myOptionOfferVol;
            aBot.OptionOfferPrice(end+1)=myOptionOfferPrice;
            aBot.OptionBidVol(end+1)=myOptionBidVol;
            aBot.OptionBidPrice(end+1)=myOptionBidPrice;
        end
    end
end