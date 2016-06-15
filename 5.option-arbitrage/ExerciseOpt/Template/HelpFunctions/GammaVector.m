function myGamma = GammaVector(aStrike)

if aStrike==8,
    myGamma=0.0503;
elseif aStrike==9,
    myGamma=0.1219;
elseif aStrike==9.5,
    myGamma=0.2205;
elseif aStrike==9.75,
    myGamma=0.2717;
elseif aStrike==10,
    myGamma=0.3166;
elseif aStrike==10.25,
    myGamma=0.3480;
elseif aStrike==10.50,
    myGamma=0.3616;
elseif aStrike==11,
    myGamma=0.3309;
elseif aStrike==12,
    myGamma=0.1485;
elseif aStrike==14,
    myGamma=0.0321;
end

end