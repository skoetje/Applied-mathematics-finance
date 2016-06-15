function Volatility=bisection(aSpot,aStrike,myExpiry,aOption,aIsPut)

threshold = 1e-6;
lowVol = 0.001;
upVol = 1;

while upVol - lowVol >= threshold,
    midVol = (lowVol+upVol)/2;
    [callM, putM] = BlackScholes(aSpot,aStrike,myExpiry,0,midVol);
    [callL, putL] = BlackScholes(aSpot,aStrike,myExpiry,0,lowVol);
    if aIsPut == 1,
        valueM = callM;
        valueL = callL;
    else
        valueM = putM;
        valueL = putL;
    end
    if abs(valueM)-aOption >= threshold,
    Volatility= midVol;
    return
    elseif ((valueL-aOption)* (valueM-aOption))<0,
    upVol = midVol;
    else
        lowVol = midVol;
    end
    
end

