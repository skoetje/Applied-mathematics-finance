clear myExchange;
clear myFeedPublisher;
clear myTradingRobot;

load('CBKDBK2.mat');

myExchange = CreateExchangeCor();

myFeedPublisher = FeedPublisher();
myExchange.RegisterAutoTrader(myFeedPublisher);
myFeedPublisher.StartAutoTrader(myExchange);

myTradingRobot = TradingRobot();
myExchange.RegisterAutoTrader(myTradingRobot);
myTradingRobot.StartAutoTrader(myExchange);

myFeedPublisher.StartFeed(myFeed);

myTradingRobot.Unwind();
%PlotMarket(myTradingRobot)
Report(myTradingRobot.ownTrades);


