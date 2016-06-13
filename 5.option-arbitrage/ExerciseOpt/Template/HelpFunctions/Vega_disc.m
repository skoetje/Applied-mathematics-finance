function myVega = Vega_disc(aBot,aStrike,aTime,aBoolean)

myOptionDepth=OptionDepth(aBot,aStrike,aBoolean);
myVega=NaN;

if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0 && isempty(myOptionDepth)==0,
    if isempty(myOptionDepth.bidVolume)==0 && isempty(myOptionDepth.askVolume)==0,
        myStrike=aStrike;
        myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);
        myInterest=0;
        mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
        myOptionSpot=(myOptionDepth.bidLimitPrice+myOptionDepth.askLimitPrice)/2;
        myImpVol=ImpliedVolatility(mySpot,myStrike,aTime,myOptionSpot,aBoolean);
        
        myValue1=BlackScholes(mySpot,myStrike,myExpiry,myInterest,myImpVol-0.001);
        myValue2=BlackScholes(mySpot,myStrike,myExpiry,myInterest,myImpVol);
        myValue3=BlackScholes(mySpot,myStrike,myExpiry,myInterest,myImpVol+0.001);
        
        myValueVec=[myValue1,myValue2,myValue3];
        myGradientVec=gradient(myValueVec)/0.001;
        myVega=myGradientVec(2)*myValue3/myValue3;
    end
end
end