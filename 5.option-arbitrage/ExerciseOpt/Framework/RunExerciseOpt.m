clear myExchange;
clear myFeedPublisher;
clear myOptionsQuoter;
clear myTradingRobot;

<<<<<<< HEAD
load('ING1.mat');
=======
<<<<<<< HEAD
load('ING2.mat');
=======
load('ING3.mat');
>>>>>>> ab8907186c3711503179a3329ab0f502bc9295c9
>>>>>>> 61eff5b3c907dc206fcb9e112c4eccbd7043741b

myExchange = CreateExchangeOpt();

myFeedPublisher = FeedPublisher();
myExchange.RegisterAutoTrader(myFeedPublisher);
myFeedPublisher.StartAutoTrader(myExchange);

myOptionsQuoter = OptionsQuoter();
myExchange.RegisterAutoTrader(myOptionsQuoter);
myOptionsQuoter.StartAutoTrader(myExchange, myFeedPublisher);

myTradingRobot = AnalysisRobot_final();
myExchange.RegisterAutoTrader(myTradingRobot);
myTradingRobot.StartAutoTrader(myExchange);

myFeedPublisher.StartVeryShortFeed(myFeed);

Report_Analysis(myTradingRobot);