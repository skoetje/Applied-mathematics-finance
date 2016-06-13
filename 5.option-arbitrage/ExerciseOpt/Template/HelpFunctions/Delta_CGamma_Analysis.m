function myDelta=Delta_CGamma_Analysis(aBot,aStrike,aBoolean)

myGamma = GammaVector(aStrike);
myOptionDepth = OptionDepth(aBot,aStrike,aBoolean);
myDelta = 0;

if isempty(myOptionDepth)==0,
    myFTtime=1;
    mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
    if aBoolean==1,
        myDelta=aBot.StartDeltas(myFTtime,find(aBot.myStrikeVec==aStrike))+myGamma*(mySpot-aBot.SpotHistory(myFTtime));
    end
    if aBoolean==0,
        myDelta=aBot.StartDeltas(myFTtime,find(aBot.myStrikeVec==aStrike))+myGamma*(mySpot-aBot.SpotHistory(myFTtime));
    end
end
end