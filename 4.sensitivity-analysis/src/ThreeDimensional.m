%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=11;

%% 3D Plots
ValueCall=zeros(100,100);
ValuePut=zeros(100,100);
DValueCall=zeros(100,100);
DValuePut=zeros(100,100);
timevec=[];
startvec=[];
resolutionx=0.03;
resolutiony=0.07;

for i=1:100,
    time=0+i*resolutionx;
    startvec=[];
    for j=1:100,
        start=7+j*resolutiony;
        [A,B]=blsprice(start,Strike,mu,time,sigma,yield);
        ValueCall(i,j)=A;
        ValuePut(i,j)=B;
        startvec(end+1)=start;
    end
    timevec(end+1)=time;
end

%%
DxValueCall=zeros(100,100);
DxValuePut=zeros(100,100);
for i=1:100,
    A=diff(ValueCall(i,:));
    B=diff(ValueCall(i,:));
    for j=1:99,
        DxValueCall(i,j)=A(j)/resolutionx;
        DxValuePut(i,j)=B(j)/resolutionx;
    end
end

DyValueCall=zeros(100,100);
DyValuePut=zeros(100,100);
for i=1:100,
    A=diff(ValueCall(:,i));
    B=diff(ValueCall(:,i));
    for j=1:99,
        DyValueCall(j,i)=A(j)/resolutiony;
        DyValuePut(j,i)=B(j)/resolutiony;
    end
end

%% Normalization
start0=11;
time0=82/252;

DyNValueCall=DyValueCall;
DyNValuePut=DyValuePut;
DxNValueCall=DxValueCall;
DxNValuePut=DxValuePut;

SensValueCall=sqrt(DyNValueCall^2+DxNValueCall^2);
SensValuePut=sqrt(DyNValuePut^2+DxNValuePut^2);


%% Actual Plots
subplot(2,2,1)
contourf(timevec,startvec,ValueCall,10)
xlabel('Time','FontSize', 15)
ylabel('Starting stock price','FontSize', 15)
title('Option Value')
colorbar

subplot(2,2,2)
contourf(timevec,startvec,SensValueCall,30)
xlabel('Time','FontSize', 15)
ylabel('Starting stock price','FontSize', 15)
title('Total sensitivity of Option value')
colorbar

subplot(2,2,3)
contourf(timevec(1:end),startvec(1:end),DxValueCall,10)
xlabel('Time','FontSize', 15)
ylabel('Starting stock price','FontSize', 15)
title('Sensitivity to Time changes')
colorbar

subplot(2,2,4)
contourf(timevec(1:end),startvec(1:end),DyValueCall,10)
xlabel('Time','FontSize', 15)
ylabel('Starting stock price','FontSize', 15)
title('Sensitivity to Starting stock price changes')
colorbar