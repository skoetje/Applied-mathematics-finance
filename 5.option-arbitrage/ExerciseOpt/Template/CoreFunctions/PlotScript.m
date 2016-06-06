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
plot(Timevec,myTradingRobot.Call1000Struct(:,2),'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.Call1000Struct(:,4),'-','Color','green','LineWidth',3)
plot(Timevec,myTradingRobot.Put1000Struct(:,2),'-','Color','red','LineWidth',3)
plot(Timevec,myTradingRobot.Put1000Struct(:,4),'-','Color','black','LineWidth',3)
hold off
xlabel('Time')
ylabel('Price of Option')
xlabel('Time','FontSize',15)
ylabel('Price of Option','FontSize',15)
legend('Call offer','Call bid','Put offer','Put bid')
set(gca,'FontSize',13)

%% Plot optionprices SPREAD
hold on
plot(Timevec,myTradingRobot.Call800Struct(:,2),'-','Color','green','LineWidth',3)
plot(Timevec,myTradingRobot.Call1000Struct(:,2),'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.Call1400Struct(:,2),'-','Color','magenta','LineWidth',3)
plot(Timevec,myTradingRobot.Put800Struct(:,2),'-','Color','yellow','LineWidth',3)
plot(Timevec,myTradingRobot.Put1000Struct(:,2),'-','Color','red','LineWidth',3)
plot(Timevec,myTradingRobot.Put1400Struct(:,2),'-','Color','black','LineWidth',3)
hold off
xlabel('Time')
ylabel('Price of Option')
xlabel('Time','FontSize',15)
ylabel('Price of Option','FontSize',15)
legend('Call 800','Call 1000', 'Call 1400', 'Put 800', 'Put 1000', 'Put 1400')
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

%% Plot for Part 4. (bids/asks option prices for 1 timepoint and varying K)
Timepoint=length(myTradingRobot.Call800Struct(:,1));
CallBid=[myTradingRobot.Call800Struct(Timepoint,4),myTradingRobot.Call900Struct(Timepoint,4),    myTradingRobot.Call950Struct(Timepoint,4),myTradingRobot.Call975Struct(Timepoint,4),    myTradingRobot.Call1000Struct(Timepoint,4),myTradingRobot.Call1025Struct(Timepoint,4),    myTradingRobot.Call1050Struct(Timepoint,4),myTradingRobot.Call1100Struct(Timepoint,4),    myTradingRobot.Call1200Struct(Timepoint,4),myTradingRobot.Call1400Struct(Timepoint,4)];
CallAsk=[myTradingRobot.Call800Struct(Timepoint,2),myTradingRobot.Call900Struct(Timepoint,2),    myTradingRobot.Call950Struct(Timepoint,2),myTradingRobot.Call975Struct(Timepoint,2),    myTradingRobot.Call1000Struct(Timepoint,2),myTradingRobot.Call1025Struct(Timepoint,2),    myTradingRobot.Call1050Struct(Timepoint,2),myTradingRobot.Call1100Struct(Timepoint,2),    myTradingRobot.Call1200Struct(Timepoint,2),myTradingRobot.Call1400Struct(Timepoint,2)];
PutBid=[myTradingRobot.Put800Struct(Timepoint,4),myTradingRobot.Put900Struct(Timepoint,4),    myTradingRobot.Put950Struct(Timepoint,4),myTradingRobot.Put975Struct(Timepoint,4),    myTradingRobot.Put1000Struct(Timepoint,4),myTradingRobot.Put1025Struct(Timepoint,4),    myTradingRobot.Put1050Struct(Timepoint,4),myTradingRobot.Put1100Struct(Timepoint,4),    myTradingRobot.Put1200Struct(Timepoint,4),myTradingRobot.Put1400Struct(Timepoint,4)];
PutAsk=[myTradingRobot.Put800Struct(Timepoint,2),myTradingRobot.Put900Struct(Timepoint,2),    myTradingRobot.Put950Struct(Timepoint,2),myTradingRobot.Put975Struct(Timepoint,2),    myTradingRobot.Put1000Struct(Timepoint,2),myTradingRobot.Put1025Struct(Timepoint,2),    myTradingRobot.Put1050Struct(Timepoint,2),myTradingRobot.Put1100Struct(Timepoint,2),    myTradingRobot.Put1200Struct(Timepoint,2),myTradingRobot.Put1400Struct(Timepoint,2)];
Strikes=[800,900,950,975,1000,1025,1050,1100,1200,1400];

hold on
plot(Strikes,CallBid,'-','Color','blue','LineWidth',3)
plot(Strikes,CallAsk,'-','Color','green','LineWidth',3)
plot(Strikes,PutBid,'-','Color','red','LineWidth',3)
plot(Strikes,PutAsk,'-','Color','black','LineWidth',3)
hold off
text(810,3.5,strcat('Time= ',num2str(Timepoint)))
xlabel('Time','FontSize',15)
ylabel('Volume of Stock','FontSize',15)
legend('Call bid','Call offer','Put bid','Put offer')
set(gca,'FontSize',13)