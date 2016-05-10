
%% Preambule
%% [Call, Put] = mcPricer(100,30,11,0.02,0.2,12,82)
% Dit script heb ik gemaakt zodat alle codes in 1x kunnen runnen
% terwijl ik slaap. Ik denk dat zoiets ook slim is voor als we
% in de volgende assignment gaan brute force optimaliseren ;)

N = 200;
trials = 30;
aMu=0.02;
aSigmaVol=0.2;
aTVol=82;
yield=0;
aE=12;
aS=11;

% Implied volatility. Het plotten heb ik er uit gecommented zodat
% ik alleen de variabelen even kan opslaan.

%% 1D Plots
ValueCallVol=[];
ValuePutVol=[];
sigmavec=[];
resolutionVol=0.01;
for i=1:200,
    sigma=0+i*resolutionVol;
    [A,B]=mcPricer(N,trials,aS,aMu,sigma,aE,aTVol);
    ValueCallVol(end+1)=A;
    ValuePutVol(end+1)=B;
    sigmavec(end+1)=sigma;
end
% subplot(2,2,1)
% plot(sigmavec,ValueCallVol,'LineWidth',3)
% xlabel('Volatility rate per year','FontSize', 15)
% ylabel('Call Option value (€)','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,2)
% plot(sigmavec,ValuePutVol,'LineWidth',3)
% xlabel('Volatility rate per year','FontSize', 15)
% ylabel('Put Option value (€)','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,3)
% plot(sigmavec(2:end),diff(ValueCallVol)/resolutionVol,'LineWidth',3)
% xlabel('Volatility rate per year','FontSize', 15)
% ylabel('Change Value Call option','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,4)
% plot(sigmavec(2:end),diff(ValuePutVol)/resolutionVol,'LineWidth',3)
% xlabel('Volatility rate per year','FontSize', 15)
% ylabel('Change Value Call option','FontSize', 15)
% set(gca,'FontSize',13)



% Preambule
% En hier runnen we de tijd......

N = 200;
trials = 30;
aMu=0.02;
aSigmaTime=0.2;
aTTime=82;
yield=0;
aE=12;
aS=11;

% 1D Plots
ValueCallTime=[];
ValuePutTime=[];
timevec=[];
resolutionTime=0.005;

for j=1:400,
    time=0+j*resolutionTime;
    [X,Y]=mcPricer(N,trials,aS,aMu,aSigmaTime,aE,time);
    ValueCallTime(end+1)=X;
    ValuePutTime(end+1)=Y;
    timevec(end+1)=time;
end
% subplot(2,2,1)
% plot(timevec,ValueCallTime,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Call Option value (€)','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,2)
% plot(timevec,ValuePutTime,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Put Option value (€)','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,3)
% plot(timevec(2:end),diff(ValueCallTime)/resolutionTime,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Change Value Call option','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,4)
% plot(timevec(2:end),diff(ValuePutTime)/resolutionTime,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Change Value Call option','FontSize', 15)
% set(gca,'FontSize',13)
% 

