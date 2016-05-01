%Same input as ass.1

%price = 11;
strike = 12;
rate = 0.02;
time = 82/252;
volatility = 0.12;
yield = 0;

callVector = [];
putVector = [];
priceVector =[0:0.01:15];
for i=1:length(priceVector);
    price = i;
    %[a, b] = blackScholes(i, strike, rate, time, volatility, yield);
    [x, y] = blackScholes(12,i,0.02,1,0.12,0);
    callVector(end+1)=x;
    putVector(end+1)=y;
   % callVector(end+1)=a;
    %putVector(end+1)=b;
end
hold on
plot(priceVector, callVector);
plot(priceVector, putVector);
hold off

