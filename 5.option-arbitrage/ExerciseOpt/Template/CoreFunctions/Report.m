function Report(aTrades, aSpot)
    

        % Vectors maken van de grote van de feed, zodat ze sneller gaan
        
myING = zeros(length(aTrades.side),2);

myCall800 = zeros(length(aTrades.side),2);
myCall900 = zeros(length(aTrades.side),2);
myCall950 = zeros(length(aTrades.side),2);
myCall975 = zeros(length(aTrades.side),2);
myCall1000 = zeros(length(aTrades.side),2);
myCall1025 = zeros(length(aTrades.side),2);
myCall1050 = zeros(length(aTrades.side),2);
myCall1100 = zeros(length(aTrades.side),2);
myCall1200 = zeros(length(aTrades.side),2);
myCall1400 = zeros(length(aTrades.side),2);
        
myPut800 = zeros(length(aTrades.side),2);
myPut900 = zeros(length(aTrades.side),2);
myPut950 = zeros(length(aTrades.side),2);
myPut975 = zeros(length(aTrades.side),2);
myPut1000  = zeros(length(aTrades.side),2);
myPut1025 = zeros(length(aTrades.side),2);
myPut1050 = zeros(length(aTrades.side),2);
myPut1100 = zeros(length(aTrades.side),2);
myPut1200 = zeros(length(aTrades.side),2);
myPut1400 = zeros(length(aTrades.side),2);
        

    % Cashflows per trade, elements >0 if sell, <0 if buy

    for i = 1:length(aTrades.side),
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL800')  
            myCall800(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall800(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT800')  
            myPut800(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut800(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL900')  
            myCall900(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall900(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT900')  
            myPut900(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut900(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL950')  
            myCall950(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall950(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT950')  
            myPut950(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut950(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL975')  
            myCall975(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall975(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT975')  
            myPut975(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut975(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL1000')  
            myCall1000(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1000(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT1000')  
            myPut1000(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut1000(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL1025')  
            myCall1025(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1025(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT1025')  
            myPut1025(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut1025(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL1050')  
            myCall1050(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1050(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT1050')  
            myCall1050(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1050(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL1100')  
            myCall1100(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1100(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL1200')  
            myCall1100(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1100(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT1200')  
            myPut1100(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut1100(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916CALL1400')  
            myCall1400(i,1) = aTrades.volume(i)* aTrades.side(i);
            myCall1400(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
        
        if strcmp(aTrades.ISIN(i),    'ING20160916PUT1400')  
            myPut1400(i,1) = aTrades.volume(i)* aTrades.side(i);
            myPut1400(i,2) = - aTrades.volume(i)* aTrades.side(i)*round(aTrades.price(i),10);
        end
    end

myINGPos = 0;    
% Vectors with positions
myCall800Pos = sum(myCall800(i,1));
myCall900Pos = sum(myCall900(i,1));
myCall950Pos = sum(myCall950(i,1));
myCall975Pos = sum(myCall975(i,1));
myCall1000Pos = sum(myCall1000(i,1));
myCall1025Pos = sum(myCall1025(i,1));
myCall1050Pos = sum(myCall1050(i,1));
myCall1100Pos = sum(myCall1100(i,1));
myCall1200Pos = sum(myCall1200(i,1));
myCall1400Pos = sum(myCall1400(i,1));

myPut800Pos = sum(myPut800(i,1));
myPut900Pos = sum(myPut900(i,1));
myPut950Pos = sum(myPut950(i,1));
myPut975Pos = sum(myPut975(i,1));
myPut1000Pos = sum(myPut1000(i,1));
myPut1025Pos = sum(myPut1025(i,1));
myPut1050Pos = sum(myPut1050(i,1));
myPut1100Pos = sum(myPut1100(i,1));
myPut1200Pos = sum(myPut1200(i,1));
myPut1400Pos = sum(myPut1400(i,1));

% Vectors with values
myINGVal = 0;

myCall800Val = sum(myCall800(i,2));
myCall900Val = sum(myCall900(i,2));
myCall950Val = sum(myCall950(i,2));
myCall975Val = sum(myCall975(i,2));
myCall1000Val = sum(myCall1000(i,2));
myCall1025Val = sum(myCall1025(i,2));
myCall1050Val = sum(myCall1050(i,2));
myCall1100Val = sum(myCall1100(i,2));
myCall1200Val = sum(myCall1200(i,2));
myCall1400Val = sum(myCall1400(i,2));


myPut800Val = sum(myPut800(i,2));
myPut900Val = sum(myPut900(i,2));
myPut950Val = sum(myPut950(i,2));
myPut975Val = sum(myPut975(i,2));
myPut1000Val = sum(myPut1000(i,2));
myPut1025Val = sum(myPut1025(i,2));
myPut1050Val = sum(myPut1050(i,2));
myPut1100Val = sum(myPut1100(i,2));
myPut1200Val = sum(myPut1200(i,2));
myPut1400Val = sum(myPut1400(i,2));



myINGPTot = 0;
myCall1000Tot = 0;

% assets = {'ING';'ING20160916CALL1000'};
% Position = [myINGPos;myCall1000Pos];
% Value = [myINGVal;myCall1000Val];
% Total = [myINGPTot;myCall1000Tot];
assets = {'ING';
'ING20160916PUT800'; 
'ING20160916CALL800';
'ING20160916PUT900'; 
'ING20160916CALL900';
'ING20160916PUT950'; 
'ING20160916CALL950';
'ING20160916PUT975';
'ING20160916CALL975';
'ING20160916PUT1000';
'ING20160916CALL1000';
'ING20160916PUT1025'; 
'ING20160916CALL1025';
'ING20160916PUT1050'; 
'ING20160916CALL1050';
'ING20160916PUT1100'; 
'ING20160916CALL1100';
'ING20160916PUT1200'; 
'ING20160916CALL1200';
'ING20160916PUT1400'; 
'ING20160916CALL1400'};

Position = [myINGPos;myPut800Pos;myCall800Pos;myCall900Pos;myPut900Pos;myCall950Pos;myPut950Pos;myCall975Pos;myPut975Pos;myCall1000Pos;myPut1000Pos;myCall1025Pos;myPut1025Pos;myCall1050Pos;myPut1050Pos;myCall1100Pos;myPut1100Pos;myCall1200Pos;myPut1200Pos;myCall1400Pos;myPut1400Pos
];
Total = [myINGTot;myPut800Tot;myCall800Tot;myCall900Tot;myPut900Tot;myCall950Tot;myPut950Tot;myCall975Tot;myPut975Tot;myCall1000Tot;myPut1000Tot;myCall1025Tot;myPut1025Tot;myCall1050Tot;myPut1050Tot;myCall1100Tot;myPut1100Tot;myCall1200Tot;myPut1200Tot;myCall1400Tot;myPut1400Tot
];

valueFiller = num2cell(ones((length(assets)),1));
Value = [valueFiller];


Table = table(Position,Value,Total,...
    'RowNames',assets)

Payments = 3;
fprintf('Payments: %d\n',Payments);
Value = 100;
fprintf('Value: %d\n',Value);
Delta = 0.3;
fprintf('Delta: %d\n',Delta);
Gamma = 0.4;
fprintf('Gamma: %d\n',Gamma);
    end
