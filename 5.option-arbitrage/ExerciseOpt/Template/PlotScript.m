%% Preambule
Timevec=1:length(myTradingRobot.StockOfferPrice);

%% Plot Ask/Bid stockprices
hold on
plot(Timevec,myTradingRobot.StockOfferPrice,'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.StockBidPrice,'-','Color','red','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Price of Stock','FontSize',15)
legend('Ask','Bid')
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

%% Plot optionprices
hold on
plot(Timevec,myTradingRobot.CallOptionOfferPrice,'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.PutOptionOfferPrice,'-','Color','red','LineWidth',3)
hold off
xlabel('Time')
ylabel('Price of Option')
xlabel('Time','FontSize',15)
ylabel('Price of Option','FontSize',15)
legend('Call','Put')
set(gca,'FontSize',13)

%% Plot optionvolumes
hold on
plot(Timevec,myTradingRobot.CallOptionOfferVol,'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.PutOptionOfferVol,'-','Color','red','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Volume of Stock','FontSize',15)
legend('Call','Put')
set(gca,'FontSize',13)