function myVega = Vega(spot,strike,time,interest,sigma)
myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);

d1=(log(spot/strike)+(interest+sigma^2/2)*time)/(sigma*sqrt(time));
myVega = spot*sqrt(1)*normProbDensFun(d1);