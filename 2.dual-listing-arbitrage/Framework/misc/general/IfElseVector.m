function theAns = IfElseVector(aTest, aYes, aNo)
% PURPOSE: This replicates the behavior of the IfElse function in R or the conditional operator ?: in C++.
% IN:      - aTest (Nx1 logical): A boolean vector
%          - aYes  (Nx1 unknown): Values if the test is true
%          - aNo   (Nx1 unknown): Values if test is false
% OUT:     - theAns (Nx1 unknown): aYes where aTest is true and aNo where aTest is false.

theAns = +(aTest);
theAns(aTest) = aYes(aTest);
theAns(~aTest) = aNo(aTest);
