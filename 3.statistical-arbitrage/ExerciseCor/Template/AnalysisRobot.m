classdef AnalysisRobot < AutoTrader
    properties
        CBKDepth
        DBKDepth
        
        % Best bids/offer prices and volumes of both stocks are recorded to
        % use these values in the valuation functions later
        BestBidsCBK
        BestBidsDBK
        BestOffersCBK
        BestOffersDBK
        BestVolBidsCBK
        BestVolOffersCBK
        BestVolBidsDBK
        BestVolOffersDBK
    end

    methods
        function HandleDepthUpdate(aBot, ~, aDepth)
            switch aDepth.ISIN
                case 'CBK_EUR'; aBot.CBKDepth = aDepth;
                case 'DBK_EUR'; aBot.DBKDepth = aDepth;
            end
            
            % Recording of best bid and offer volumes and prices
            myCBK=aBot.CBKDepth;
            myDBK=aBot.DBKDepth;
            myCBKbid=NaN;
            myDBKbid=NaN;
            myCBKoffer=NaN;
            myDBKoffer=NaN;
            myCBKbidvol=NaN;
            myDBKbidvol=NaN;
            myCBKoffervol=NaN;
            myDBKoffervol=NaN;
            if (isempty(myCBK)==0),
                if (isempty(myCBK.bidLimitPrice)==0),
                    myCBKbid=myCBK.bidLimitPrice(1);
                    myCBKbidvol=myCBK.bidVolume(1);
                end
                if (isempty(myCBK.askLimitPrice)==0),
                    myCBKoffer=myCBK.askLimitPrice(1);
                    myCBKoffervol=myCBK.askVolume(1);
                end
            end
            if (isempty(myDBK)==0),
                if (isempty(myDBK.bidLimitPrice)==0),
                    myDBKbid=myDBK.bidLimitPrice(1);
                    myDBKbidvol=myDBK.bidVolume(1);
                end
                if (isempty(myDBK.askLimitPrice)==0),
                    myDBKoffer=myDBK.askLimitPrice(1);
                    myDBKoffervol=myDBK.askVolume(1);
                end
            end
            aBot.BestBidsCBK(end+1)=myCBKbid;
            aBot.BestBidsDBK(end+1)=myDBKbid;
            aBot.BestOffersCBK(end+1)=myCBKoffer;
            aBot.BestOffersDBK(end+1)=myDBKoffer;
            aBot.BestVolBidsCBK(end+1)=myCBKbidvol;
            aBot.BestVolBidsDBK(end+1)=myDBKbidvol;
            aBot.BestVolOffersCBK(end+1)=myCBKoffervol;
            aBot.BestVolOffersDBK(end+1)=myDBKoffervol;
        end
        
        function PlotMarket(aBot)
            % Get best bids and offers
            myTime=1:length(aBot.BestBidsCBK);
            
            % Valuate stocks
            myDBKvalue=Valuate(aBot.BestOffersDBK,aBot.BestVolOffersDBK,aBot.BestBidsDBK,aBot.BestVolBidsDBK,0);
            myCBKvalue=Valuate(aBot.BestOffersCBK,aBot.BestVolOffersCBK,aBot.BestBidsCBK,aBot.BestVolBidsCBK,0);
            myDBKvalue2=myDBKvalue(~isnan(myDBKvalue));
            myCBKvalue2=myCBKvalue(~isnan(myCBKvalue));
            
            % Calculate correlation coefficient
            myCorrelation=corrcoef(myDBKvalue,myCBKvalue,'rows','complete');
            myCorrelation=myCorrelation(2,1);
          
            % Linear relation
            myConfidence=0.05;
            myNonNanValues = isnan(myCBKvalue) | isnan(myDBKvalue);
            myParameters = polyfit(myCBKvalue(~myNonNanValues),myDBKvalue(~myNonNanValues),1);
            [a,b] = polyfit(myCBKvalue(~myNonNanValues),myDBKvalue(~myNonNanValues),1);
            [myRegression0,myDelta0]=polyconf(a,myCBKvalue,b,'alpha',myConfidence);
            myRegressionfit = polyval(a,myCBKvalue);
            
            % Calculation of the actual regression (for the used feed)
            myRegression = myParameters(1)*myCBKvalue+myParameters(2);
            
            % Plots of various sorts with various quantities
            subplot(2,2,1);
            hold on
            yyaxis left
            plot(myTime(~isnan(myDBKvalue)),myDBKvalue2,'-')
            yyaxis right
            plot(myTime(~isnan(myCBKvalue)),myCBKvalue2,'-')
            text(100,(max(myCBKvalue2)-min(myCBKvalue2))*0.95+min(myCBKvalue2),strcat('r_{Valuations} = ',num2str(myCorrelation)))
            title('Valuations')
            hold off
            
            subplot(2,2,2);
            hold on
            yyaxis left
            plot(myTime(~isnan(myRegression)),myRegression(~isnan(myRegression)),'-','Color','blue')
            plot(myTime(~isnan(myDBKvalue)),myDBKvalue(~isnan(myDBKvalue)),'-')
            text(100,(max(myDBKvalue)-min(myDBKvalue))*0.95+min(myDBKvalue),strcat('DBK = ',num2str(myParameters(1)),'x + ',num2str(myParameters(2))))
            title('Regression')
            hold off
            
            subplot(2,2,3);
            hold on
            yyaxis left
            myHighRegression=myRegression0+myDelta0;
            myLowRegression=myRegression0-myDelta0;
            plot(myTime(~isnan(myHighRegression)),myHighRegression(~isnan(myHighRegression)),'b-');
            plot(myTime(~isnan(myLowRegression)),myLowRegression(~isnan(myLowRegression)),'b-')
            plot(myTime(~isnan(myRegressionfit)),myRegressionfit(~isnan(myRegressionfit)),'b-')
            plot(myTime(~isnan(myDBKvalue)),myDBKvalue(~isnan(myDBKvalue)),'-')
            text(100,(max(myDBKvalue)-min(myDBKvalue))*0.75+min(myDBKvalue),strcat('Delta =',num2str(nanmean(myDelta0))))
            title(strcat('Regression and  ',num2str(100*(1.0-myConfidence)),'% Confidence intervals'))
            hold off
            
            subplot(2,2,4);
            hold on
            yyaxis left
            plot(myTime(~isnan(myRegression)),myRegression(~isnan(myRegression)),'-','Color','black')
            title('Regression Difference')
            hold off
        end
    end
end
