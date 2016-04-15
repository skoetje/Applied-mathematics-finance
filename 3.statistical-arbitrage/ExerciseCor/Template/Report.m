function Report(aTrades)
    % Create empty vectors to append to
    myAssetsCBK = [];
    myAssetsDBK = [];
    
    % Cashflows per trade, elements >0 if sell, <0 if buy
    myCashCBK = []; 
    myCashDBK = [];

    % Sort trades into vectors by ISIN
    for i = 1:length(aTrades.side),
        
        % Note: the sorting by ISIN is done by checking whether all eight
        % characters coincide with the string 'CBK_AKZA' or 'DBK_AKZA'
        if sum(char(aTrades.ISIN(i))=='CBK_EUR')==7,
            myAssetsCBK(end+1)= aTrades.volume(i)* aTrades.side(i);
            myCashCBK(end+1)= - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        elseif sum(char(aTrades.ISIN(i))=='DBK_EUR')==7,
            myAssetsDBK(end+1)= aTrades.volume(i)* aTrades.side(i);
            myCashDBK(end+1)= - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
    end
    
    % Summing up to get total flows of assets and cash
    myCBKvolume = sum(myAssetsCBK);
    myCBKcash = sum(myCashCBK);
    myDBKvolume = sum(myAssetsDBK);
    myDBKcash = sum(myCashDBK);
    
    % Creation of Table
    Vertical = {'Position'};
    Cash = [myCBKcash+myDBKcash];
    CBK = [myCBKvolume];
    DBK = [myDBKvolume];
    table(Cash,CBK,DBK,'RowNames',Vertical)
end