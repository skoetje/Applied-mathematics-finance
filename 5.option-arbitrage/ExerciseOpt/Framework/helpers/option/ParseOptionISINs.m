function [theUnderlying, theExpiration, theIsPut, theStrike] = ParseOptionISINs(aOptionISIN)
% PURPOSE: Extract relevant information from multiple option ISINs.
% IN:      - aOptionISIN (Nx1 cell): The option ISINs.
% OUT:     - theUnderlying (Nx1 cell): The underlying ISINs.
%          - theExpiration (Nx1 double): Serial date numbers indicating the expiration date.
%          - theIsPut (Nx1 logical): Booleans indicating the option kind.
%          - theStrike (Nx1 double): Strike prices.

[theUnderlying, theExpiration, theIsPut, theStrike] = cellfun(@ParseISIN, aOptionISIN);

end


function [theUnderlying, theExpiration, theIsPut, theStrike] = ParseISIN(aOptionISIN)

pattern = '(?<underlying>\w+)(?<y>\d{4})(?<m>\d{2})(?<d>\d{2})(?<class>PUT|CALL)(?<strike>\d{3,4})';
matches = regexp(aOptionISIN, pattern, 'names');

theUnderlying = {matches.underlying};
theExpiration = datenum(cellfun(@str2double, {matches.y matches.m matches.d}));
theIsPut      = strcmp(matches.class, 'PUT');
theStrike     = str2double(matches.strike)/100;

end
