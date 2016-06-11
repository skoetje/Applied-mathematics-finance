function x = normCumDensFun(x)
% erf() and erfc() are core Matlab, no need to use the for-loop :-)

x = erfc(-x ./ sqrt(2)) / 2;
end
