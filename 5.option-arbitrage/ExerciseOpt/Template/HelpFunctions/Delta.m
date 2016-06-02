function myDelta=Delta(aBot,aStrike)
if aStrike==10,
    aCallOptionDepth=aBot.Call1000Depth;
    aPutOptionDepth=aBot.Put1000Depth;
end

myStrike=aStrike;
myInterest=0;

%Delta determined looking at call options
if isempty(aCallOptionDepth)==0 && isempty(aBot.StockDepth)==0,
    mySpot=Valuate(aBot.StockDepth.askLimitPrice, aBot.StockDepth.askVolume,aBot.StockDepth.bidLimitPrice, aBot.StockDepth.bidVolume, aTickSize);
    myValueVec=(blackscholes(myStrike(
    
    myCallAskP=aBot.Call1000Depth.askLimitPrice;
    myCallAskV=aBot.Call1000Depth.askVolume;
    mySpotBidP=aBot.StockDepth.bidLimitPrice(1);
    mySpotBidV=aBot.StockDepth.bidVolume(1);
    
    if isempty(aBot.Call1000Depth.askVolume)==0 && isempty(aBot.Put1000Depth.bidVolume)==0 && isempty(aBot.StockDepth.bidVolume)==0,
    end
end

%Delta determined looking at put options, in case there are no call options
if isempty(aPutOptionDepth)==0 && isempty(aBot.StockDepth)==0,
    
end

myGradientVec=gradient(myValueVec)/0.01;
myDelta=myGradientVec(2);
end