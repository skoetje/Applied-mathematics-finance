%% Preambule
%% [Call, Put] = mcPricer(100,30,11,0.02,0.2,12,82)
N = 200;
trials = 30;
aMu=0.02;
aSigma=0.2;
aT=82;
yield=0;
aE=12;
aS=11;

%% 1D Plots
ValueCall=[];
ValuePut=[];
muvec=[];
for i=1:100,
    mu=0.01+i*0.01;
    [A,B]=mcPricer(N,trials,aS,aMu,aSigma,aE,aT);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    muvec(end+1)=mu;
end

subplot(2,2,1)
plot(muvec,ValueCall,'LineWidth',3)
xlabel('Drift rate per year','FontSize', 15)
ylabel('Call Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,2)
plot(muvec,ValuePut,'LineWidth',3)
xlabel('Drift rate per year','FontSize', 15)
ylabel('Put Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,3)
plot(muvec(2:end),diff(ValueCall),'LineWidth',3)
xlabel('Drift rate per year','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,4)
plot(muvec(2:end),diff(ValuePut),'LineWidth',3)
xlabel('Drift rate per year','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)