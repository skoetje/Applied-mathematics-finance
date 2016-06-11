function myDelta=Delta3(aBot,aStrike,aTime,aBoolean)
if aStrike==10,
    myCallOptionDepth=aBot.Call1000Depth;
    myPutOptionDepth=aBot.Put1000Depth;
end

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

myDelta=NaN;

%Delta determined looking at call options
if isempty(myCallOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==1,
    if isempty(myCallOptionDepth.askLimitPrice)==0 && isempty(myCallOptionDepth.bidLimitPrice)==0,
        myCallAskP=(myCallOptionDepth.askLimitPrice+myCallOptionDepth.bidLimitPrice)/2;
        myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
        myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
        myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myCallAskP,1));
        myValueVec=[myValue1,myValue2,myValue3];
        myGradientVec=gradient(myValueVec)/0.01;
        myDelta=myGradientVec(2)*myValue3/myValue3;
    end        
end

%Delta determined looking at put options
if isempty(myPutOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==0,
    if isempty(myPutOptionDepth.askLimitPrice)==0 && isempty(myPutOptionDepth.bidLimitPrice)==0,
        myPutAskP=myPutOptionDepth.askLimitPrice;
        [a,myValue1]=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,0));
        [a,myValue2]=BlackScholes(mySpot,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,0));
        [a,myValue3]=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,ImpliedVolatility(mySpot,myStrike,myExpiry,myPutAskP,0));
        myValueVec=[myValue1,myValue2,myValue3];   
        myGradientVec=gradient(myValueVec)/0.01;
        myDelta=myGradientVec(2)*myValue3/myValue3;
    end        
end
end