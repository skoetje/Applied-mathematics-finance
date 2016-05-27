%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=12;

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
%subplot(2,2,1)
figure
hold on
plot(timevec2,ValueCall,'LineWidth',3)
plot(timevec/252,ValueCallTime,'LineWidth',3)
hold off
xlabel('Expiry time','FontSize', 15)
ylabel('Call Option value (€)','FontSize', 15)
set(gca,'FontSize',13)
% 
% subplot(2,2,2)
% plot(timevec,ValuePut,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Put Option value (€)','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,3)
% plot(timevec(2:end),diff(ValueCall)/resolution,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Change Value Call option','FontSize', 15)
% set(gca,'FontSize',13)
% 
% subplot(2,2,4)
% plot(timevec(2:end),diff(ValuePut)/resolution,'LineWidth',3)
% xlabel('Expiry time','FontSize', 15)
% ylabel('Change Value Call option','FontSize', 15)
% set(gca,'FontSize',13)