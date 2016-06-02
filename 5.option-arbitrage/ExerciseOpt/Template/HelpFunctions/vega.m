function vega = vega(spot,strike,time,interest,sigma)
% Our own black-scholes formula, without any 
%   Detailed explanation goes here
d1=(log(spot/strike)+(interest+sigma^2/2)*time)/(sigma*sqrt(time));
vega = spot*sqrt(1)*normpdf(d1);