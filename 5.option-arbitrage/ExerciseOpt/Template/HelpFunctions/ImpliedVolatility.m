function Volatility=ImpliedVolatility(aSpot,aStrike,aTime,aOption,aBoolean)
%For vector of length 1
sigma=0.2;
value=100;

while value-aOption>0.01,
    [call, put] = BlackScholes(aSpot,aStrike,aTime,0,sigma);
    if aBoolean==1,
        value=call;
    else
        value=put;
    end
    sigma=sigma+(aOption-value)/Vega(aSpot,aStrike,aTime,0,sigma);
end
Volatility=sigma;
end