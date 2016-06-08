function x = normProbDensFun(x)
%PROBDENSFUN This function returns the reltive likelihood
% For the variable to take on a give on a certain value

% exp(1) is euler's number. The formula is slightly butchered,
% since normally you calculate ((x-mu)/sigma)^2 instead
% x^2, but simga is always 1 and mu is always 0 in our
% code.
x = (1/(1*sqrt(2*pi)))*exp(1)^(-0.5*(x^2));
end

