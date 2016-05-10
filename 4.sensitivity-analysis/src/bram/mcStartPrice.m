%% Preambule
N = 10;
trials = 10;
aMu=0.02;
aSigma=0.2;
aT=82;
yield=0;
aE=12;
aS=11;

%% 1D Plots
ValueCall=[];
ValuePut=[];
Startvec=[];
resolution=0.01;

for i=1:1000,
    Start=8+i*resolution;
    [A,B]=mcPricer(N,trials,aS,aMu,aSigma,aE,aT);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    Startvec(end+1)=Start;
end

subplot(2,2,1)
hold on
plot(Startvec,ValueCall,'LineWidth',3)
plot([12,12],[0 8],'LineWidth',3)
hold off
xlabel('Starting Stock Price','FontSize', 15)
ylabel('Call Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,2)
hold on
plot(Startvec,ValuePut,'LineWidth',3)
plot([12,12],[0 4],'LineWidth',3)
hold off
xlabel('Starting Stock Price','FontSize', 15)
ylabel('Put Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,3)
hold on
plot(Startvec(2:end),diff(ValueCall)/resolution,'LineWidth',3)
plot([12,12],[0 1],'LineWidth',3)
hold off
xlabel('Starting Stock Price','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,4)
plot(Startvec(2:end),diff(ValuePut)/resolution,'LineWidth',3)
xlabel('Starting Stock Price','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)