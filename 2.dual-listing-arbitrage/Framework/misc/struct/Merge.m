function x = Merge(x, y)
% PURPOSE: Merges two vectorized object structs into one. With this, we mean a struct that contains a set of vectors of
% data that all have the same length. Note that all inputs should be from exactly the same datamodel and should all have
% fields with the same length.
% IN:       - varargin (Nx1 cell): A set of vectorized structs that need to be merged.
% OUT:      - theMergedObjects  (1x1 struct): A merged struct, potentially including duplicates.

fields = fieldnames(x)';
len = size(y.(fields{1}), 1);

for f = fields
	x.(f{1})(end+1:end+len, :) = y.(f{1});
end
