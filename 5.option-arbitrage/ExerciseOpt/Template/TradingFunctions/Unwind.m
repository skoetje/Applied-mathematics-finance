function Unwind(aBot,aTime)

myFeedLength=18000;
myThreshold=15000;

if aTime>myThreshold,
    myTimeFraction = (myFeedLength-aTime)/myFeedLength;
    
    for i=1:length(aBot.myStrikeVec),
        myStrike=aBot.myStrikeVec(i);
        myOptionDepth=OptionDepth(aBot,myStrike,1);
        myOptionTrades = find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN));
        
        myOptionPosition= sum(aBot.ownTrades.volume(myOptionTrades).*aBot.ownTrades.side(myOptionTrades));
        
        if isempty(myOptionDepth.bidVolume)==0 && myOptionPosition > 0,
            myOptionPrice = myOptionDepth.bidLimitPrice(1);
            myOptionVolume = round(myOptionPosition/2);
            
            if myOptionPrice >= 1.25*nanmean(aBot.ownTrades.price(myOptionTrades))-0.5*nanmean(aBot.ownTrades.price(myOptionTrades))*((aTime-myThreshold)/(myFeedLength-myThreshold))^2 && myOptionVolume <= myOptionPosition,
                myOptionDepth.bidVolume(1) = myOptionDepth.bidVolume(1) - myOptionVolume;
                aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
                aBot.SendNewOrder(myOptionPrice, myOptionVolume,  -1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, aTime*10000);
            end
        end
    end
    
end
    

end