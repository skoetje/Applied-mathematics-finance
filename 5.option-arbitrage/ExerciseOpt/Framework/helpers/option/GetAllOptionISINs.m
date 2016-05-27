function theISINs = GetAllOptionISINs()
% PURPOSE: Returns all option ISINs.
% OUT:     - theISINs (Nx1 cell): A cell array containing option ISINs.

myPrefix = 'ING20160916';
theISINs  = {};

for myStrike = [8 9 9.5 9.75 10 10.25 10.5 11 12 14] %#ok<*AGROW>
    theISINs(end+1, :) = {[myPrefix, 'CALL', num2str(myStrike*100)]};
    theISINs(end+1, :) = {[myPrefix, 'PUT',  num2str(myStrike*100)]};
end
