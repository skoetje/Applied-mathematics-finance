function myGamma=Gamma(aBot,aStrike,aTime,aBoolean)

myOptionDepth=OptionDepth(aBot,aStrike,aBoolean);

myStrike=aStrike;
myInterest=0;
myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);

if isempty(aBot.StockDepth)==0,
    if isempty(aBot.StockDepth.askVolume)==0,
        mySpot=NaN;
    end
    if isempty(aBot.StockDepth.bidVolume)==0,
        mySpot=NaN;
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
if isempty(myOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==1,
    if isempty(myOptionDepth.askLimitPrice)==0,
        myCallAskP=myOptionDepth.askLimitPrice;
        mySigma=blsimpv(mySpot0,myStrike,0,myExpiry,myCallAskP);
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
    elseif isempty(myOptionDepth.bidLimitPrice)==0,
        myCallBidP=myOptionDepth.bidLimitPrice;
        mySigma=blsimpv(mySpot0,myStrike,0,myExpiry,myCallBidP);
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
if isempty(myOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==0,
    if isempty(myOptionDepth.askLimitPrice)==0,
        myPutAskP=myOptionDepth.askLimitPrice;
        mySigma=blsimpv(mySpot0,myStrike,0,myExpiry,myPutAskP);
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
    elseif isempty(myOptionDepth.bidLimitPrice)==0,
        myPutBidP=myOptionDepth.bidLimitPrice;
        mySigma=blsimpv(mySpot0,myStrike,0,myExpiry,myPutBidP);
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