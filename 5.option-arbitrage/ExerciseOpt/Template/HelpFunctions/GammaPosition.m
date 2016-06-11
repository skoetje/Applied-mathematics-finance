function myGammaPosition = GammaPosition(aBot,aStrike)

myGammaVec=[0.3,0.3,0.3,0.3,0.3193, 0.3,0.3,0.3,0.3,0.3];
if aStrike==10,
    myNumber=5;
elseif aStrike==8,
    myNumber=1;
end
myGamma=myGammaVec(myNumber);

myLTtime=round(aBot.sentOrders.ownOrderId(end));
mySpot=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
myPastSpot=aBot.SpotHistory(myLTtime);
mySpotMovement=mySpot-myPastSpot;
myGammaChange=aBot.CallDeltaVecAFT(myLTtime)+myGamma*mySpotMovement;
myGammaPosition = myDeltaChange*aBot.ownTrades.volume(1);

end