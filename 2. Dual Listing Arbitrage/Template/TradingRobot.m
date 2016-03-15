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
            % NB These four variables contain dummy values
            myAskPrice  = 1;
            myBidPrice  = 100;
            myAskVolume = 1;
            myBidVolume = 1;

            aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
            aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
        end
    end
end
