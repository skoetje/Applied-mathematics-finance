function [call,put] = blackscholes(S,X,T,r,v)
% Our own black-scholes formula, without any 
%   Detailed explanation goes here
d1=(log(S/X)+(r+v^2/2)*T)/(v*sqrt(T));
d2=d1-v*sqrt(T);
call = S*normcdf(d1)-X*exp(-r*T)*normcdf(d2);
put = X*exp(-r*T)*normcdf(-d2)-S*normcdf(-d1);
end