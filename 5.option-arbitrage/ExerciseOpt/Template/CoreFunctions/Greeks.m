function Greeks(aBot)

myTrades=aBot.ownTrades;
TradesTime=myTrades.timestamp;
myStockTrades=find(strcmp(myTrades.ISIN,'ING'));
myStockPosition=zeros(length(myStockTrades),1);
myStockVolumes=zeros(length(myStockTrades),1);

for i=2:length(myStockTrades),
    myStockVolumes(i)=myTrades.volume(myStockTrades(i))*myTrades.side(myStockTrades(i));
    myStockPosition(i)=sum(myStockVolumes(1:i));
end

myCallDeltas=aBot.CallDeltas;
myCallGammas=aBot.CallGammas;
myCallVegas=aBot.CallVegas;
myPutDeltas=aBot.PutDeltas;
myPutGammas=aBot.PutGammas;
myPutVegas=aBot.PutVegas;

myDeltaposition=zeros(length(myCallDeltas),1);
for i=1:length(myTrades),
    myStockTrades=find(strcmp(myTrades.ISIN,'ING'));
    myAssetPosition(i)=myTrades.volume(myStockTrades(i))*myTrades.side(myStockTrades(i));
    myDeltaposition(i)=myCallDeltas
    
    
end
end