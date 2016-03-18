function Report(aTrades)
    % Report the cash and position given the trades
    assetsAEX = [];
    assetsCHX = [];
    cashAEX = [];
    cashCHX = [];

    for i = 1:length(aTrades.side),
        if sum(char(aTrades.ISIN(i))=='AEX_AKZA')==8,
            assetsAEX(end+1)= aTrades.volume(i)* aTrades.side(i);
            cashAEX(end+1)= - aTrades.volume(i)* aTrades.side(i)*aTrades.price(i);
        elseif sum(char(aTrades.ISIN(i))=='CHX_AKZA')==8,
            assetsCHX(end+1)= aTrades.volume(i)* aTrades.side(i);
            cashCHX(end+1)= - aTrades.volume(i)* aTrades.side(i)*aTrades.price(i);
        end
    end
    
    %Summing up to get total flows of assets and cash
    AEXvol = sum(assetsAEX);
    AEXcash = sum(cashAEX);
    CHXvol = sum(assetsCHX);
    CHXcash = sum(cashCHX);
    
    %Creation of Table
    Vertical = {'Assets';'Cash'};
    AEX = [AEXvol;AEXcash];
    ChiX = [CHXvol;CHXcash];
    Total = [AEXvol+CHXvol;AEXcash+CHXcash];
    T = table(AEX,ChiX,Total,'RowNames',Vertical)
end