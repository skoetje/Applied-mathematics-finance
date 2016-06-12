function myOptionDepth=OptionDepth(aBot,aStrike,aBoolean)
if aBoolean==1,
    if aStrike==8,
        myOptionDepth=aBot.Call800Depth;
    elseif aStrike==9,
        myOptionDepth=aBot.Call900Depth;
    elseif aStrike==9.5,
        myOptionDepth=aBot.Call950Depth;
    elseif aStrike==9.75,
        myOptionDepth=aBot.Call975Depth;
    elseif aStrike==10,
        myOptionDepth=aBot.Call1000Depth;
    elseif aStrike==10.25,
        myOptionDepth=aBot.Call1025Depth;
    elseif aStrike==10.50,
        myOptionDepth=aBot.Call1050Depth;
    elseif aStrike==11,
        myOptionDepth=aBot.Call1100Depth;
    elseif aStrike==12,
        myOptionDepth=aBot.Call1200Depth;
    elseif aStrike==14,
        myOptionDepth=aBot.Call1400Depth;
    end
elseif aBoolean==0,
    if aStrike==8,
        myOptionDepth=aBot.Put800Depth;
    elseif aStrike==9,
        myOptionDepth=aBot.Put900Depth;
    elseif aStrike==9.5,
        myOptionDepth=aBot.Put950Depth;
    elseif aStrike==9.75,
        myOptionDepth=aBot.Put975Depth;
    elseif aStrike==10,
        myOptionDepth=aBot.Put1000Depth;
    elseif aStrike==10.25,
        myOptionDepth=aBot.Put1025Depth;
    elseif aStrike==10.50,
        myOptionDepth=aBot.Put1050Depth;
    elseif aStrike==11,
        myOptionDepth=aBot.Put1100Depth;
    elseif aStrike==12,
        myOptionDepth=aBot.Put1200Depth;
    elseif aStrike==14,
        myOptionDepth=aBot.Put1400Depth;
    end
end
end