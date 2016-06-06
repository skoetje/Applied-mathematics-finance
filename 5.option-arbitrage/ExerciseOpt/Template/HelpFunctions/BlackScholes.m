function [call,put] = BlackScholes(S,X,T,r,vol)
% Our own black-scholes formula, without any 
%   Detailed explanation goes here
d1=(log(S/X)+(r+vol^2/2)*T)/(vol*sqrt(T));
d2=d1-vol*sqrt(T);
call = S*normcdf(d1)-X*exp(-r*T)*normcdf(d2);
put = X*exp(-r*T)*normcdf(-d2)-S*normcdf(-d1);
end
