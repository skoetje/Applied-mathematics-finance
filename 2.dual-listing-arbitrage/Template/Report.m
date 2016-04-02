function Report(aTrades)
    % Create empty vectors to append to
    myAssetsAEX = [];
    myAssetsCHX = [];
    
    % Cashflows per trade, elements >0 if sell, <0 if buy
    myCashAEX = []; 
    myCashCHX = [];

    % Sort trades into vectors by ISIN
    for i = 1:length(aTrades.side),
        
        % Note: the sorting by ISIN is done by checking whether all eight
        % characters coincide with the string 'AEX_AKZA' or 'CHX_AKZA'
        if sum(char(aTrades.ISIN(i))=='AEX_AKZA')==8,
            myAssetsAEX(end+1)= aTrades.volume(i)* aTrades.side(i);
            myCashAEX(end+1)= - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        elseif sum(char(aTrades.ISIN(i))=='CHX_AKZA')==8,
            myAssetsCHX(end+1)= aTrades.volume(i)* aTrades.side(i);
            myCashCHX(end+1)= - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
    end
    
    % Summing up to get total flows of assets and cash
    myAEXvolume = sum(myAssetsAEX);
    myAEXcash = sum(myCashAEX);
    myCHXvolume = sum(myAssetsCHX);
    myCHXcash = sum(myCashCHX);
    
    % Creation of Table
    Vertical = {'Assets';'Cash'};
    AEXvec = [myAEXvolume;myAEXcash];
    CHXvec = [myCHXvolume;myCHXcash];
    Totalvec = [myAEXvolume+myCHXvolume;myAEXcash+myCHXcash];
    table(AEXvec,CHXvec,Totalvec,'RowNames',Vertical)
end