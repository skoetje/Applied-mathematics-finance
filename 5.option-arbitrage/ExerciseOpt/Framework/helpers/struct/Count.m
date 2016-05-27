function theCount = Count(aStruct)
% PURPOSE: Returns the number of elements in a vectorized struct.
% IN:      - aStruct (1x1 struct): A vectorized struct object that should be counted.
% OUT:     - theCount (1x1 integer): Number of rows in the vectorized struct.

myFields = fieldnames(aStruct);
if ~isempty(myFields)
    theCount = size(aStruct.(myFields{1}), 1);
else
    theCount = 0;
end
