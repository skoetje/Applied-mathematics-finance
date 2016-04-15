classdef TradingRobot < AutoTrader
    properties
        CBKDepth
        DBKDepth
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            switch aDepth.ISIN
                case 'CBK_EUR'; aBot.CBKDepth = aDepth;
                case 'DBK_EUR'; aBot.DBKDepth = aDepth;
            end
            
            aBot.TryArbitrage();

            function TryArbitrage(aBot)
                 % Check how many times it should try to trade
            myCorrelation = 0.6;
            myPreviousCBKValue = 0;
            myPreviousDBKValue = 0;
            a=0;
            b=0;
            c=0;
            d=0;
            if (isempty(aBot.CBKDepth)==0),
                a=length(aBot.CBKDepth.askVolume);
            end
            if (isempty(aBot.DBKDepth)==0),
                b=length(aBot.DBKDepth.askVolume);
            end
            if (isempty(aBot.CBKDepth)==0),
                c=length(aBot.CBKDepth.bidVolume);
            end
            if (isempty(aBot.DBKDepth)==0),
                d=length(aBot.DBKDepth.bidVolume);
            end
            
            for k = 1:max([a,b,c,d]),
                myCBK=aBot.CBKDepth;
                myDBK=aBot.DBKDepth;
                if (isempty(myCBK)==0)&&(isempty(myDBK)==0),
                    if (isempty(myCBK.bidVolume)==0) && (isempty(myCBK.askVolume)==0) &&(isempty(myDBK.bidVolume)==0) && (isempty(myDBK.askVolume)==0),
                        myCBKValue=Valuate(myCBK.askLimitPrice(1),myCBK.askVolume,myCBK.bidLimitPrice(1),myCBK.bidVolume,0);
                        myDBKValue=Valuate(myDBK.askLimitPrice(1),myDBK.askVolume,myDBK.bidLimitPrice(1),myDBK.bidVolume,0);
                        
                        % Here we check the possibility for arbitrage
                        
                end
                end
            end
            end
          
                
        function Unwind(aBot)
            %%%% TO DO LATER
            
        end
        end
    end
end