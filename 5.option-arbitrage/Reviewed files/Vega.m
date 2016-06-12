function vega = Vega(spot,strike,time,interest,sigma)
% Our own black-scholes formula, without any 
%   Detailed explanation goes here
d1=(log(spot./strike)+(interest+sigma.^2/2).*time)./(sigma.*sqrt(time));
vega = spot.*normProbDensFun(d1);