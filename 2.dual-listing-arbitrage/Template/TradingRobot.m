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
            
            % myVirtualBook is our own updated book
            % useBook = 1: program should use own book (myVirtualBook)
            % useBook = 0: program should use external book (aBot)
            
            % Resets useBook and myVirtualBook if finishing HDU
            useBook=0;
            myVirtualBook=aBot;
        end
        
        function TryArbitrage(aBot)
            % myBot is the book used to make new orders
            % In principle, myBot should be the book from the exchange
            myBot=aBot;
            
            % However, if our own book (myVirtualbook) is better updated
            % than exchange book, myBot should be myVirtualbook
            if (exist('useBook')==1),
                if (useBook==1),
                    myBot=myVirtualBook;
                end
            end
            
            myAEX=myBot.AEXDepth;
            myCHX=myBot.CHXDepth;

            % Check whether book on any side is empty
            if (isempty(myAEX)==0)&&(isempty(myCHX)==0),
                if (isempty(myAEX.bidVolume)==0) && (isempty(myCHX.askVolume)==0),
                    
                    % Check viability to buy at CHX and sell at AEX
                    if myAEX.bidLimitPrice(1)>myCHX.askLimitPrice(1),
                        myAskPrice = myCHX.askLimitPrice(1);
                        myBidPrice = myAEX.bidLimitPrice(1);
                        myAskVolume = min(myCHX.askVolume(1),myAEX.bidVolume(1));
                        myBidVolume = min(myAEX.bidVolume(1),myCHX.askVolume(1));
                        
                        % Update myVirtualBook and useBook
                        myVirtualBook = myBot;
                        myVirtualBook.AEXDepth.bidVolume(1) = myVirtualBook.AEXDepth.bidVolume(1)-myBidVolume;
                        myVirtualBook.CHXDepth.askVolume(1) = myVirtualBook.CHXDepth.askVolume(1)-myAskVolume;
                        useBook=1;
                        
                        % Send orders
                        aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
                        aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
                    end
                end
                if (isempty(myAEX.askVolume)==0) && (isempty(myCHX.bidVolume)==0),
                    
                    % Check viability to buy at AEX and sell at CHX                    
                    if myCHX.bidLimitPrice(1)>myAEX.askLimitPrice(1),
                        myAskPrice = myAEX.askLimitPrice(1);
                        myBidPrice = myCHX.bidLimitPrice(1);
                        myAskVolume = min(myAEX.askVolume(1),myCHX.bidVolume(1));
                        myBidVolume = min(myCHX.bidVolume(1),myAEX.askVolume(1));
                        
                        % Update myVirtualBook and useBook
                        myVirtualBook = myBot;
                        myVirtualBook.CHXDepth.bidVolume(1) = myVirtualBook.CHXDepth.bidVolume(1)-myBidVolume;
                        myVirtualBook.AEXDepth.askVolume(1) = myVirtualBook.AEXDepth.askVolume(1)-myAskVolume;
                        useBook=1;
                        
                        % Send orders
                        aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'AEX_AKZA'}, {'IMMEDIATE'}, 0);
                        aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'CHX_AKZA'}, {'IMMEDIATE'}, 0);
                    end
                end
            end
        end
    end
end