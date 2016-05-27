function aStruct = Subset(aStruct, aIndices)
% PURPOSE: Returns a subset of a vectorized struct, based on a vector indices.
% IN:      - aStruct (1x1 struct): Vectorized struct.
%          - aIndices (Nx1 integer or logical): Vector indicating which elements should be kept. 
% OUT:     - aStruct (1x1 struct): The subset vectorized struct.

for f = fieldnames(aStruct)';
    aStruct.(f{1}) = aStruct.(f{1})(aIndices, :);
end
