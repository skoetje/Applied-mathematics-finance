clear myExchange;
clear myFeedPublisher;
clear myOptionsQuoter;
clear myTradingRobot;

load('ING3.mat');

myExchange = CreateExchangeOpt();

myFeedPublisher = FeedPublisher();
myExchange.RegisterAutoTrader(myFeedPublisher);
myFeedPublisher.StartAutoT rader(myExchange);

myOptionsQuoter = OptionsQuoter();
myExchange.RegisterAutoTrader(myOptionsQuoter);
myOptionsQuoter.StartAutoTrader(myExchange, myFeedPublisher);

myTradingRobot = AnalysisRobot_final();
myExchange.RegisterAutoTrader(myTradingRobot);
myTradingRobot.StartAutoTrader(myExchange);

myFeedPublisher.StartFeed(myFeed);

Report_Analysis(myTradingRobot);