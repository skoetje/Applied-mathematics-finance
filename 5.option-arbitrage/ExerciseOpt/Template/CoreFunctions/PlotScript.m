%% Preambule
Timevec=1:length(myTradingRobot.StockAskVolumes);
myStrikeVector=[8,9,9.5,9.75,10,10.25,10.5,11,12,14];

%% Plot Call Deltas
hold on
plot(myTradingRobot.Time,myTradingRobot.CallDeltas)
hold off
xlabel('Time','FontSize',15)
ylabel('Call Delta','FontSize',15)
set(gca,'FontSize',13)

%% Plot Put Delta
hold on
plot(myTradingRobot.Time,myTradingRobot.PutDeltas)
hold off
xlabel('Time','FontSize',15)
ylabel('Put Delta','FontSize',15)
set(gca,'FontSize',13)

%% Plot Gamma
subplot(2,1,1)
hold on
plot(myTradingRobot.Time,myTradingRobot.CallGammas)
hold off
xlabel('Time','FontSize',15)
ylabel('Call Gamma','FontSize',15)
set(gca,'FontSize',13)

subplot(2,1,2)
hold on
plot(myTradingRobot.Time,myTradingRobot.PutGammas)
hold off
xlabel('Time','FontSize',15)
ylabel('Put Gamma','FontSize',15)
set(gca,'FontSize',13)

%% Plot Ask/Bid stockprices
hold on
plot(Timevec,Valuate(myTradingRobot.StockAskPrices,myTradingRobot.StockAskVolumes,myTradingRobot.StockBidPrices,myTradingRobot.StockBidVolumes,0.01),'-','Color','red','LineWidth',2)
plot(Timevec,myTradingRobot.StockAskPrices,'-','Color','black','LineWidth',2)
plot(Timevec,myTradingRobot.StockBidPrices,'-','Color','blue','LineWidth',2)
hold off
xlabel('Time','FontSize',15)
ylabel('Price of Stock','FontSize',15)
legend('Valuation','Ask','Bid')
set(gca,'FontSize',13)

%% Plot Ask/Bid stockvolumes
hold on
plot(Timevec,myTradingRobot.StockAskVolumes,'-','Color','blue','LineWidth',3)
plot(Timevec,myTradingRobot.StockBidVolumes,'-','Color','red','LineWidth',3)
hold off
xlabel('Time','FontSize',15)
ylabel('Volume of Stock','FontSize',15)
legend('Ask','Bid')
set(gca,'FontSize',13)

%% Plot optionprices
myOptionPrices=(myTradingRobot.CallOptionBidPrices+myTradingRobot.CallOptionAskPrices)/2;
myStrikeVector=[8,9,9.5,9.75,10,10.25,10.5,11,12,14];
hold on
for i=1:10
    plot(myTradingRobot.Time,myOptionPrices,'-','LineWidth',3)
end
hold off
xlabel('Time')
ylabel('Price of Option')
xlabel('Time','FontSize',15)
ylabel('Price of Option','FontSize',15)
legend('Strike 8', 'Strike 9', 'Strike 9.5', 'Strike 9.75', 'Strike 10', 'Strike 10.25', 'Strike 10.5', 'Strike 11', 'Strike 12', 'Strike 14')
set(gca,'FontSize',13)

%% Plot for Part 4. (bids/asks option prices for 1 timepoint and varying K)
Timepoint=1000;

%CallBid=[myTradingRobot.Call800Struct(Timepoint,4),myTradingRobot.Call900Struct(Timepoint,4),    myTradingRobot.Call950Struct(Timepoint,4),myTradingRobot.Call975Struct(Timepoint,4),    myTradingRobot.Call1000Struct(Timepoint,4),myTradingRobot.Call1025Struct(Timepoint,4),    myTradingRobot.Call1050Struct(Timepoint,4),myTradingRobot.Call1100Struct(Timepoint,4),    myTradingRobot.Call1200Struct(Timepoint,4),myTradingRobot.Call1400Struct(Timepoint,4)];
%CallAsk=[myTradingRobot.Call800Struct(Timepoint,2),myTradingRobot.Call900Struct(Timepoint,2),    myTradingRobot.Call950Struct(Timepoint,2),myTradingRobot.Call975Struct(Timepoint,2),    myTradingRobot.Call1000Struct(Timepoint,2),myTradingRobot.Call1025Struct(Timepoint,2),    myTradingRobot.Call1050Struct(Timepoint,2),myTradingRobot.Call1100Struct(Timepoint,2),    myTradingRobot.Call1200Struct(Timepoint,2),myTradingRobot.Call1400Struct(Timepoint,2)];
%PutBid=[myTradingRobot.Put800Struct(Timepoint,4),myTradingRobot.Put900Struct(Timepoint,4),    myTradingRobot.Put950Struct(Timepoint,4),myTradingRobot.Put975Struct(Timepoint,4),    myTradingRobot.Put1000Struct(Timepoint,4),myTradingRobot.Put1025Struct(Timepoint,4),    myTradingRobot.Put1050Struct(Timepoint,4),myTradingRobot.Put1100Struct(Timepoint,4),    myTradingRobot.Put1200Struct(Timepoint,4),myTradingRobot.Put1400Struct(Timepoint,4)];
%PutAsk=[myTradingRobot.Put800Struct(Timepoint,2),myTradingRobot.Put900Struct(Timepoint,2),    myTradingRobot.Put950Struct(Timepoint,2),myTradingRobot.Put975Struct(Timepoint,2),    myTradingRobot.Put1000Struct(Timepoint,2),myTradingRobot.Put1025Struct(Timepoint,2),    myTradingRobot.Put1050Struct(Timepoint,2),myTradingRobot.Put1100Struct(Timepoint,2),    myTradingRobot.Put1200Struct(Timepoint,2),myTradingRobot.Put1400Struct(Timepoint,2)];

hold on
plot(myStrikeVector,myTradingRobot.CallOptionBidPrices(end,:),'-','Color','blue','LineWidth',3)
plot(myStrikeVector,myTradingRobot.CallOptionAskPrices(end,:),'-','Color','green','LineWidth',3)
plot(myStrikeVector,myTradingRobot.PutOptionBidPrices(end,:),'-','Color','red','LineWidth',3)
plot(myStrikeVector,myTradingRobot.PutOptionAskPrices(end,:),'-','Color','black','LineWidth',3)
hold off
text(810,3.5,strcat('Time= ',num2str(Timepoint)))
xlabel('Strike Price','FontSize',15)
ylabel('Value Option','FontSize',15)
legend('Call bid','Call offer','Put bid','Put offer')
set(gca,'FontSize',13)