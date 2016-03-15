function aObjects = Subset(aObjects, aIndices)
% PURPOSE:  Returns a subset from a set of objects, based on a vector indices.
% IN:       - aObjects (1x1 struct): Struct of vectorized elements.
%           - aIndices (Nx1 integer): Integer vector like [1, 3, 4 ...] indicating which indices should 
%           be part of the subset. Also supports logical vector (Nx1 logical)
% OUT:      - theSubset (1x1 struct): The subset of objects.

for f = fieldnames(aObjects)';
    aObjects.(f{1}) = aObjects.(f{1})(aIndices, :);
end
