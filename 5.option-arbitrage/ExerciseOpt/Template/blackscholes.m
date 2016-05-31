function [call,put] = blackscholes(spot,strike,time,interest,sigma)
Our own black-scholes formula, without any 
  Detailed explanation goes here
d1=(log(spot/strike)+(interest+sigma^2/2)*time)/(sigma*sqrt(time));
d2=d1-sigma*sqrt(time);
call = spot*normcdf(d1)-strike*exp(-interest*time)*normcdf(d2); 
put = strike*exp(-interest*time)*normcdf(-d2)-spot*normcdf(-d1);
end
    