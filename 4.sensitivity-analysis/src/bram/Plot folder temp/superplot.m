%%%%% TIME PART

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
timevec2=[];
resolution=0.005;

for i=1:400,
    time=0+i*resolution;
    [A,B]=blsprice(Start,Strike,mu,time,sigma,yield);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    timevec2(end+1)=time;
end
figure
hold on
plot(timevec2,ValueCall,'LineWidth',3)
plot(timevec/252,ValueCallTime,'LineWidth',3)
plot(timevec/252,ValueCallTime50,'LineWidth',3)
hold off
xlabel('Expiry time','FontSize', 18)
xlim([0,2])
ylabel('Call Option value (€)','FontSize', 18)
set(gca,'FontSize',18)

