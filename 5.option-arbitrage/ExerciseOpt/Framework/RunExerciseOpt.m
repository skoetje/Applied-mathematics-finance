clear myExchange;
clear myFeedPublisher;
clear myOptionsQuoter;
clear myTradingRobot;

load('ING4.mat');

myExchange = CreateExchangeOpt();

myFeedPublisher = FeedPublisher();
myExchange.RegisterAutoTrader(myFeedPublisher);
myFeedPublisher.StartAutoTrader(myExchange);

myOptionsQuoter = OptionsQuoter();
myExchange.RegisterAutoTrader(myOptionsQuoter);
myOptionsQuoter.StartAutoTrader(myExchange, myFeedPublisher);

myTradingRobot = TradingRobot();
myExchange.RegisterAutoTrader(myTradingRobot);
myTradingRobot.StartAutoTrader(myExchange);

myFeedPublisher.StartVeryShortFeed(myFeed);

Report_Trading(myTradingRobot);