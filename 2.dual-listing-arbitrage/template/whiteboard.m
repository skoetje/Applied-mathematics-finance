assetsAEX = [];
assetsCHX = [];
cashAEX = [];
cashCHX = [];
 
for i = 1:length(ownTrades.side),
    if sum(char(ownTrades.ISIN(i))=='AEX_AKZA')==8,
        assetsAEX(end+1)= ownTrades.volume(i)* ownTrades.side(i);
        cashAEX(end+1)= ownTrades.volume(i)* ownTrades.side(i)*ownTrades.price(i);
    elseif sum(char(ownTrades.ISIN(i))=='CHX_AKZA')==8,
        assetsCHX(end+1)= ownTrades.volume(i)* ownTrades.side(i);
    end
end



AEX = sum(assetsAEX);        
CHX = sum(assetsCHX);
AEX
CHX


volumeBought = [];
volumeSold = [];
priceBought = [];
priceSold = [];



for i = 1:length(ownTrades.side),
    if ownTrades.side(i) == 1,
        volumeBought(end+1) = ownTrades.volume(i);
        priceBought(end+1) = ownTrades.price(i)*ownTrades.volume(i);
    elseif ownTrades.side(i) == -1,
        volumeSold(end+1) = ownTrades.volume(i);
        priceSold(end+1) = ownTrades.price(i)*ownTrades.volume(i);
    end
end

lijst1Sum = sum(volumeBought);
lijst2Sum = sum(volumeSold);
AvgVolume = lijst1Sum - lijst2Sum;
priceBought;

priceSold;
totaal = sum(priceBought);
% sum(priceSold)
% sum(priceBought)
totaal = sum(priceSold)-sum(priceBought)
