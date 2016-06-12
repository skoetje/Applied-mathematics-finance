function Unwind(aBot,aTime)

if aTime>2500,
    myTimeFraction = round((3250-aTime)/2);
    
    for i=1:length(aBot.myStrikeVec),
        myStrike=aBot.myStrikeVec(i);
        myOptionDepth=OptionDepth(aBot,myStrike,1);
        myOptionTrades = find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN));
        myOptionPosition= sum(aBot.ownTrades.volume(myOptionTrades));
        
        if isempty(myOptionDepth.bidVolume)==0 && myOptionPosition >0,
            myOptionPrice = myOptionDepth.bidLimitPrice(1);
            myOptionVolume = round(myOptionDepth.bidVolume(1)/2);
            
            if myOptionPrice > nanmean(aBot.ownTrades.price(myOptionTrades)),
                myOptionDepth.bidVolume(1) = myOptionDepth.bidVolume(1) - myOptionVolume;
                aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
                aBot.SendNewOrder(myOptionPrice, myOptionVolume,  1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, aTime*100000);
            end
        end
    end
end


end