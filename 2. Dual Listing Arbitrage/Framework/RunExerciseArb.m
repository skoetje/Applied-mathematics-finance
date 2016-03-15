clear myExchange;
clear myFeedPublisher;
clear myTradingRobot;

load('AKZA1.mat');

myExchange = CreateExchangeArb();

myFeedPublisher = FeedPublisher();
myExchange.RegisterAutoTrader(myFeedPublisher);
myFeedPublisher.StartAutoTrader(myExchange);

myTradingRobot = TradingRobot();
myExchange.RegisterAutoTrader(myTradingRobot);
myTradingRobot.StartAutoTrader(myExchange);

myFeedPublisher.StartShortFeed(myFeed);

Report(myTradingRobot.ownTrades);
