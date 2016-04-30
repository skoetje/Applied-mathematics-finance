%Same input as ass.1

%price = 11;
strike = 12;
rate = 0.02;
time = 82/252;
volatility = 0.12;
yield = 0;


callVector = [];
putVector = [];
priceVector =[0:15];
for i=1:length(priceVector);
    price = i;
    [a,b] = blackScholes(i, strike, rate, time, volatility, yield);
    callVector(end+1)=a;
    putVector(end+1)=b;
end
hold on
plot(priceVector, callVector);
plot(priceVector, putVector);
hold off

