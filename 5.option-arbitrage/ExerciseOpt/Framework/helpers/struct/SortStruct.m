function aStruct = SortStruct(aStruct, aFieldNames, aSortModes)
% PURPOSE: Sorts a dataset either in ascending or descending order.
% IN:      - aStruct (1x1 struct): The vectorized struct to be sorted.
%          - aFieldNames (Nx1 string): The fieldnames on which to sort. 
%            For now, these fields must contain numeric data.
%          - aSortModes (Nx1 integer): The directions to sort in (+1 = ascending, -1 = descending).
% OUT:     - aStruct (1x1 struct): The sorted vectorized struct.

myFieldLength = length(aFieldNames);
mySortingData = zeros(Count(aStruct), myFieldLength);

for i = 1:myFieldLength
    mySortingData(:,i) = aStruct.(aFieldNames{i}) * aSortModes{i};
end

[~, theIndices] = sortrows(mySortingData);
aStruct = Subset(aStruct, theIndices);
