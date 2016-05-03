%Same input as ass.1

price = 11;
strike = 12;
rate = 0.02;
time = 82/252;
%volatility = 0.12;
yield = 0;

callVector = [];
putVector = [];
volatilityVector =[0:0.01:1];
for i=1:length(volatilityVector);
    volatility = i;
    [x, y] = blsprice(price, strike, rate, time, i, yield);
    callVector(end+1)=x;
    putVector(end+1)=y;
        
end
callDiff = diff(callVector);
putDiff = diff(putVector);

hold on
%plot(volatilityVector, callVector);
%plot(volatilityVector, putVector);
plot(volatilityVector, callDiff);
plot(volatilityVector, putDiff);

hold off

