function theValuation = Valuate(aAskPrices, aAskVolumes, aBidPrices, aBidVolumes, aTickSize)
    Vector=[];
    for num=1:length(aAskPrices),
        aAsk=aAskVolumes(num);
        aBid=aBidVolumes(num);
        if isempty(aAskVolumes(num))==1,
            aAsk=0;
        end
        if isempty(aBidVolumes(num))==1,
            aBid=0;
        end
        if aAsk==0 && aBid==0,
            Vector(end+1)=(aAskPrices(num)+aBidPrices(num));
        else
            Vector(end+1)=(aBid/(aAsk+aBid)*aAskPrices(num)+aAsk/(aAsk+aBid)*aBidPrices(num));
        end
    end
    theValuation=Vector;
end