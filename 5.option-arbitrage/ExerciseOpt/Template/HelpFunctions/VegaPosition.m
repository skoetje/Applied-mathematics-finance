function myVegaPosition = VegaPosition(aBot,aStrikeVec)

myTrades=aBot.ownTrades;
myStockTrades=find(strcmp(myTrades.ISIN,'ING'));
myStockVolumes=zeros(length(myStockTrades),1);

for i=2:length(myStockTrades),
    myStockVolumes(i)=myTrades.volume(myStockTrades(i))*myTrades.side(myStockTrades(i));
end

myStockPosition=sum(myStockVolumes);


mySpot=(aBot.StockDepth.askLimitPrice(1)+aBot.StockDepth.bidLimitPrice(1))/2;

myVegaPositions=zeros(10,2);

for j=0:1,
    for i=1:length(aStrikeVec),
        myStrike=aStrikeVec(i);
        myOptionDepth=OptionDepth(aBot,myStrike,j);
        myOptionSpot=(myOptionDepth.askLimitPrice(1)+myOptionDepth.bidLimitPrice(1))/2;
        mySigma=?????????????????????????????????;
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
myVegaPosition=sum(sum(myVegaPositions))+myStockPosition;%sum(sum(myGammaPositions));

end