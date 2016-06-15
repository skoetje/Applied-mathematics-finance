
myTrades=myTradingRobot.ownTrades;
TradesTime=myTrades.timestamp;

myStockTrades=find(strcmp(myTrades.ISIN,'ING'));

myStockPosition=zeros(length(myStockTrades),1);
myStockVolumes=zeros(length(myStockTrades),1);
for i=2:length(myStockTrades),
    myStockVolumes(i)=myTrades.volume(myStockTrades(i))*myTrades.side(myStockTrades(i));
    myStockPosition(i)=sum(myStockVolumes(1:i));
end
%%
plot(TradesTime(myStockTrades)/(TradesTime(end)),myStockPosition,'-','Color','black','LineWidth',2)
xlabel('Time','FontSize',15)
ylabel('Stock position','FontSize',15)
set(gca,'XTick',[])
set(gca,'FontSize',13)

%%
hist(myStockVolumes,25)
xlabel('Size of trade','FontSize',15)
ylabel('Frequency','FontSize',15)
set(gca,'FontSize',13)

%%