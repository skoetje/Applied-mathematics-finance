function myGamma = GammaVector(aStrike)

if aStrike==8,
    myGamma=0.1203;
elseif aStrike==9,
    myGamma=0.1278;
elseif aStrike==9.5,
    myGamma=0.2224;
elseif aStrike==9.75,
    myGamma=0.2715;
elseif aStrike==10,
    myGamma=0.3143;
elseif aStrike==10.25,
    myGamma=0.3446;
elseif aStrike==10.50,
    myGamma=0.3580;
elseif aStrike==11,
    myGamma=0.3295;
elseif aStrike==12,
    myGamma=0.1535;
elseif aStrike==14,
    myGamma=0.0308;
end

end