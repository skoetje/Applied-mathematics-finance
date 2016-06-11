function myDelta = DeltaCalculator(aBot,aStrike,aTime,aBoolean)
%Preambule
if aStrike==10,
    myCallOptionDepth=aBot.Call1000Depth;
    myPutOptionDepth=aBot.Put1000Depth;
end

%Calculate the very first Delta
myDeltastart=Delta3(aBot,aStrike,aTime,aBoolean);
myLTtime=round(aBot.sentOrders.ownOrderId(end));
mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
myPastSpot=(aBot.AskHistory(myLTtime)+aBot.BidHistory(myLTtime))/2;
myGamma=0.3193;
mySpotMovement=mySpot-myPastSpot;
myDeltaChange=myGamma*mySpotMovement;
myDelta = myDeltastart+myDeltaChange;

end