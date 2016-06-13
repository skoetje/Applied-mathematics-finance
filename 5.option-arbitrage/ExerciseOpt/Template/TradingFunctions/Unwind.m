function Unwind(aBot,aTime)

myFeedLength=3600;
myThreshold=1800;

for myBoolean=0:1,
    if aTime>myThreshold,
        myTimeFraction = (myFeedLength-aTime)/myFeedLength;

        for i=1:length(aBot.myStrikeVec),
            myStrike=aBot.myStrikeVec(i);
            myOptionDepth=OptionDepth(aBot,myStrike,myBoolean);
            if isempty(myOptionDepth)==0,
                myOptionTrades = find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN));
                myOptionSells = myOptionTrades(ismember(find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN)),find(aBot.ownTrades.side==-1)));
                myOptionBuys = myOptionTrades(ismember(find(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN)),find(aBot.ownTrades.side==1)));

                myOptionPosition= sum(aBot.ownTrades.volume(myOptionTrades).*aBot.ownTrades.side(myOptionTrades));
                if isempty(myOptionDepth)==0,
                    if isempty(myOptionDepth.bidVolume)==0 && myOptionPosition > 0,
                        myOptionPrice = myOptionDepth.bidLimitPrice;
                        myOptionVolume = round(myOptionPosition/2);

                        if myOptionPrice >= 1.25*nanmean(aBot.ownTrades.price(myOptionSells))-nanmean(aBot.ownTrades.price(myOptionSells))*((aTime-myThreshold)/(myFeedLength-myThreshold))^2,
                            myOptionDepth.bidVolume = myOptionDepth.bidVolume - myOptionVolume;
                            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
                            aBot.SendNewOrder(myOptionPrice, myOptionVolume,  -1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, -aTime);
                        end
                    end        
                    if isempty(myOptionDepth.askVolume)==0 && myOptionPosition < 0,
                        myOptionPrice = myOptionDepth.askLimitPrice;
                        myOptionVolume = -round(myOptionPosition/2);

                        if myOptionPrice < 0.75*nanmean(aBot.ownTrades.price(myOptionBuys))+nanmean(aBot.ownTrades.price(myOptionBuys))*((aTime-myThreshold)/(myFeedLength-myThreshold))^2,
                            myOptionDepth.askVolume = myOptionDepth.askVolume - myOptionVolume;
                            aBot.TradeTimes(length(aBot.TradeTimes)+1)=aTime;
                            aBot.SendNewOrder(myOptionPrice, myOptionVolume,  1, {myOptionDepth.ISIN}, {'IMMEDIATE'}, -aTime);
                        end
                    end
                end
            end
        end

    end
end

end