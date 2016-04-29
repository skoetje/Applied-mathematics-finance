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
            myAEX=aBot.AEXDepth;
            myCHX=aBot.CHXDepth;
                        
            if (isempty(myAEX)==0)&&(isempty(myCHX)==0),
                if (isempty(myAEX.bidVolume)==0) && (isempty(myCHX.askVolume)==0),
                    if myAEX.bidLimitPrice(1)>myCHX.askLimitPrice(1),
                        myAskPrice = myCHX.askLimitPrice(1);
                        myBidPrice = myAEX.bidLimitPrice(1);
                        myAskVolume = min(myCHX.askVolume(1),myAEX.bidVolume(1));
                        myBidVolume = min(myAEX.bidVolume(1),myCHX.askVolume(1));
                        aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
                        aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
                    end
                end
                if (isempty(myAEX.askVolume)==0) && (isempty(myCHX.bidVolume)==0),
                    if myCHX.bidLimitPrice(1)>myAEX.askLimitPrice(1),
                        myAskPrice = myAEX.askLimitPrice(1);
                        myBidPrice = myCHX.bidLimitPrice(1);
                        myAskVolume = min(myAEX.askVolume(1),myCHX.bidVolume(1));
                        myBidVolume = min(myCHX.bidVolume(1),myAEX.askVolume(1));
                        aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
                        aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
                    end
                end
            end
        end
    end
end
