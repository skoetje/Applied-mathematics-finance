function Volatility=ImpliedVolatility(aSpot,aStrike,aTime,aOption,aIsPut)
sigma=0.2;
value=100 + aOption;
myExpiry=((169000-aTime)+3600*24*daysact('13-jun-2016',  '16-sep-2016'))/(3600*24*252);

while any(value-aOption > 1e-9)
    [call, put] = BlackScholes(aSpot,aStrike,myExpiry,0,sigma);
    value(aIsPut) = put(aIsPut);
    value(~aIsPut) = call(~aIsPut);
    
    sigma=sigma+(aOption-value)./Vega(aSpot,aStrike,aTime,0,sigma);
end
Volatility=sigma;
end

% function Volatility=ImpliedVolatility(aSpot,aStrike,aTime,aOption,aBoolean)
% %For vector of length 1
% sigma=0.2;
% value=100;
% myExpiry=((169000-aTime)+3600*24*daysact('10-jun-2016',  '16-sep-2016'))/(3600*24*252);
% 
% while value-aOption>0.01,
%     [call, put] = BlackScholes(aSpot,aStrike,myExpiry,0,sigma);
%     if aBoolean==1,
%         value=call;
%     else
%         value=put;
%     end
%     sigma=sigma+(aOption-value)/Vega(aSpot,aStrike,aTime,0,sigma);
% end
% Volatility=sigma;
% end