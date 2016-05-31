%% Preambule
Timevec=1:length(myTradingRobot.StockOfferPrice);

%% Plot Ask/Bid stockprices
hold on
plot(Timevec,myTradingRobot.StockOfferPrice,'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.StockBidPrice,'-','Color','red','LineWidth',3)
plot(Timevec,Valuate(myTradingRobot.StockOfferPrice,myTradingRobot.StockOfferVol,myTradingRobot.StockBidPrice,myTradingRobot.StockBidVol,0.01),'-','Color','green','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Price of Stock','FontSize',15)
legend('Ask','Bid','Valuation')
set(gca,'FontSize',13)

%% Plot Ask/Bid stockvolumes
hold on
plot(Timevec,myTradingRobot.StockOfferVol,'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.StockBidVol,'-','Color','red','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Volume of Stock','FontSize',15)
legend('Ask','Bid')
set(gca,'FontSize',13)

%% Plot Fraction of Bid wrt total
hold on
plot(Timevec,myTradingRobot.StockOfferVol./(myTradingRobot.StockOfferVol+myTradingRobot.StockBidVol),'-','Color','blue','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Fraction of first layer that is offered','FontSize',15)
set(gca,'FontSize',13)

%% Plot optionprices
hold on
plot(Timevec,myTradingRobot.Call800Struct(:,2),'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.Call800Struct(:,4),'-','Color','green','LineWidth',3)
plot(Timevec,myTradingRobot.Put800Struct(:,2),'-','Color','red','LineWidth',3)
plot(Timevec,myTradingRobot.Put800Struct(:,4),'-','Color','black','LineWidth',3)
hold off
xlabel('Time')
ylabel('Price of Option')
xlabel('Time','FontSize',15)
ylabel('Price of Option','FontSize',15)
legend('Call offer','Call bid','Put offer','Put bid')
set(gca,'FontSize',13)

%% Plot optionvolumes
hold on
plot(Timevec,myTradingRobot.Call800Struct(:,1),'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.Call800Struct(:,3),'-','Color','green','LineWidth',3)
plot(Timevec,myTradingRobot.Put800Struct(:,1),'-','Color','red','LineWidth',3)
plot(Timevec,myTradingRobot.Put800Struct(:,3),'-','Color','black','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Volume of Stock','FontSize',15)
legend('Call offer','Call bid','Put offer','Put bid')
set(gca,'FontSize',13)