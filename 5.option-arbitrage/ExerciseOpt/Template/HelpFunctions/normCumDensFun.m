function [x] = normCumDensFun(x)

sum = x;
value = x;

for i=1:100,
    value=(value*x^2/(2*i+1));
    sum = sum + value;    
end
x = 0.5+(sum/sqrt(2*pi))*exp(-(x^2)/2);
end

