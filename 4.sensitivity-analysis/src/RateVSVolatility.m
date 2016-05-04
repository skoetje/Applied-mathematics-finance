%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
Start=11;

%% 2D Plots
ValueCall=zeros(100,100);
ValuePut=zeros(100,100);
DValueCall=zeros(100,100);
DValuePut=zeros(100,100);
muvec=[];
sigmavec=[];
resolutionx=0.01;
resolutiony=0.01;

for i=1:100,
    mu=0+i*resolutionx;
    sigmavec=[];
    for j=1:100,
        sigma=0+j*resolutiony;
        [A,B]=blsprice(Start,Strike,mu,time,sigma,yield);
        ValueCall(i,j)=A;
        ValuePut(i,j)=B;
        sigmavec(end+1)=sigma;
    end
    muvec(end+1)=mu;
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
sigma0=0.2;
mu0=0.02;

DyNValueCall=DyValueCall;
DyNValuePut=DyValuePut;
DxNValueCall=DxValueCall;
DxNValuePut=DxValuePut;

SensValueCall=sqrt(DyNValueCall^2+DxNValueCall^2);
SensValuePut=sqrt(DyNValuePut^2+DxNValuePut^2);


%% Actual Plots
subplot(2,2,1)
contourf(muvec,sigmavec,ValueCall,10)
xlabel('Drift','FontSize', 15)
ylabel('Volatility','FontSize', 15)
title('Option Value')
colorbar

subplot(2,2,2)
contourf(muvec,sigmavec,SensValueCall,30)
xlabel('Drift','FontSize', 15)
ylabel('Volatility','FontSize', 15)
title('Total sensitivity of Option value')
colorbar

subplot(2,2,3)
contourf(muvec(1:end),sigmavec(1:end),DxValueCall,10)
xlabel('Drift','FontSize', 15)
ylabel('Volatility','FontSize', 15)
title('Sensitivity to Drift changes')
colorbar

subplot(2,2,4)
contourf(muvec(1:end),sigmavec(1:end),DyValueCall,10)
xlabel('Drift','FontSize', 15)
ylabel('Volatility','FontSize', 15)
title('Sensitivity to Volatility changes')
colorbar