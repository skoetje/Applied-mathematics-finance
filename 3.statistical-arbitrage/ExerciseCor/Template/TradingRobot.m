classdef TradingRobot < AutoTrader
    properties%Hoi ik ben Mark
        CBKDepth
        DBKDepth
        
        %TotalCBK and DBK are to gain insight in current position
        TotalCBK
        TotalDBK
        
        %The ask- and bidprices per stock are for the part of the unwind
        %function that will check what the worst ask/bid prices were during
        %the whole feed (this is optional)
        AskPricesCBK
        BidPricesCBK
        AskPricesDBK
        BidPricesDBK
        
        %Time is to know current time in the feed
        Time
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            switch aDepth.ISIN
                case 'CBK_EUR'; aBot.CBKDepth = aDepth;
                case 'DBK_EUR'; aBot.DBKDepth = aDepth;
            end
            
            aBot.TryArbitrage();
        end
        
        function Unwind(aBot)
        
        % Reduce final position using final books
        % First get final position:    
        myTotalCBK=sum(aBot.TotalCBK);
        myTotalDBK=sum(aBot.TotalDBK);
        
        % Now check available trades and send them if they reduce position:
        for k=1:length(aBot.CBKDepth.bidVolume),
            if myTotalCBK>0 && isempty(aBot.CBKDepth.bidVolume)==0,
                myBidVolume=min(myTotalCBK,aBot.CBKDepth.bidVolume(1));
                myBidPrice=aBot.CBKDepth.bidLimitPrice(1);
                aBot.SendNewOrder(myBidPrice, myBidVolume,  -1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);  
                myTotalCBK=myTotalCBK-myBidVolume;
            end
        end
        for k=1:length(aBot.CBKDepth.askVolume),
            if myTotalCBK<0 && isempty(aBot.CBKDepth.askVolume)==0,
                myAskVolume=min(abs(myTotalCBK),aBot.CBKDepth.askVolume(1));
                myAskPrice=aBot.CBKDepth.askLimitPrice(1);
                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                myTotalCBK=myTotalCBK+myAskVolume;
            end
        end
        for k=1:length(aBot.DBKDepth.bidVolume),
            if myTotalDBK>0 && isempty(aBot.DBKDepth.bidVolume)==0,
                myBidVolume=min(myTotalDBK,aBot.DBKDepth.bidVolume(1));
                myBidPrice=aBot.DBKDepth.bidLimitPrice(1);
                aBot.SendNewOrder(myBidPrice, myBidVolume,  -1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);   
                myTotalDBK=myTotalDBK-myBidVolume;
            end
        end
        for k=1:length(aBot.DBKDepth.askVolume),
            if myTotalDBK<0 && isempty(aBot.DBKDepth.askVolume)==0,
                myAskVolume=min(abs(myTotalDBK),aBot.DBKDepth.askVolume(1));
                myAskPrice=aBot.DBKDepth.askLimitPrice(1);
                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                myTotalDBK=myTotalDBK+myAskVolume;
            end
        end
        
        % Second part: the reduction of final position to zero using worst
        % case scenario bid/ask prices. This is intentionally left in
        % comments to gain insight in final position.
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         if myTotalDBK<0,
%             aBot.ownTrades.volume(end+1)=abs(myTotalDBK);
%             aBot.ownTrades.price(end+1)=max(aBot.AskPricesDBK);     
%             aBot.ownTrades.side(end+1)=1;       
%             aBot.ownTrades.ISIN(end+1)={'DBK_EUR'};   
%             myTotalDBK=myTotalDBK+myTotalDBK;            
%         end
%         if myTotalDBK>0,
%             aBot.ownTrades.volume(end+1)=abs(myTotalDBK);
%             aBot.ownTrades.price(end+1)=min(aBot.BidPricesDBK);     
%             aBot.ownTrades.side(end+1)=-1;       
%             aBot.ownTrades.ISIN(end+1)={'DBK_EUR'}; 
%             myTotalDBK=myTotalDBK-myTotalDBK;
%         end
%         if myTotalCBK<0,
%             aBot.ownTrades.volume(end+1)=abs(myTotalCBK);
%             aBot.ownTrades.price(end+1)=max(aBot.AskPricesCBK);     
%             aBot.ownTrades.side(end+1)=1;       
%             aBot.ownTrades.ISIN(end+1)={'CBK_EUR'}; 
%             myTotalCBK=myTotalCBK+myTotalCBK;
%         end
%         if myTotalCBK>0,
%             aBot.ownTrades.volume(end+1)=abs(myTotalCBK);
%             aBot.ownTrades.price(end+1)=min(aBot.BidPricesCBK);     
%             aBot.ownTrades.side(end+1)=-1;       
%             aBot.ownTrades.ISIN(end+1)={'CBK_EUR'}; 
%             myTotalCBK=myTotalCBK-myTotalCBK;
%         end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
        
        function TryArbitrage(aBot)
            % Time; only the length of the property is used
            aBot.Time(end+1)=1;
            
            % Regression parameters of the form:
            % "DBK = MySlope * CBK + myCrossing"
            % Using the four different feeds
            mySlope1=2.3969;
            mySlope2=0.65231;
            mySlope3=2.9922;
            mySlope4=3.4283;
            
            myCrossing1=-1.4621;
            myCrossing2=5.2221;
            myCrossing3=-3.7514;
            myCrossing4=-5.3519;
            
            myR1= 0.59377;
            myR2=0.31892;
            myR3=0.8616;
            myR4=0.81649;
            
            myDelta1=0.16725;
            myDelta2=0.13478;
            myDelta3=0.13629;
            myDelta4=0.15749;
            
            % Weighted average of regression parameters
            mySlope=(mySlope1*myR1+mySlope2*myR2+mySlope3*myR3+mySlope4*myR4)/(myR1+myR2+myR3+myR4);
            myCrossing=(myCrossing1*myR1+myCrossing2*myR2+myCrossing3*myR3+myCrossing4*myR4)/(myR1+myR2+myR3+myR4);
            myDelta=(myDelta1*myR1+myDelta2*myR2+myDelta3*myR3+myDelta4*myR4)/(myR1+myR2+myR3+myR4);
                        
            % Check how many times it should try to trade (this is to check
            % multiple layers)
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
            
            % Now define some parameters for the Delta functions:
            myTotalTime=3417.; % Approximation of total time
            myChangepoint=0.5; % Where to change functions
            myKappa=0.25;      % Determines start delta
            myTimeDelta1st=myDelta*sin(2*pi*sum(aBot.Time)/(myTotalTime*4*myChangepoint));
            myTimeDelta2nd=myDelta*(abs(sum(aBot.Time)-myTotalTime*myChangepoint)/myTotalTime);%sin(2*pi*(sum(aBot.Time)-TotalTime/2)/(TotalTime*2));
            
            % Now define Delta for the first half...
            if sum(aBot.Time)<(myTotalTime*myChangepoint),
                myDeltaBuyCBK=(1-myKappa)*myTimeDelta1st+myKappa*myDelta;
                myDeltaSellCBK=(1-myKappa)*myTimeDelta1st+myKappa*myDelta;
                myDeltaBuyDBK=(1-myKappa)*myTimeDelta1st+myKappa*myDelta;
                myDeltaSellDBK=(1-myKappa)*myTimeDelta1st+myKappa*myDelta;
                
            % ... and the second half:
            else
                myLowDeltaCBK=myDelta-myTimeDelta2nd*(1+abs(sum(aBot.TotalCBK))/50);
                myHighDeltaCBK=myDelta+myTimeDelta2nd*(1+abs(sum(aBot.TotalCBK))/50);
                myLowDeltaDBK=myDelta-myTimeDelta2nd*(1+abs(sum(aBot.TotalDBK))/50);
                myHighDeltaDBK=myDelta+myTimeDelta2nd*(1+abs(sum(aBot.TotalDBK))/50);
                
                % Here we check the different cases of positions
                if sum(aBot.TotalCBK)<0,
                    myDeltaBuyCBK=myLowDeltaCBK;
                    myDeltaSellCBK=myHighDeltaCBK;
                end

                if sum(aBot.TotalDBK)<0,
                    myDeltaBuyDBK=myLowDeltaDBK;
                    myDeltaSellDBK=myHighDeltaDBK;
                end

                if sum(aBot.TotalCBK)>=0,
                    myDeltaBuyCBK=myHighDeltaCBK;
                    myDeltaSellCBK=myLowDeltaCBK;
                end

                if sum(aBot.TotalDBK)>=0,
                    myDeltaBuyDBK=myHighDeltaDBK;
                    myDeltaSellDBK=myLowDeltaDBK;
                end
            end
            
            % Now onto the trading!
            for k = 1:max([a,b,c,d]),
                myCBK=aBot.CBKDepth;
                myDBK=aBot.DBKDepth;                  
                if (isempty(myCBK)==0)&&(isempty(myDBK)==0),
                    if (isempty(myCBK.bidVolume)==0) && (isempty(myCBK.askVolume)==0) &&(isempty(myDBK.bidVolume)==0) && (isempty(myDBK.askVolume)==0),
                        myCBKvalue=Valuate(myCBK.askLimitPrice(1),myCBK.askVolume,myCBK.bidLimitPrice(1),myCBK.bidVolume,0);
                        myDBKvalue=Valuate(myDBK.askLimitPrice(1),myDBK.askVolume,myDBK.bidLimitPrice(1),myDBK.bidVolume,0);
                        
                        % Check mispricing
                        if myDBKvalue>(mySlope)*myCBKvalue+myCrossing+min(myDeltaBuyCBK,myDeltaSellDBK),
                            myAskPrice = myCBK.askLimitPrice(1);
                            myBidPrice = myDBK.bidLimitPrice(1);
                            myAskVolume = min(myCBK.askVolume(1),myCBK.bidVolume(1));
                            myBidVolume = min(myDBK.bidVolume(1),myDBK.askVolume(1));

                            % Update book
                            aBot.DBKDepth.bidVolume(1) = aBot.DBKDepth.bidVolume(1)-myBidVolume;
                            aBot.CBKDepth.askVolume(1) = aBot.CBKDepth.askVolume(1)-myAskVolume;
                            
                            % Now specifically check mispricing of stocks
                            % using the Delta specified for this trade
                            if myDBKvalue>(mySlope)*myCBKvalue+myCrossing+myDeltaBuyCBK,           
                                aBot.TotalCBK(end+1)=myAskVolume*1;
                                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                            end
                            
                            % Again check mispricing using specific delta
                            if myDBKvalue>(mySlope)*myCBKvalue+myCrossing+myDeltaSellDBK,     
                                aBot.TotalDBK(end+1)=myBidVolume*-1;
                                aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                            end

                            % Update layers to make the program check if
                            % another layer trade is also viable
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
                        
                        % Check for mispricing
                        if myDBKvalue<(mySlope)*myCBKvalue+myCrossing-min(myDeltaBuyDBK,myDeltaSellCBK),
                            myAskPrice = myDBK.askLimitPrice(1);
                            myBidPrice = myCBK.bidLimitPrice(1);
                            myAskVolume = min(myDBK.askVolume(1),myDBK.bidVolume(1));
                            myBidVolume = min(myCBK.bidVolume(1),myCBK.askVolume(1));

                            % Update book
                            aBot.CBKDepth.bidVolume(1) = aBot.CBKDepth.bidVolume(1)-myBidVolume;
                            aBot.DBKDepth.askVolume(1) = aBot.DBKDepth.askVolume(1)-myAskVolume;
                            
                            % Again check mispricing using specific delta
                            if myDBKvalue<(mySlope)*myCBKvalue+myCrossing-myDeltaBuyDBK,  
                                aBot.TotalDBK(end+1)=myAskVolume*1;
                                aBot.SendNewOrder(myAskPrice, myAskVolume,  1, {'DBK_EUR'}, {'IMMEDIATE'}, 0);
                            end
                            % Again check mispricing using specific delta
                            if myDBKvalue<(mySlope)*myCBKvalue+myCrossing-myDeltaSellCBK,  
                                aBot.TotalCBK(end+1)=myBidVolume*-1;
                                aBot.SendNewOrder(myBidPrice, myBidVolume, -1, {'CBK_EUR'}, {'IMMEDIATE'}, 0);
                            end

                            % Update layers to make the program check if
                            % another layer trade is also viable
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