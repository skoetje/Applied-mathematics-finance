classdef TradingRobot < AutoTrader
    properties
        %TradeTimes
        TradeTimes
        
        
        %Saving Spots
        SpotHistory
        AskHistory
        BidHistory
        CallDeltaPos
        
        %Depths to be loaded in
        StockDepth
        
        Call800Depth
        Call900Depth
        Call950Depth
        Call975Depth
        Call1000Depth
        Call1025Depth
        Call1050Depth
        Call1100Depth
        Call1200Depth
        Call1400Depth
        
        Put800Depth
        Put900Depth
        Put950Depth
        Put975Depth
        Put1000Depth
        Put1025Depth
        Put1050Depth
        Put1100Depth
        Put1200Depth
        Put1400Depth
        
        %Time for the unwind function
        Time
        Call1000OptionVec
        Call1000OptionVecV
        
        %Savings for plotting
        TotalStock
        DeltaPositionAft
        DeltaPositionBef
        PutDeltaVec
        CallGammaVec
        PutGammaVec
        StartDeltas
        DeltaConstantG
        Gammas
        myStrikeVec
        
        
        Tester1
        Tester2
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            if length(aBot.Time)==0,
                aBot.Time(1)=1;
            end
            TimePoint=aBot.Time(end);  
            
            %Switch between whether the depth concerns option or stock
            switch aDepth.ISIN
                case 'ING'; aBot.StockDepth = aDepth;
                case 'ING20160916PUT800'; aBot.Put800Depth = aDepth;
                case 'ING20160916CALL800'; aBot.Call800Depth = aDepth;
                case 'ING20160916PUT900'; aBot.Put900Depth = aDepth;
                case 'ING20160916CALL900'; aBot.Call900Depth = aDepth;
                case 'ING20160916PUT950'; aBot.Put950Depth = aDepth;
                case 'ING20160916CALL950'; aBot.Call950Depth = aDepth;
                case 'ING20160916PUT975'; aBot.Put975Depth = aDepth;
                case 'ING20160916CALL975'; aBot.Call975Depth = aDepth;
                case 'ING20160916PUT1000'; aBot.Put1000Depth = aDepth;
                case 'ING20160916CALL1000'; aBot.Call1000Depth = aDepth;
                case 'ING20160916PUT1025'; aBot.Put1025Depth = aDepth;
                case 'ING20160916CALL1025'; aBot.Call1025Depth = aDepth;
                case 'ING20160916PUT1050'; aBot.Put1050Depth = aDepth;
                case 'ING20160916CALL1050'; aBot.Call1050Depth = aDepth;
                case 'ING20160916CallDeltaVecAFTPUT1100'; aBot.Put1100Depth = aDepth;
                case 'ING20160916CALL1100'; aBot.Call1100Depth = aDepth;
                case 'ING20160916PUT1200'; aBot.Put1200Depth = aDepth;
                case 'ING20160916CALL1200'; aBot.Call1200Depth = aDepth;
                case 'ING20160916PUT1400'; aBot.Put1400Depth = aDepth;
                case 'ING20160916CALL1400'; aBot.Call1400Depth = aDepth;
            end
                        
            aBot.BidHistory(TimePoint)=10.4;
            if isempty(aBot.StockDepth.bidLimitPrice)==0,
                aBot.BidHistory(TimePoint)=aBot.StockDepth.bidLimitPrice(1);
            end
            
            aBot.AskHistory(TimePoint)=10.4;
            if isempty(aBot.StockDepth.askLimitPrice)==0,
                aBot.AskHistory(TimePoint)=aBot.StockDepth.askLimitPrice(1);
            end
            
            aBot.SpotHistory(TimePoint)=10.4;
            if isempty(aBot.StockDepth.bidLimitPrice)==0 && isempty(aBot.StockDepth.askLimitPrice)==0,
                aBot.SpotHistory(TimePoint)=(aBot.StockDepth.bidLimitPrice(1)+aBot.StockDepth.askLimitPrice(1))/2;
            end
            
            %aBot.OptionBidHistory(TimePoint)=1;
            
            aBot.myStrikeVec=[8,9,9.5,9.75,10,10.25,10.5,11,12,14];
            myInitialAmount=round(1000/length(aBot.myStrikeVec));
            %myISINs=GetAllOptionISINs;
            aBot.DeltaConstantG(TimePoint,:)=zeros(length(aBot.myStrikeVec),1);
            
            %Initializing       
            for i=1:length(aBot.myStrikeVec),
                myStrike=aBot.myStrikeVec(i);
                if isempty(OptionDepth(aBot,myStrike,1))==0;
                    myOptionDepth=OptionDepth(aBot,myStrike,1);
                    aBot.StartDeltas(TimePoint,i)=DeltaStart(aBot,myStrike,TimePoint,1);
                    aBot.DeltaConstantG(TimePoint,i)=NaN;
                    aBot.Gammas(TimePoint,i)=Gamma(aBot,myStrike,TimePoint,1);

                    if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
                        if sum(strcmp(aBot.ownTrades.ISIN,myOptionDepth.ISIN))==0 && length(aBot.ownTrades.price)<=16,
                            StartHedge2(aBot,TimePoint,myStrike,myInitialAmount,1)
                        end
                    end
                end
            end
            aBot.DeltaPositionBef(TimePoint)=0;
            aBot.DeltaPositionAft(TimePoint)=0;
            if isempty(aBot.StockDepth.bidVolume)==0 && isempty(aBot.StockDepth.askVolume)==0,
                if length(aBot.ownTrades.price)>16,
                    for i=1:length(aBot.myStrikeVec),
                        myStrike=aBot.myStrikeVec(i);
                        aBot.DeltaConstantG(TimePoint,i)=Delta_CGamma(aBot,myStrike,1);
                    end
                    aBot.DeltaPositionBef(TimePoint)=DeltaPosition(aBot,aBot.myStrikeVec);
                    RehedgerStocks2(aBot,TimePoint,aBot.myStrikeVec);
                    aBot.DeltaPositionAft(TimePoint)=DeltaPosition(aBot,aBot.myStrikeVec);
                end
            end
            
            if sum(TimePoint/100 == linspace(0,1000,1001))==1,
                TimePoint
            end
            
            %CallPutParityCheck(aBot);
            %aBot.PutDeltaVec(TimePoint)=Delta(aBot,10,TimePoint,0);
            %aBot.CallGammaVec(TimePoint)=Gamma(aBot,10,TimePoint,1);
            %aBot.PutGammaVec(TimePoint)=Gamma(aBot,10,TimePoint,0);
            %Rehedger(aBot,TimePoint)
            %TryArbitrage(aBot);
            %DeltaHedge(aBot,TimePoint);
            %DeltaHedge_constantDelta(aBot,TimePoint);
            %aBot.GammaHedge();
            %aBot.VegaHedge();
            Unwind(aBot,TimePoint);
            aBot.Time(length(aBot.Time)+1)=length(aBot.Time)+2;
        end
    end
end