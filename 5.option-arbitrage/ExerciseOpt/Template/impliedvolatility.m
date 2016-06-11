function Volatility=impliedvolatility(aSpot,aStrike,aTime,aOption,aIsPut)
sigma=0.2;
value=100 + aOption;

while any(value-aOption > 1e-9)
    [call, put] = BlackScholes(aSpot,aStrike,aTime,0,sigma);
    value(aIsPut) = put(aIsPut);
    value(~aIsPut) = call(~aIsPut);
    sigma=sigma+(aOption-value)./Vega(aSpot,aStrike,aTime,0,sigma);
end
Volatility=sigma;
end