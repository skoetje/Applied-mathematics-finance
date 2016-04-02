function theAns = IfElse(aTest, aYes, aNo)
% PURPOSE: This replicates the behavior of the IfElse function in R or the conditional operator ?: in C++.
% IN:      - aTest (Nx1 logical): A boolean array
%          - aYes  (1x1 unknown): Value if the test is true
%          - aNo   (1x1 unknown): Value if test is false
% OUT:     - theAns (Nx1 unknown): An array aYes where aTest is true and aNo where aTest is false.

theAns = +(aTest);
theAns( aTest) = aYes;
theAns(~aTest) = aNo;
