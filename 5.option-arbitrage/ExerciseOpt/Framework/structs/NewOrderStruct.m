function theStruct = NewOrderStruct(aSize)
% PURPOSE: Creates a new  order vectorized struct. Each individual field is a vector.
%           All fields have the same length.
% IN:       - aSize (1x1 integer): The number of  orders that room should be allocated for.
% OUT:      - theStruct (1x1 struct): A container for aSize  orders.

theStruct.limitPrice        = zeros(aSize, 1);
theStruct.volume            = zeros(aSize, 1);
theStruct.side              = zeros(aSize, 1);
theStruct.ISIN              = cell( aSize, 1);
theStruct.validity          = cell( aSize, 1);
theStruct.ownOrderId        = zeros(aSize, 1);
theStruct.autoTraderId      = zeros(aSize, 1);
theStruct.exchangeOrderId   = zeros(aSize, 1);
theStruct.receivedTimestamp = zeros(aSize, 1);
