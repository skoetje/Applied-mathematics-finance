function [Call, Put] = blackScholes(Price, Strike, Rate, Time, Volatility, Yield)
    
[Call, Put] = blsprice(Price, Strike, Rate, Time, Volatility, Yield);
% disp(Call);
% disp(Put);




end


% Values for the Black Sholes as in exercise 1
%%
%% should return 0.0462 (and you need financial toolbox)
% Price = 11;
% Strike = 12;
% Rate = 0.02;
% Time = 82/252;
% Volatility = 0.12;
% Yield = 0;
