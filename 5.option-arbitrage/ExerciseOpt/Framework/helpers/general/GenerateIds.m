function theNextIds = GenerateIds(aCount)
persistent myLastId;

if isempty(myLastId)
    myLastId = 0;
end

theNextIds = myLastId + (1 : aCount)';
myLastId   = myLastId + aCount;
