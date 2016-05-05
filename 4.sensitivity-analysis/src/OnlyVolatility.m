%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=11;

%% 1D Plots
ValueCall=[];
ValuePut=[];
sigmavec=[];
for i=1:200,
    sigma=0+i*0.01;
    [A,B]=blsprice(Start,Strike,mu,time,sigma,yield);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    sigmavec(end+1)=sigma;
end
subplot(2,2,1)
plot(sigmavec,ValueCall,'LineWidth',3)
xlabel('Volatility rate per year','FontSize', 15)
ylabel('Call Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,2)
plot(sigmavec,ValuePut,'LineWidth',3)
xlabel('Volatility rate per year','FontSize', 15)
ylabel('Put Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,3)
plot(sigmavec(2:end),diff(ValueCall),'LineWidth',3)
xlabel('Volatility rate per year','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,4)
plot(sigmavec(2:end),diff(ValuePut),'LineWidth',3)
xlabel('Volatility rate per year','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)