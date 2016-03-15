function theStruct = NewTradeStruct(aSize)
% PURPOSE: Creates a new Trade vectorized struct. Each individual field is a vector.
%          All fields have the same length.
% IN:      - aSize (1x1 integer): The number of trades that room should be allocated for.
% OUT:     - theStruct (1x1 struct): A container for aSize trades.

theStruct.price               = zeros(aSize, 1);
theStruct.volume              = zeros(aSize, 1);
theStruct.ISIN                = cell( aSize, 1);
theStruct.exchangeBuyOrderId  = zeros(aSize, 1);
theStruct.exchangeSellOrderId = zeros(aSize, 1);
theStruct.timestamp           = zeros(aSize, 1);
theStruct.side                = zeros(aSize, 1); % 0 for reported trade, only used for ownTrades
