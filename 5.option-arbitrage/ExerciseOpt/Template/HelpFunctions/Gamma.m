function myGamma=Gamma(aBot,aStrike,aTime,aBoolean)
if aStrike==10,
    myCallOptionDepth=aBot.Call1000Depth;
    myPutOptionDepth=aBot.Put1000Depth;
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

myGamma=NaN;
mySpot0=mySpot;
myDeltaVec=zeros(3,1);
myPerturbation=[-0.01,0,0.01];

%Gamma determined looking at call options
if isempty(myCallOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==1,
    for i=1:3,
        mySpot=mySpot0+myPerturbation(i);
        myDelta=NaN;
        myCallAskP=myCallOptionDepth.askLimitPrice;
        myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
        myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
        myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
        myValueVec=[myValue1,myValue2,myValue3];
        myGradientVec=gradient(myValueVec)/0.01;
        myDelta=myGradientVec(2);
        myDeltaVec(i)=myDelta;
    end
    myGradientVec2=gradient(myDeltaVec)/0.01;
    myGamma=myGradientVec2(2);
end

%Delta determined looking at put options, in case there are no call options
if isempty(myPutOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==0,
    for i=1:3,
        mySpot=mySpot0+myPerturbation(i);
        myDelta=NaN;
        myPutAskP=myPutOptionDepth.askLimitPrice;
        myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,0));
        myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,0));
        myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,0));
        myValueVec=[myValue1,myValue2,myValue3];
        myGradientVec=gradient(myValueVec)/0.01;
        myDelta=myGradientVec(2);
        myDeltaVec(i)=myDelta;
    end
    myGradientVec2=gradient(myDeltaVec)/0.01;
    myGamma=myGradientVec2(2);
end
end