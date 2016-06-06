function myDelta=Delta(aBot,aStrike,aTime)
if aStrike==10,
    aCallOptionDepth=aBot.Call1000Depth;
    aPutOptionDepth=aBot.Put1000Depth;
end

myStrike=aStrike;
myInterest=0;
myExpiry=(168441-aTime)/168441;

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
if isempty(aCallOptionDepth)==0 && isempty(aBot.StockDepth)==0,
    myCallAskP=aBot.Call1000Depth.askLimitPrice;
    myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
    myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
    myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
    myValueVec=[myValue1,myValue2,myValue3];
    myGradientVec=gradient(myValueVec)/0.01;
    myDelta=myGradientVec(2);
end

%Delta determined looking at put options, in case there are no call options
if isempty(aPutOptionDepth)==0 && isempty(aBot.StockDepth)==0,
    myPutAskP=aBot.Put1000Depth.askLimitPrice;
    [a,myValue1]=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,1));
    [a,myValue2]=BlackScholes(mySpot,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,1));
    [a,myValue3]=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,1));
    myValueVec=[myValue1,myValue2,myValue3];   
    myGradientVec=gradient(myValueVec)/0.01;
    myDelta=myGradientVec(2); 
end

end