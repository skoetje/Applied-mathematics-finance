function Report_Analysis(aBot)

% Preambule
myAverageDeltas=zeros(21,1);
myAverageDeltas(1)=0;
myAverageGammas=zeros(21,1);
myAverageGammas(1)=0;
myAverageAskPrices=zeros(21,1);
myAverageAskPrices(1)=0;
myAverageBidPrices=zeros(21,1);
myAverageBidPrices(1)=0;
myAverageImpVols=zeros(21,1);
myAverageImpVols(1)=0;
myAverageVegas=zeros(21,1);
myAverageVegas(1)=0;

% Gathering from properties of the Tradingrobot
k=0;
p=0;
for i=1:20,
    if mod(i,2)==1,
        k=k+1;
        myAverageDeltas(i+1)=nanmean(aBot.CallDeltas(:,k));
        myAverageGammas(i+1)=nanmean(aBot.CallGammas(:,k));
        myAverageAskPrices(i+1)=nanmean(aBot.CallOptionAskPrices(:,k));
        myAverageBidPrices(i+1)=nanmean(aBot.CallOptionBidPrices(:,k));
        myAverageImpVols(i+1)=nanmean(aBot.CallOptionVolatility(:,k));
        myAverageVegas(i+1)=nanmean(aBot.CallVegas(:,k));
    elseif mod(i,2)==0,
        p=p+1;
        myAverageDeltas(i+1)=nanmean(aBot.PutDeltas(:,p));
        myAverageGammas(i+1)=nanmean(aBot.PutGammas(:,p));
        myAverageAskPrices(i+1)=nanmean(aBot.PutOptionAskPrices(:,p));
        myAverageBidPrices(i+1)=nanmean(aBot.PutOptionBidPrices(:,p));
        myAverageImpVols(i+1)=nanmean(aBot.PutOptionVolatility(:,k));
        myAverageVegas(i+1)=nanmean(aBot.PutVegas(:,k));
    end
end

% Rounding to look nice
Delta_m=round(myAverageDeltas,2);
Gamma_m=round(myAverageGammas,2);
Sigma_m=round(myAverageImpVols,3);
Ask_m=round(myAverageAskPrices,2);
Bid_m=round(myAverageBidPrices,2);
Vega_m=round(myAverageVegas,2);

% Remove errors
for i=1:21,
    if Sigma_m(i)>1000,
        Sigma_m(i)=NaN;
    end
end

% Creation of the table
ING = {'ING'};
assets = cat(1,ING,GetAllOptionISINs());
table(Delta_m,Gamma_m,Sigma_m,Ask_m,Bid_m,Vega_m,'RowNames',assets)
end
