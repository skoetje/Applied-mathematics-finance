%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=11;
DStart=0.257;
DDStart=0.002576;

DStartP=-0.743;
DDStartP=0.002576;

%% Data
ValueCall=[];
ValuePut=[];
ValueCall2=[];
ValuePut2=[];
muvec=[];
resolution=0.01;
for i=1:200,
    mu=0+i*resolution;
    [A,B]=blsprice(Start,Strike,mu,time,sigma,yield);
    ValueCall(end+1)=A;
    ValuePut(end+1)=B;
    muvec(end+1)=mu;
    ValueCall2(end+1)=exp(mu*time)+0.5*sigma^2*Start^2*DDStart/mu+Start*DStart;
    ValuePut2(end+1)=exp(mu*time)+0.5*sigma^2*Start^2*DDStartP/mu+Start*DStartP;
end

%% Plots

subplot(2,2,1)
hold on
plot(muvec,ValueCall,'LineWidth',3)
plot(muvec,ValueCall2,'LineWidth',3)
hold off
xlabel('Drift rate per year','FontSize', 15)
ylabel('Call Option value (�)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,2)
hold on
plot(muvec,ValuePut,'LineWidth',3)
plot(muvec,ValuePut2,'LineWidth',3)
hold off
xlabel('Drift rate per year','FontSize', 15)
ylabel('Put Option value (�)','FontSize', 15)
set(gca,'FontSize',13)

subplot(2,2,3)
plot(muvec(2:end),diff(ValueCall)/resolution,'LineWidth',3)
xlabel('Drift rate per year','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)
ValueCall
subplot(2,2,4)
plot(muvec(2:end),diff(ValuePut)/resolution,'LineWidth',3)
xlabel('Drift rate per year','FontSize', 15)
ylabel('Change Value Call option','FontSize', 15)
set(gca,'FontSize',13)