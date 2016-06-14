% aSpot = 10;
% aStrike = 10;
% aTime = 1;
% aOption = 0.6600;
% 
% for i = 0.1:20,
% x = AImpliedVolatility(aSpot,i,aTime,aOption,1);
% fprintf('Strike: %d\n',i);
% fprintf('Volatility: %d\n',x);
% end
x = GetAllOptionISINs();
for i = 1:length(x),
    disp(x(i));
end