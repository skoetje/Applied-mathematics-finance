clear myExchange;
clear myFeedPublisher;
clear myTradingRobot;

load('CBKDBK1.mat');

myExchange = CreateExchangeCor();

myFeedPublisher = FeedPublisher();
myExchange.RegisterAutoTrader(myFeedPublisher);
myFeedPublisher.StartAutoTrader(myExchange);

myTradingRobot = AnalysisRobot();
myExchange.RegisterAutoTrader(myTradingRobot);
myTradingRobot.StartAutoTrader(myExchange);

myFeedPublisher.StartShortFeed(myFeed);

%myTradingRobot.Unwind();
PlotMarket(myTradingRobot)
%Report(myTradingRobot.ownTrades);


