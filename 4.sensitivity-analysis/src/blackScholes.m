function [Call, Put] = blackScholes(Price, Strike, Rate, Time, Volatility, Yield)
    
[Call, Put] = blsprice(Price, Strike, Rate, Time, Volatility, Yield);

end