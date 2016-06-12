function myDelta=Delta_CGamma(aBot,aStrike,aBoolean)

myGamma = GammaVector(aStrike);
myOptionDepth = OptionDepth(aBot,aStrike,aBoolean);
myDelta = NaN;

if isempty(myOptionDepth)==0,
    myISIN = myOptionDepth.ISIN;
    myTrades = find(strcmp(aBot.ownTrades.ISIN,myISIN));

    if isempty(myTrades)==0,
        myFTtime=aBot.acceptedOrders.ownOrderId(myTrades(1));
        mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;

        if aBoolean==1,
            myDelta=aBot.StartDeltas(myFTtime,find(aBot.myStrikeVec==aStrike))+myGamma*(mySpot-aBot.SpotHistory(myFTtime));
        end

        if aBoolean==0,
            myDelta=aBot.StartDeltas(myFTtime,find(aBot.myStrikeVec==aStrike))+myGamma*(mySpot-aBot.SpotHistory(myFTtime));
        end
    end
end
end