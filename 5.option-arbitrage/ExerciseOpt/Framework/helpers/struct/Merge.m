function aStruct = Merge(aStruct, anotherStruct)
% PURPOSE: Merges two vectorized structs into one. Both structs must have the same datamodel.
% IN:      - aStruct (1x1 struct): The first vectorized struct to be merged.
%          - anotherStruct (1x1 struct): The second vectorized struct to be merged.
% OUT:     - aStruct (1x1 struct): The merged vectorized struct.

fields = fieldnames(aStruct)';
len = size(anotherStruct.(fields{1}), 1);

for f = fields
	aStruct.(f{1})(end+1:end+len, :) = anotherStruct.(f{1});
end
