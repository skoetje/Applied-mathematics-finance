%% Preambule
mu=0.02;
sigma=0.2;
time=82/252;
yield=0;
Strike=12;
start=11;

%% Data
Totalres=25;

ValueCall=zeros(Totalres,Totalres,Totalres);
ValuePut=zeros(Totalres,Totalres,Totalres);
resolutionx=0.02;
resolutiony=0.01;
resolutionz=0.08;
sigmavec=linspace(resolutionx,0.5,0.5/resolutionx);
muvec=linspace(resolutiony,0.25,0.25/resolutiony);
timevec=linspace(resolutionz,2,2/resolutionz);

for i=1:Totalres,
    sigma=0+i*resolutionx;
    for j=1:Totalres,
        mu=0+j*resolutiony;
        for w=1:Totalres,
            time=0+w*resolutionz;
            [A,B]=blsprice(start,Strike,mu,time,sigma,yield);
            ValueCall(i,j,w)=A;
            ValuePut(i,j,w)=B;
        end
    end
end

%% Derivatives
[Cx,Cy,Cz]=gradient(ValueCall,0.08,0.08,0.08);
CallGradient=sqrt(Cx.^2+Cy.^2+Cz.^2);

%% Plots
[x,y]=meshgrid(sigmavec,muvec);
[a,b]=max(sqrt(Cx.^2+Cy.^2+Cz.^2),[],3);
%[a,b]=max(ValueCall,[],3);
for i=1:25,
    for j=1:25,
        b(i,j)=timevec(b(i,j));
    end
end

k = hypot(x,y)<3;
    plot3k({x(k) y(k) b(k)},                                      ...
       'FontSize',12,                           ...
       'ColorData',a(k),'Marker',{'o', 10}, ...
       'Labels',{'','Volatility','Drift','Time','Option Value |Gradient'});%'Plottype','stem',

%% Slices
x = timevec(1:12:25);
[T,SCALES,X] = meshgrid(sigmavec,muvec,x);
sigslice = []; 
muslice = []; 
xslice = timevec(1:12:25);
SGRAM = CallGradient(:,:,1:12:25);
surfHandles = slice(T,SCALES,X,SGRAM,sigslice,muslice,xslice);
set(surfHandles,'FaceAlpha',0.8,'EdgeAlpha',0.)
xlabel('Volatility')
ylabel('Drift')
zlabel('Time')
colorbar