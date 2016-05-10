function [Call, Put] = mcPricer(N,trials,aS,aMu,aSigma,aE,aT)
% N = 100;
% trials = 30;
% aS = 11;
% aE = 12;
% aMu = 0.02;
% aT = 82;
% aSigma = 0.2;

%           100,30,11,0.02,0.2,12,82
 %[aaaBSCALL, aaaBSPUT] = blsprice(aS, aE, aMu, aT/252, aSigma, 0);

%callValue = callPrice(aS,aMu,aSigma,aE,aT,N);
%putValue = putPrice(aS,aMu,aSigma,aE,aT,N);

callVec = [];
putVec = [];

for monte=1:trials,
callValue = callPrice(aS,aMu,aSigma,aE,aT,N);
putValue = putPrice(aS,aMu,aSigma,aE,aT,N);
callVec(end+1)=callValue;
putVec(end+1)=putValue;
end

aaagemCall = mean(callVec);
%aaastdCall = std(callVec); standaard deviatie niet meer nodig
aaagemPut = mean(putVec);
%aastdPut = std(putVec);


Call = mean(callVec);
Put = mean(putVec);
end
