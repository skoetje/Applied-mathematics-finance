function myGammaPosition = GammaPosition(aBot,aStrikeVec)

myTrades=aBot.ownTrades;
myStockTrades=find(strcmp(myTrades.ISIN,'ING'));
myStockVolumes=zeros(length(myStockTrades),1);

for i=2:length(myStockTrades),
    myStockVolumes(i)=myTrades.volume(myStockTrades(i))*myTrades.side(myStockTrades(i));
end

myStockPosition=sum(myStockVolumes);

myGammaPositions=zeros(10,2);
myOptionISINs=GetAllOptionISINs;

for j=0:1,
    for i=1:length(aStrikeVec),
        myStrike=aStrikeVec(i);
        myGamma=GammaVector(myStrike);
        myOptionDepth=OptionDepth(aBot,myStrike,j);
                
        myOptionTrades=find(strcmp(myTrades.ISIN,myOptionDepth.ISIN));
        myOptionVolumes=zeros(length(myOptionTrades),1);

        for k=2:length(myOptionTrades),
            myOptionVolumes(k)=myTrades.volume(myOptionTrades(k))*myTrades.side(myOptionTrades(k));
        end
        
        myOptionPosition=sum(myTrades.volume(myOptionTrades).*myTrades.side(myOptionTrades));
        
        myGammaPositions(i,j+1)=myOptionPosition*myGamma;
    end
end
myGammaPosition=sum(sum(myGammaPositions))+myStockPosition;%sum(sum(myGammaPositions));

end