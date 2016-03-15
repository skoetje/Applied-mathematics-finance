function ForEach(aStruct, aFunction)
% PURPOSE: Applies a function to each of the elements in a vectorized struct.
% IN:      - aStruct (1x1 struct): A vectorized struct object.
%          - aFunction (1x1 function): A function to apply.

for i = 1 : Count(aStruct)
    aFunction(Subset(aStruct, i));
end
