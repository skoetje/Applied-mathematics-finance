% Parameters:
%  aS     : double - start value
%  aMu    : double - drift per year
%  aSigma : double - volatility per year
%  aE     : double - the exercise price
%  aT     : double - time until expiry in years

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
timevec=[];
for i=1:1000,
    time=0.01+i*0.01;
    [A,B]=blsprice(Start,Strike,mu,time,sigma,yield);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    timevec(end+1)=time;
end
subplot(2,2,1)
plot(timevec,ValueCall,'LineWidth',3)
xlabel('Time change (by 0.01)','FontSize', 15)
ylabel('Call Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,2)
plot(timevec,ValuePut,'LineWidth',3)
xlabel('Time change (by 0.01)','FontSize', 15)
ylabel('Put Option value (€)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,3)
plot(timevec(2:end),diff(ValueCall),'LineWidth',3)
xlabel('Time change (by 0.01)','FontSize', 15)
ylabel('Change Value Call option per change in drift','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,4)
plot(timevec(2:end),diff(ValuePut),'LineWidth',3)
xlabel('Time change (by 0.01)','FontSize', 15)
ylabel('Change Value Call option per change in drift','FontSize', 15)
set(gca,'FontSize',13)