%% Preambule
clear all
N = 200;
trials = 1;
yield=0;
exercise=12;

%% Volatility
start=11;
drift=0.02;
sigma=0.2;
time=82;
ValueCallSigma=[];
ValuePutSigma=[];
sigmavec=[];
resolutionSigma=0.025;
for i=1:40,
    sigma=0+i*resolutionSigma;
    [A,B]=mcPricer(N,trials,start,drift,sigma,exercise,time);
    ValueCallSigma(end+1)=A;
    ValuePutSigma(end+1)=B;
    sigmavec(end+1)=sigma;
end

%% Drift
start=11;
drift=0.02;
sigma=0.2;
time=82;
ValueCallDrift=[];
ValuePutDrift=[];
driftvec=[];
resolutionDrift=0.025;
for i=1:40,
    drift=0+i*resolutionDrift;
    [A,B]=mcPricer(N,trials,start,drift,sigma,exercise,time);
    ValueCallDrift(end+1)=A;
    ValuePutDrift(end+1)=B;
    driftvec(end+1)=drift;
end

%% Starting Stockprice
start=11;
drift=0.02;
sigma=0.2;
time=82;
ValueCallStart=[];
ValuePutStart=[];
startvec=[];
resolutionStart=0.125;
for i=1:40,
    start=8+i*resolutionStart;
    [A,B]=mcPricer(N,trials,start,drift,sigma,exercise,time);
    ValueCallStart(end+1)=A;
    ValuePutStart(end+1)=B;
    startvec(end+1)=start;
end

%% Time
start=11;
drift=0.02;
sigma=0.2;
time=82;
ValueCallTime=[];
ValuePutTime=[];
timevec=[];
resolutionTime=20;
for i=0:40,
    time=0+i*resolutionTime;
    [A,B]=mcPricer(N,trials,start,drift,sigma,exercise,time);
    ValueCallTime(end+1)=A;
    ValuePutTime(end+1)=B;
    timevec(end+1)=time;
end