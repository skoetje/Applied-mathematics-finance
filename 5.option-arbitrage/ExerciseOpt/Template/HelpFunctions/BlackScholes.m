function [call,put] = BlackScholes(S,X,T,r,v)
% Our own black-scholes formula, without any 
%   Detailed explanation goes here
d1=(log(S/X)+(r+v^2/2)*T)/(v*sqrt(T));
d2=d1-v*sqrt(T);
call = S*normcdf(d1)-X*exp(-r*T)*normcdf(d2);
put = X*exp(-r*T)*normcdf(-d2)-S*normcdf(-d1);
end
% function [call,put] = blackscholes(spot,strike,time,interest,sigma)
% %Our own black-scholes formula, without any 
% %  Detailed explanation goes here
% d1=(log(spot/strike)+(interest+sigma^2/2)*time)/(sigma*sqrt(time));
% d2=d1-sigma*sqrt(time);
% call = spot*normcdf(d1)-strike*exp(-interest*time)*normcdf(d2); 
% put = strike*exp(-interest*time)*normcdf(-d2)-spot*normcdf(-d1);
% end
