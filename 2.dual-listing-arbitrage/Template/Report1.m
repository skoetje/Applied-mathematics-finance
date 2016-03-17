function Report(aTrades)
    % Report the cash and position given the trades
    
    Tabel = {'Assets','Cash'};
AEX = [20 5 13 0 17];
Chi-X = [18 9 21 5 12];
Total = [26 10 16 3 15];

   T = table;
T.Tabel = Tabel';
T.AEX = AEX';
T.Chi-X = Chi-X';
T.Total = Total'           
   
end
