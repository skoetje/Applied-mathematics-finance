function myGamma=Gamma(aBot,aStrike,aTime,aBoolean)
if aStrike==10,
    myCallOptionDepth=aBot.Call1000Depth;
    myPutOptionDepth=aBot.Put1000Depth;
end
myStrike=aStrike;
myInterest=0;
myExpiry=(1000000-aTime)/1000000;

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
myDeltaVec=[NaN,NaN,NaN];
myPerturbation=[-0.01,0,0.01];

%Gamma determined looking at call options
if isempty(myCallOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==1,
    if isempty(myCallOptionDepth.askLimitPrice)==0,
        myCallAskP=myCallOptionDepth.askLimitPrice;
        mySigma=ImpliedVolatility(mySpot0,myStrike,myExpiry,myCallAskP,1);
        for i=1:3,
            mySpot=mySpot0+myPerturbation(i);
            myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,mySigma);
            myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,mySigma);
            myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,mySigma);
            myValueVec=[myValue1,myValue2,myValue3];
            myGradientVec=gradient(myValueVec)/0.01;
            myDelta=myGradientVec(2);
            myDeltaVec(i)=myDelta;
        end
        myGradientVec2=gradient(myDeltaVec)/0.01;
        myGamma=myGradientVec2(2);
    elseif isempty(myCallOptionDepth.bidLimitPrice)==0,
        myCallBidP=myCallOptionDepth.bidLimitPrice;
        mySigma=ImpliedVolatility(mySpot0,myStrike,myExpiry,myCallBidP,1);
        for i=1:3,
            mySpot=mySpot0+myPerturbation(i);
            myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,mySigma);
            myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,mySigma);
            myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,mySigma);
            myValueVec=[myValue1,myValue2,myValue3];
            myGradientVec=gradient(myValueVec)/0.01;
            myDelta=myGradientVec(2);
            myDeltaVec(i)=myDelta;
        end
        myGradientVec2=gradient(myDeltaVec)/0.01;
        myGamma=myGradientVec2(2);
    end
end

%Delta determined looking at put options, in case there are no call options
if isempty(myPutOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==0,
    if isempty(myPutOptionDepth.askLimitPrice)==0,
        myPutAskP=myPutOptionDepth.askLimitPrice;
        mySigma=ImpliedVolatility(mySpot0,myStrike,myExpiry,myPutAskP,0);
        for i=1:3,
            mySpot=mySpot0+myPerturbation(i);
            [a,myValue1]=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,mySigma);
            [a,myValue2]=BlackScholes(mySpot,myStrike,myExpiry,myInterest,mySigma);
            [a,myValue3]=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,mySigma);
            myValueVec=[myValue1,myValue2,myValue3];
            myGradientVec=gradient(myValueVec)/0.01;
            myDelta=myGradientVec(2);
            myDeltaVec(i)=myDelta;
        end
        myGradientVec2=gradient(myDeltaVec)/0.01;
        myGamma=myGradientVec2(2);
    elseif isempty(myPutOptionDepth.bidLimitPrice)==0,
        myPutBidP=myPutOptionDepth.bidLimitPrice;
        mySigma=ImpliedVolatility(mySpot0,myStrike,myExpiry,myPutBidP,0);
        for i=1:3,
            mySpot=mySpot0+myPerturbation(i);
            [a,myValue1]=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,mySigma);
            [a,myValue2]=BlackScholes(mySpot,myStrike,myExpiry,myInterest,mySigma);
            [a,myValue3]=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,mySigma);
            myValueVec=[myValue1,myValue2,myValue3];
            myGradientVec=gradient(myValueVec)/0.01;
            myDelta=myGradientVec(2);
            myDeltaVec(i)=myDelta;
        end
        myGradientVec2=gradient(myDeltaVec)/0.01;
        myGamma=myGradientVec2(2);
    end
end
end