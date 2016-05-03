%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=11;

%% Plots
ValueOption=[];
for i=1:100,
    mu=0.01+i*0.001;
    ValueOption(end+1)=blsprice(Start,Strike,mu,time,sigma,yield);
end

plot(ValueOption,'LineWidth',3)
%ylim([0,N/20])
%xlim([0,4])
xlabel('Drift','FontSize', 15)
ylabel('Option value (€)','FontSize', 15)
set(gca,'FontSize',13)