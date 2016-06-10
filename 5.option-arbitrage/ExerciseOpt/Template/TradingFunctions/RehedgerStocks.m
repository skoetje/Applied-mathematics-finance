function RehedgerStocks(aBot,aTime)
%First consider only strikes of 10
myStrike=10;
myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);
aTrades=aBot.ownTrades;
myING = zeros(length(aTrades.side),2);
options = GetAllOptionISINs();

for i = 1:length(aTrades.side),
    page = find(strcmp(aTrades.ISIN(i),options));
    if isempty(page) == 1,
        myING(i,1) = aTrades.volume(i)* aTrades.side(i);
        myING(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
    end
end

if isempty(aBot.StockDepth)==0,
    if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0 && isempty(aBot.Call1000Depth)==0,
        %mySpot = Valuate(aBot.StockDepth.askLimitPrice(1), aBot.StockDepth.askVolume(1), aBot.StockDepth.bidLimitPrice(1), aBot.StockDepth.bidVolume(1), 0.01);
        
%         if aBot.ownTrades.side(end)==1,
%             myCallDeltaChange = (mySpot-aBot.SpotHistory(end))*0.3193;
%         elseif aBot.ownTrades.side(end)==-1,
%             myCallDeltaChange = (mySpot-aBot.SpotHistory(end))*0.3193;
%         end
        %myCallDeltaChange = (mySpot-aBot.SpotHistory(end))*0.3193;
        %myCallDeltaChange = (mySpot-aBot.ownTrades.price(end))*0.3193;
        
        if sign(aBot.StockDepth.bidLimitPrice(1)-aBot.BidHistory(end))==sign(aBot.StockDepth.askLimitPrice(1)-aBot.AskHistory(end)),
            mySpot = (aBot.StockDepth.askLimitPrice(1)+aBot.StockDepth.bidLimitPrice(1))/2;
            myCallDeltaChange = (mySpot-aBot.SpotHistory(end))*0.3193;
            %myCallDeltaChangeAsk = (aBot.StockDepth.askLimitPrice(1)-aBot.AskHistory(end))*0.3193;
            %myCallDeltaChangeBid = (aBot.StockDepth.bidLimitPrice(1)-aBot.BidHistory(end))*0.3193;
            %if abs(round(aBot.ownTrades.volume(1)*myCallDeltaChange)) >= 1,
            if myCallDeltaChange > 0.00001,
                myBidStockV=abs(round(aBot.ownTrades.volume(1)*myCallDeltaChange));
                myBidStockP=aBot.StockDepth.bidLimitPrice(1);
                if myBidStockP> mean(aBot.BidHistory((end-1):end)),
                    aBot.StockDepth.bidVolume(1) = aBot.StockDepth.bidVolume(1) - myBidStockV;
                    aBot.SendNewOrder(myBidStockP, myBidStockV,  -1, {'ING'}, {'IMMEDIATE'}, aTime);
                end
            end
            if myCallDeltaChange < -0.00001,
                myAskStockV=abs(round(aBot.ownTrades.volume(1)*myCallDeltaChange));
                myAskStockP=aBot.StockDepth.askLimitPrice(1);

                if myAskStockP< mean(aBot.AskHistory((end-1):end)),
                    aBot.StockDepth.askVolume(1) = aBot.StockDepth.askVolume(1) - myAskStockV;
                    aBot.SendNewOrder(myAskStockP, myAskStockV,  1, {'ING'}, {'IMMEDIATE'}, aTime);
                end
            end
        end
    end
end
end