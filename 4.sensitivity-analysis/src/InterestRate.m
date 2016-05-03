%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=11;

%% Plots
ValueCall=[];
ValuePut=[];
muvec=[];
for i=1:1000,
    mu=0.01+i*0.01;
    [A,B]=blsprice(Start,Strike,mu,time,sigma,yield);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    muvec(end+1)=mu;
end
subplot(2,1,1)
plot(muvec,ValueCall,'LineWidth',3)
%ylim([0,N/20])
%xlim([0,4])
xlabel('Drift','FontSize', 15)
ylabel('Call Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,1,2)
plot(muvec,ValuePut,'LineWidth',3)
%ylim([0,N/20])
%xlim([0,4])
xlabel('Drift','FontSize', 15)
ylabel('Put Option value (€)','FontSize', 15)
set(gca,'FontSize',13)