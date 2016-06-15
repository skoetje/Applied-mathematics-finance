function myVegaPosition = VegaPosition(aBot,aStrikeVec,aTime)

myTrades=aBot.ownTrades;
myStockTrades=find(strcmp(myTrades.ISIN,'ING'));
myStockVolumes=zeros(length(myStockTrades),1);

for i=2:length(myStockTrades),
    myStockVolumes(i)=myTrades.volume(myStockTrades(i))*myTrades.side(myStockTrades(i));
end

myStockPosition=sum(myStockVolumes);
myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);
mySpot=(aBot.StockDepth.askLimitPrice(1)+aBot.StockDepth.bidLimitPrice(1))/2;

myVegaPositions=zeros(10,2);

for j=0:1,
    for i=1:length(aStrikeVec),
        myStrike=aStrikeVec(i);
        myOptionDepth=OptionDepth(aBot,myStrike,j);
        mySigma=NaN;
        if isempty(myOptionDepth)==0,
            if isempty(myOptionDepth.askLimitPrice)==0 && isempty(myOptionDepth.bidLimitPrice)==0,
                myOptionSpot=(myOptionDepth.askLimitPrice+myOptionDepth.bidLimitPrice)/2;
                mySigma=bisection(mySpot,myStrike,myExpiry,myOptionSpot,j);
            end
        end
        myVega=Vega(mySpot,myStrike,myExpiry,0,mySigma);
                
        myOptionTrades=find(strcmp(myTrades.ISIN,myOptionDepth.ISIN));
        myOptionVolumes=zeros(length(myOptionTrades),1);

        for k=2:length(myOptionTrades),
            myOptionVolumes(k)=myTrades.volume(myOptionTrades(k))*myTrades.side(myOptionTrades(k));
        end
        
        myOptionPosition=sum(myTrades.volume(myOptionTrades).*myTrades.side(myOptionTrades));
        
        myVegaPositions(i,j+1)=myOptionPosition*myVega;
    end
end
myVegaPosition=nansum(nansum(myVegaPositions))+myStockPosition;%sum(sum(myGammaPositions));

end