classdef TradingRobot2 < AutoTrader
    properties
        CBKDepth
        DBKDepth
        TotalCBK
        TotalDBK
        AskPricesCBK
        BidPricesCBK
        AskPricesDBK
        BidPricesDBK
        Time
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            % Saves last depth
            switch aDepth.ISIN
                case 'CBK_EUR'; aBot.CBKDepth = aDepth;
                case 'DBK_EUR'; aBot.DBKDepth = aDepth;
            end
            
            % Try to arbitrage
            aBot.TryArbitrage();
        end
        
        function Unwind(aBot)
            
        myAssetsCBK = [];
        myAssetsDBK = [];
        for i= 1:length(aBot.ownTrades.side),
            if sum(char(aBot.ownTrades.ISIN(i))=='CBK_EUR')==7,
                myAssetsCBK(end+1)= aBot.ownTrades.volume(i)* aBot.ownTrades.side(i);
            end    
            if sum(char(aBot.ownTrades.ISIN(i))=='DBK_EUR')==7,
                myAssetsDBK(end+1)= aBot.ownTrades.volume(i)* aBot.ownTrades.side(i);
            end
        end
        myTotalCBK=sum(myAssetsCBK);
        myTotalDBK=sum(myAssetsDBK);
        
        %while myTotalCBK~=0,
        for k=1:length(aBot.CBKDepth.bidVolume),
            if myTotalCBK>0 && isempty(aBot.CBKDepth.bidVolume)==0,
                myBidVolume=min(myTotalCBK,aBot.CBKDepth.bidVolume(k));
                myBidPrice=aBot.CBKDepth.bidLimitPrice(k);
                aBot.SendNewOrder(myBidPrice, myBidVolume,  -1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                %aBot.ownTrades.volume(end+1)=myBidVolume;
                %aBot.ownTrades.price(end+1)=myBidPrice;     
                %aBot.ownTrades.side(end+1)=-1;       
                %aBot.ownTrades.ISIN(end+1)={'CBK_EUR'};   
                myTotalCBK=myTotalCBK-myBidVolume;
            end
        end
        for k=1:length(aBot.CBKDepth.askVolume),
            if myTotalCBK<0 && isempty(aBot.CBKDepth.askVolume)==0,
                myAskVolume=min(abs(myTotalCBK),aBot.CBKDepth.askVolume(k));
                myAskPrice=aBot.CBKDepth.askLimitPrice(k);
                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                %aBot.ownTrades.volume(end+1)=myAskVolume;
                %aBot.ownTrades.price(end+1)=myAskPrice;     
                %aBot.ownTrades.side(end+1)=1;       
                %aBot.ownTrades.ISIN(end+1)={'CBK_EUR'};   
                myTotalCBK=myTotalCBK+myAskVolume;
            end
        end
        %while myTotalDBK~=0,
        for k=1:length(aBot.DBKDepth.bidVolume),
            if myTotalDBK>0 && isempty(aBot.DBKDepth.bidVolume)==0,
                myBidVolume=min(myTotalDBK,aBot.DBKDepth.bidVolume(k));
                myBidPrice=aBot.DBKDepth.bidLimitPrice(k);
                aBot.SendNewOrder(myBidPrice, myBidVolume,  -1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                %aBot.ownTrades.volume(end+1)=myBidVolume;
                %aBot.ownTrades.price(end+1)=myBidPrice;     
                %aBot.ownTrades.side(end+1)=-1;       
                %aBot.ownTrades.ISIN(end+1)={'DBK_EUR'};     
                myTotalDBK=myTotalDBK-myBidVolume;
            end
        end
        for k=1:length(aBot.DBKDepth.askVolume),
            if myTotalDBK<0 && isempty(aBot.DBKDepth.askVolume)==0,
                myAskVolume=min(abs(myTotalDBK),aBot.DBKDepth.askVolume(k));
                myAskPrice=aBot.DBKDepth.askLimitPrice(k);
                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                %aBot.ownTrades.volume(end+1)=myAskVolume;
                %aBot.ownTrades.price(end+1)=myAskPrice;     
                %aBot.ownTrades.side(end+1)=1;       
                %aBot.ownTrades.ISIN(end+1)={'DBK_EUR'};                
                myTotalDBK=myTotalDBK+myAskVolume;
            end
        end
        if myTotalDBK<0,
            %aBot.SendNewOrder(max(aBot.AskPricesDBK), myTotalDBK,  1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
            aBot.ownTrades.volume(end+1)=abs(myTotalDBK);
            aBot.ownTrades.price(end+1)=max(aBot.AskPricesDBK);     
            aBot.ownTrades.side(end+1)=1;       
            aBot.ownTrades.ISIN(end+1)={'DBK_EUR'};   
            myTotalDBK=myTotalDBK+myTotalDBK;            
        end
        if myTotalDBK>0,
            %aBot.SendNewOrder(min(aBot.BidPricesDBK), myTotalDBK,  -1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
            aBot.ownTrades.volume(end+1)=abs(myTotalDBK);
            aBot.ownTrades.price(end+1)=min(aBot.BidPricesDBK);     
            aBot.ownTrades.side(end+1)=-1;       
            aBot.ownTrades.ISIN(end+1)={'DBK_EUR'}; 
            myTotalDBK=myTotalDBK-myTotalDBK;
        end
        if myTotalCBK<0,
            %aBot.SendNewOrder(max(aBot.AskPricesCBK), myTotalCBK,  1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
            aBot.ownTrades.volume(end+1)=abs(myTotalCBK);
            aBot.ownTrades.price(end+1)=max(aBot.AskPricesCBK);     
            aBot.ownTrades.side(end+1)=1;       
            aBot.ownTrades.ISIN(end+1)={'CBK_EUR'}; 
            myTotalCBK=myTotalCBK+myTotalCBK;
        end
        if myTotalCBK>0,
            %aBot.SendNewOrder(min(aBot.BidPricesCBK), myTotalCBK,  -1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
            aBot.ownTrades.volume(end+1)=abs(myTotalCBK);
            aBot.ownTrades.price(end+1)=min(aBot.BidPricesCBK);     
            aBot.ownTrades.side(end+1)=-1;       
            aBot.ownTrades.ISIN(end+1)={'CBK_EUR'}; 
            myTotalCBK=myTotalCBK-myTotalCBK;
        end
        end
        
        function TryArbitrage(aBot)
            %Time
            aBot.Time(end+1)=1;
            
            %Parameters
            myMaximum=10000000;
            
            mySlope1=2.4476;
            mySlope2=0.64051;
            mySlope3=3.0239;
            mySlope4=3.4227;
            
            myCrossing1=-3.3254;
            myCrossing2=10.5375;
            myCrossing3=-7.7428;
            myCrossing4=-10.6738;
            
            myR1=0.60027;
            myR2=0.31343;
            myR3=0.8634;
            myR4=0.82051;
            
            myDelta1=0.19446;
            myDelta2=0.15812;
            myDelta3=0.15903;
            myDelta4=0.18288;
            
            %Weighted average of regression parameters
            mySlope=(mySlope1*myR1^2+mySlope2*myR2^2+mySlope3*myR3^2+mySlope4*myR4^2)/(myR1^2+myR2^2+myR3^2+myR4^2);
            myCrossing=(myCrossing1*myR1^2+myCrossing2*myR2^2+myCrossing3*myR3^2+myCrossing4*myR4^2)/(myR1^2+myR2^2+myR3^2+myR4^2);
            myDelta=(myDelta1*myR1^2+myDelta2*myR2^2+myDelta3*myR3^2+myDelta4*myR4^2)/(myR1^2+myR2^2+myR3^2+myR4^2);
            
            myTakeRisk=myDelta*(aBot.Time(end)/3500);
            myLosePosition=myDelta*(3500-aBot.Time(end)/3500);
            
            % Check how many times it should try to trade
            a=0;
            b=0;
            c=0;
            d=0;
            if (isempty(aBot.CBKDepth)==0),
                a=length(aBot.CBKDepth.askVolume);
                if (isempty(aBot.CBKDepth.askVolume)==0),
                    aBot.AskPricesCBK(end+1)=max(aBot.CBKDepth.askLimitPrice);
                end
            end
            if (isempty(aBot.DBKDepth)==0),
                b=length(aBot.DBKDepth.askVolume);
                if (isempty(aBot.DBKDepth.askVolume)==0),
                    aBot.AskPricesDBK(end+1)=max(aBot.DBKDepth.askLimitPrice);
                end
            end
            if (isempty(aBot.CBKDepth)==0),
                c=length(aBot.CBKDepth.bidVolume);
                if (isempty(aBot.CBKDepth.bidVolume)==0),
                    aBot.BidPricesCBK(end+1)=min(aBot.CBKDepth.bidLimitPrice);
                end
            end
            if (isempty(aBot.DBKDepth)==0),
                d=length(aBot.DBKDepth.bidVolume);
                if (isempty(aBot.DBKDepth.bidVolume)==0),
                    aBot.BidPricesDBK(end+1)=min(aBot.DBKDepth.bidLimitPrice); 
                end
            end
            
            
            for k = 1:max([a,b,c,d]),
                myCBK=aBot.CBKDepth;
                myDBK=aBot.DBKDepth;                  
                if (isempty(myCBK)==0)&&(isempty(myDBK)==0),
                    if (isempty(myCBK.bidVolume)==0) && (isempty(myCBK.askVolume)==0) &&(isempty(myDBK.bidVolume)==0) && (isempty(myDBK.askVolume)==0),
                        myCBKvalue=Valuate(myCBK.askLimitPrice(1),myCBK.askVolume,myCBK.bidLimitPrice(1),myCBK.bidVolume,0);
                        myDBKvalue=Valuate(myDBK.askLimitPrice(1),myDBK.askVolume,myDBK.bidLimitPrice(1),myDBK.bidVolume,0);

                        if myDBKvalue>(mySlope)*myCBKvalue+myCrossing+myDelta,
                            myAskPrice = myCBK.askLimitPrice(1);
                            myBidPrice = myDBK.bidLimitPrice(1);
                            myAskVolume = min(myCBK.askVolume(1),myCBK.bidVolume(1));
                            myBidVolume = min(myDBK.bidVolume(1),myDBK.askVolume(1));

                            % Send orders and update book
                            aBot.DBKDepth.bidVolume(1) = aBot.DBKDepth.bidVolume(1)-myBidVolume;
                            aBot.CBKDepth.askVolume(1) = aBot.CBKDepth.askVolume(1)-myAskVolume;
                            
                            
                            if sum(aBot.TotalCBK)<myMaximum
                                aBot.TotalCBK(end+1)=myAskVolume*1;
                                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                            end
                            if sum(aBot.TotalDBK)>-myMaximum,
                                aBot.TotalDBK(end+1)=myBidVolume*-1;
                                aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                            end

                            %Update layers to make the program check if
                            %another layer trade is also viable
                            if aBot.DBKDepth.bidVolume(1) ==0,
                                for i=1:(length(aBot.DBKDepth.bidVolume)-1),
                                    aBot.DBKDepth.bidVolume(i)=aBot.DBKDepth.bidVolume(i+1);
                                    aBot.DBKDepth.bidLimitPrice(i)=aBot.DBKDepth.bidLimitPrice(i+1);
                                end
                                aBot.DBKDepth.bidVolume(end)=[];%0;
                                aBot.DBKDepth.bidLimitPrice(end)=[];%0.1;
                            end
                            if aBot.CBKDepth.askVolume(1) ==0,
                                for i=1:(length(aBot.CBKDepth.askVolume)-1),
                                    aBot.CBKDepth.askVolume(i)=aBot.CBKDepth.askVolume(i+1);
                                    aBot.CBKDepth.askLimitPrice(i)=aBot.CBKDepth.askLimitPrice(i+1);
                                end
                                aBot.CBKDepth.askVolume(end)=[];%0;
                                aBot.CBKDepth.askLimitPrice(end)=[];%1000000;
                            end
                        end
                        %Again check for statistical arbitrage
                        if myDBKvalue<(mySlope)*myCBKvalue+myCrossing-myDelta,
                            myAskPrice = myDBK.askLimitPrice(1);
                            myBidPrice = myCBK.bidLimitPrice(1);
                            myAskVolume = min(myDBK.askVolume(1),myDBK.bidVolume(1));
                            myBidVolume = min(myCBK.bidVolume(1),myCBK.askVolume(1));

                            % Send orders and update book
                            aBot.CBKDepth.bidVolume(1) = aBot.CBKDepth.bidVolume(1)-myBidVolume;
                            aBot.DBKDepth.askVolume(1) = aBot.DBKDepth.askVolume(1)-myAskVolume;
                            if sum(aBot.TotalDBK)<myMaximum,
                                aBot.TotalDBK(end+1)=myAskVolume*1;
                                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                            end
                            if sum(aBot.TotalCBK)>-myMaximum,
                                aBot.TotalCBK(end+1)=myBidVolume*-1;
                                aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                            end

                            %Update layers to make the program check if
                            %another layer trade is also viable
                            if aBot.CBKDepth.bidVolume(1) ==0,
                                for i=1:(length(aBot.CBKDepth.bidVolume)-1),
                                    aBot.CBKDepth.bidVolume(i)=aBot.CBKDepth.bidVolume(i+1);
                                    aBot.CBKDepth.bidLimitPrice(i)=aBot.CBKDepth.bidLimitPrice(i+1);
                                end
                                aBot.CBKDepth.bidVolume(end)=[];%0;
                                aBot.CBKDepth.bidLimitPrice(end)=[];%0.1;
                            end
                            if aBot.DBKDepth.askVolume(1) ==0,
                                for i=1:(length(aBot.DBKDepth.askVolume)-1),
                                    aBot.DBKDepth.askVolume(i)=aBot.DBKDepth.askVolume(i+1);
                                    aBot.DBKDepth.askLimitPrice(i)=aBot.DBKDepth.askLimitPrice(i+1);
                                end
                                aBot.DBKDepth.askVolume(end)=[];%;
                                aBot.DBKDepth.askLimitPrice(end)=[];%10000000;
                            end
                        end
                    end
                end
            end
        end
    end
end