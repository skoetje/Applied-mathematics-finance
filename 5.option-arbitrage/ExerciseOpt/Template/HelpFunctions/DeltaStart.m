function myDelta=DeltaStart(aBot,aStrike,aTime,aBoolean)

myOptionDepth=OptionDepth(aBot,aStrike,aBoolean);

myStrike=aStrike;
myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);
myInterest=0;
mySpot=NaN;

if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
    mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
end

myDelta=NaN;

%Call Option Delta
if isempty(myOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==1,
    if isempty(myOptionDepth.askLimitPrice)==0 && isempty(myOptionDepth.bidLimitPrice)==0,
        myCallSpot=(myOptionDepth.askLimitPrice+myOptionDepth.bidLimitPrice)/2;
        myValue1=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,blsimpv(mySpot,myStrike,0,myExpiry,myCallSpot));
        myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,blsimpv(mySpot,myStrike,0,myExpiry,myCallSpot));
        myValue3=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,blsimpv(mySpot,myStrike,0,myExpiry,myCallSpot));
        myValueVec=[myValue1,myValue2,myValue3];
        myGradientVec=gradient(myValueVec)/0.01;
        myDelta=myGradientVec(2)*myValue3/myValue3;
    end        
end

%Put Option Delta
if isempty(myOptionDepth)==0 && isempty(aBot.StockDepth)==0 && aBoolean==0,
    if isempty(myOptionDepth.askLimitPrice)==0 && isempty(myOptionDepth.bidLimitPrice)==0,
        myPutSpot=(myOptionDepth.askLimitPrice+myOptionDepth.bidLimitPrice)/2;
        [a,myValue1]=BlackScholes(mySpot-0.01,myStrike,myExpiry,myInterest,blsimpv(mySpot,myStrike,0,myExpiry,myPutSpot));
        [a,myValue2]=BlackScholes(mySpot,myStrike,myExpiry,myInterest,blsimpv(mySpot,myStrike,0,myExpiry,myPutSpot));
        [a,myValue3]=BlackScholes(mySpot+0.01,myStrike,myExpiry,myInterest,blsimpv(mySpot,myStrike,0,myExpiry,myPutSpot));
        myValueVec=[myValue1,myValue2,myValue3];   
        myGradientVec=gradient(myValueVec)/0.01;
        myDelta=myGradientVec(2)*myValue3/myValue3;
    end        
end
end