%% DEZE RUNT HEM ALS EEN SCRIPT
% Deze kan je gebruiken om de gemiddelden te meten adhv het 
% aantal trials en samples (n). De bovenste twee kun je dus
% aanpassen om te experimenteren. Voor de sensitivity heb
% ik de functie mcPricer gebruikt.
N = 100;
trials = 30;
aS = 11;
aE = 12;
aMu = 0.02;
aT = 82;
aSigma = 0.2;

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
aaastdCall = std(callVec);
aagemPut = mean(putVec);
aastdPut = std(putVec);


% %Same input as ass.1
% N = 10000;
% price = 11;
% strike = 12;
% rate = 0.02;
% time = 82/252;
% volatility = 0.12;
% yield = 0;
% 
% callVector = [];
% putVector = [];
% %priceVector =[0:0.01:15];
% for i=1:N;
%     optionPrice(11,0.02,0.2,12,82,N)
%     putPrice   (11,0.02,0.2,12,82,N)
%     callVector(end+1)=x;
%     putVector(end+1)=y;
%    % callVector(end+1)=a;
%     %putVector(end+1)=b;
% end
% hold on
% plot(priceVector, callVector);
% plot(priceVector, putVector);
% hold off