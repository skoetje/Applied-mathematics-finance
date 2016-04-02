function theStruct = CreateOrderStruct(aLimitPrice, aVolume, aSide, aISIN, aValidity, aOwnOrderId, aAutoTraderId)

theStruct.limitPrice        = aLimitPrice;
theStruct.volume            = aVolume;
theStruct.side              = aSide;
theStruct.ISIN              = aISIN;
theStruct.validity          = aValidity;
theStruct.ownOrderId        = aOwnOrderId;
theStruct.autoTraderId      = aAutoTraderId;
theStruct.exchangeOrderId   = 0;
theStruct.receivedTimestamp = 0;
