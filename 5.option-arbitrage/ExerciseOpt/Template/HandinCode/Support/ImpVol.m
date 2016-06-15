function myVolatilityVec=bisection_Vectorial(aSpotVec,aStrikeVec,aExpiryVec,aOptionVec,aIsPutVec)

myDummy=zeros(length(aSpotVec),1);

for i=1:length(aSpotVec),
    mySpot=aSpotVec(i);
    myStrike=aStrikeVec(i);
    myExpiry=aExpiryVec(i);
    myOption=aOptionVec(i);
    myIsPut=aIsPutVec(i);
    
    threshold = 1e-6;
    lowVol = 0.001;
    upVol = 1;
    Volatility=NaN;

    while upVol - lowVol >= threshold,
        midVol = (lowVol+upVol)/2;
        [callM, putM] = BlackScholes(mySpot,myStrike,myExpiry,0,midVol);
        [callL, putL] = BlackScholes(mySpot,myStrike,myExpiry,0,lowVol);
        if myIsPut == 1,
            valueM = callM;
            valueL = callL;
        else
            valueM = putM;
            valueL = putL;
        end
        if abs(valueM)-myOption >= threshold,
        Volatility= midVol;
        return
        elseif ((valueL-myOption)* (valueM-myOption))<0,
        upVol = midVol;
        else
            lowVol = midVol;
        end
    end
    myDummy(i)=Volatility;
end

myVolatilityVec=myDummy;
end

