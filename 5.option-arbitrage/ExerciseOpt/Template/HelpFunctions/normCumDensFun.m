function [x] = normCumDensFun(x)
x = erfc(-x ./ sqrt(2)) / 2;
end

