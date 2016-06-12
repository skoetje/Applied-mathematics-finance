function myDelta=Delta2(aBot,aStrike,aTime,aBoolean)
if aStrike==10,
    myCallOptionDepth=aBot.Call1000Depth;
    myPutOptionDepth=aBot.Put1000Depth;
end

myStrike=aStrike;
myInterest=0;
myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);

if isempty(aBot.StockDepth)==0,
    if isempty(aBot.StockDepth.askVolume)==0,
        mySpot=aBot.StockDepth.askLimitPrice(1);
    end
    if isempty(aBot.StockDepth.bidVolume)==0,
        mySpot=aBot.StockDepth.bidLimitPrice(1);
    end
    if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
        mySpot=Valuate(aBot.StockDepth.askLimitPrice(1), aBot.StockDepth.askVolume(1), aBot.StockDepth.bidLimitPrice(1), aBot.StockDepth.bidVolume(1), 0.01);
    end
end

myDelta=NaN;

%Delta determined looking at call options
if isempty(myCallOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==1,
    myDelta=0.6742+0.3193*(mySpot-aBot.);
end

%Delta determined looking at put options, in case there are no call options
if isempty(myPutOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==0,
    myDelta=-0.3256+0.3193*(mySpot-10.4);
end
end