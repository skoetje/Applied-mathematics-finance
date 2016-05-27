function theAns = IfElseScalar(aTest, aYes, aNo)
% PURPOSE: This replicates the behavior of the IfElse function in R or the conditional operator ?: in C++.
% IN:      - aTest (1x1 logical): A boolean
%          - aYes  (1x1 unknown): Value if the test is true
%          - aNo   (1x1 unknown): Value if test is false
% OUT:     - theAns (1x1 unknown): aYes where aTest is true and aNo where aTest is false.

if aTest
    theAns = aYes;
else
    theAns = aNo;
end
