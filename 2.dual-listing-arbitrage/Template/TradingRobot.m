classdef TradingRobot < AutoTrader
    properties
        AEXDepth
        CHXDepth
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            % Saves last depth
            switch aDepth.ISIN
                case 'AEX_AKZA'; aBot.AEXDepth = aDepth;
                case 'CHX_AKZA'; aBot.CHXDepth = aDepth;
            end
            % Try to arbitrage
            aBot.TryArbitrage();
        end

        function TryArbitrage(aBot)
            if isempty(aBot.AEXDepth.bidVolume)==0 && isempty(aBot.CHXDepth.askVolume)==0,
                if aBot.AEXDepth.bidLimitPrice(1)>aBot.CHXDepth.askLimitPrice(1),
                    myAskPrice = aBot.CHXDepth.askLimitPrice(1);
                    myBidPrice = aBot.AEXDepth.bidLimitPrice(1);
                    myAskVolume = min(aBot.CHXDepth.askVolume(1),aBot.AEXDepth.bidVolume(1));
                    myBidVolume = min(aBot.AEXDepth.bidVolume(1),aBot.CHXDepth.askVolume(1));
                    aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
                    aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
                    disp('Buy at CHX')
                end
            end
            if isempty(aBot.AEXDepth.askVolume)==0 && isempty(aBot.CHXDepth.bidVolume)==0,
                if aBot.CHXDepth.bidLimitPrice(1)>aBot.AEXDepth.askLimitPrice(1),
                    myAskPrice = aBot.AEXDepth.askLimitPrice(1);
                    myBidPrice = aBot.CHXDepth.bidLimitPrice(1);
                    myAskVolume = min(aBot.AEXDepth.askVolume(1),aBot.CHXDepth.bidVolume(1));
                    myBidVolume = min(aBot.CHXDepth.bidVolume(1),aBot.AEXDepth.askVolume(1));
                    aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
                    aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
                    disp('Buy at AEX')
                end
            end
        end
    end
end