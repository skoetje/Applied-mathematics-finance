function [theSortedData, theSortedIndices] = SortStruct(aUnsortedData, aFieldNames, aSortModes)
% PURPOSE: Sorts a dataset either ascending or descending.
% IN:       - aUnsortedData (1x1 struct): The data to be sorted.
%           - aFieldNames (Nx1 string, optional): The fieldnames on which to sort.  If omitted 'timestamp' is used.
%           - aSortModes (Nx1 string, optional): The sortmode to be used.  If omitted, 'ASCEND' is used.
% OUT:      - theSortedData (1x1 struct): Sorted data.
%           - theSortedIndices (Nx1 integer): The indices which are used to sort the data.

if nargin < 2
    assert(isfield(aUnsortedData, 'timestamp'), ['Missing field "timestamp" to sort on, in ', mfilename()]);
    aFieldNames = {'timestamp'};
end
if ischar(aFieldNames)
    aFieldNames = {aFieldNames};
end
myFieldLength = length(aFieldNames);

if nargin < 3
    aSortModes = repmat({'ASCEND'}, myFieldLength, 1);
else
    aSortModes = ExpandSortModes(aSortModes, myFieldLength);
end

if ~HasElements(aUnsortedData)
    theSortedData = aUnsortedData;
    theSortedIndices = [];
    return
end

% ROKN: use sort() directly for performance, while sortrows() is used for the N>1 case
if myFieldLength == 1
    [~, theSortedIndices] = sort(aUnsortedData.(aFieldNames{1}));
    if strcmpi(aSortModes{1}, 'DESCEND')
        theSortedIndices = flipud(theSortedIndices);
    end
else
    % ROKN: if all fields are floats we don't need to use cells, this speeds up the sorting
    myAllFloatFields = true();
    for i = 1:myFieldLength
        if ~isfloat(aUnsortedData.(aFieldNames{i}))
            myAllFloatFields = false();
            break
        end
    end
    if myAllFloatFields
        myData = zeros(Count(aUnsortedData), myFieldLength);
    else
        myData = cell(Count(aUnsortedData), myFieldLength);
    end
    myColumnOrder = zeros(1, myFieldLength);
    for i = 1:myFieldLength
        if myAllFloatFields
            myData(:,i) = aUnsortedData.(aFieldNames{i});
        else
            if isnumeric(aUnsortedData.(aFieldNames{i}))
                myData(:,i) = num2cell(aUnsortedData.(aFieldNames{i}));
            elseif iscellstr(aUnsortedData.(aFieldNames{i}))
                myData(:,i) = aUnsortedData.(aFieldNames{i});
            else
                error(['Can not apply sorting; field: ', aFieldNames{i}, ...
                    ' is not numeric or a cellstring, in ', mfilename()]);
            end
        end
        if strcmpi(aSortModes{i}, 'DESCEND')
            myColumnOrder(i) = -i;
        else
            myColumnOrder(i) = i;
        end
    end
    [~, theSortedIndices] = sortrows(myData, myColumnOrder);
end
theSortedData = Subset(aUnsortedData, theSortedIndices);

end

function aSortModes = ExpandSortModes(aSortModes, aFieldLength)

if ischar(aSortModes)
    aSortModes = {aSortModes};
end

aSortModes(strcmpi(aSortModes, 'ASC'))  = {'ASCEND'};
aSortModes(strcmpi(aSortModes, 'DESC')) = {'DESCEND'};

%assert(all(ismember(aSortModes, {'ASCEND'; 'DESCEND'})), ['Unknown sort type found, in ', mfilename()]);

mySortLength = length(aSortModes);

if (mySortLength == 1) && (aFieldLength ~= mySortLength)
    aSortModes = repmat(aSortModes, aFieldLength, 1);
elseif (mySortLength > 1) && (aFieldLength ~= mySortLength)
    error(['Non-matching fieldnames and sortmodes, in ', mfilename()]);
end
end

function theHasElements = HasElements(aObjects)
% PURPOSE: Checks to see if a set of objects has at least 1 valid element. Preconditions:
%               - aObjects needs to be a vectorized struct.
%               - String values should have been initialized to ''
%               - Numeric values should have been initialized to 0.
% IN:       - aObjects (1x1 struct): The vectorized struct object that should be checked.
% OUT:      - theHasElements (1x1 logical): true if the vectorized struct has at least one defined element.

theHasElements = false();
if ~isempty(aObjects)
    if ~isstruct(aObjects)
        error(['WARN: No struct passed to ', mfilename(), ': ', class(aObjects)]);
    else
        myFields = fieldnames(aObjects);
        if ~isempty(myFields)
            theHasElements = ~isempty(aObjects.(myFields{1}));
        end
    end
end
end
