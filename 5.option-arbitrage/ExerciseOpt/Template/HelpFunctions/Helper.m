function Helper(aStrike)
myStrike=aStrike;
     if myStrike==8, 
        aBot.Call800Depth.askVolume = aBot.Call800Depth.askVolume-myCallAskV;   
        aBot.Put800Depth.bidVolume = aBot.Put800Depth.bidVolume-myPutBidV;
    elseif myStrike==9,
        aBot.Call900Depth.askVolume = aBot.Call900Depth.askVolume-myCallAskV;   
        aBot.Put900Depth.bidVolume = aBot.Put900Depth.bidVolume-myPutBidV; 
    elseif myStrike==9.5,
        aBot.Call950Depth.askVolume = aBot.Call950Depth.askVolume-myCallAskV;   
        aBot.Put950Depth.bidVolume = aBot.Put950Depth.bidVolume-myPutBidV; 
    elseif myStrike==9.75,
        aBot.Call975Depth.askVolume = aBot.Call975Depth.askVolume-myCallAskV;   
        aBot.Put975Depth.bidVolume = aBot.Put975Depth.bidVolume-myPutBidV; 
    elseif myStrike==10,
        aBot.Call1000Depth.askVolume = aBot.Call1000Depth.askVolume-myCallAskV;   
        aBot.Put1000Depth.bidVolume = aBot.Put1000Depth.bidVolume-myPutBidV; 
    elseif myStrike==10.25,
        aBot.Call1025Depth.askVolume = aBot.Call1025Depth.askVolume-myCallAskV;   
        aBot.Put1025Depth.bidVolume = aBot.Put1025Depth.bidVolume-myPutBidV; 
    elseif myStrike==10.50,
        aBot.Call1050Depth.askVolume = aBot.Call1050Depth.askVolume-myCallAskV;   
        aBot.Put1050Depth.bidVolume = aBot.Put1050Depth.bidVolume-myPutBidV; 
    elseif myStrike==11,
        aBot.Call1100Depth.askVolume = aBot.Call1100Depth.askVolume-myCallAskV;   
        aBot.Put1100Depth.bidVolume = aBot.Put1100Depth.bidVolume-myPutBidV; 
    elseif myStrike==12,
        aBot.Call1200Depth.askVolume = aBot.Call1200Depth.askVolume-myCallAskV;   
        aBot.Put1200Depth.bidVolume = aBot.Put1200Depth.bidVolume-myPutBidV; 
    elseif myStrike==14,
        aBot.Call1400Depth.askVolume = aBot.Call1400Depth.askVolume-myCallAskV;   
        aBot.Put1400Depth.bidVolume = aBot.Put1400Depth.bidVolume-myPutBidV; 
     end
end