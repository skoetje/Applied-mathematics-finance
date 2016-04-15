classdef AnalysisRobot < AutoTrader
    properties
        CBKDepth
        DBKDepth
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
                    myCBKbidvol=sum(myCBK.bidVolume);
                    myCBKbidvol=myCBK.bidVolume(1);
                end
                if (isempty(myCBK.askLimitPrice)==0),
                    myCBKoffer=myCBK.askLimitPrice(1);
                    myCBKoffervol=sum(myCBK.askVolume);
                    myCBKoffervol=myCBK.askVolume(1);
                end
            end
            if (isempty(myDBK)==0),
                if (isempty(myDBK.bidLimitPrice)==0),
                    myDBKbid=myDBK.bidLimitPrice(1);
                    myDBKbidvol=sum(myDBK.bidVolume);
                    myDBKbidvol=myDBK.bidVolume(1);
                end
                if (isempty(myDBK.askLimitPrice)==0),
                    myDBKoffer=myDBK.askLimitPrice(1);
                    myDBKoffervol=sum(myDBK.askVolume);
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
            %Get best bids and offers
            myTime=[1:length(aBot.BestBidsCBK)];
            myBidCBK = aBot.BestBidsCBK(~isnan(aBot.BestBidsCBK));
            myAskCBK = aBot.BestOffersCBK(~isnan(aBot.BestOffersCBK));
            myBidDBK = aBot.BestBidsDBK(~isnan(aBot.BestBidsDBK));
            myAskDBK = aBot.BestOffersDBK(~isnan(aBot.BestOffersDBK));
            
            %Valuate stocks
            myDBKvalue=Valuate(aBot.BestOffersDBK,aBot.BestVolOffersDBK,aBot.BestBidsDBK,aBot.BestVolBidsDBK,0);
            myCBKvalue=Valuate(aBot.BestOffersCBK,aBot.BestVolOffersCBK,aBot.BestBidsCBK,aBot.BestVolBidsCBK,0);
            myDBKvalue2=myDBKvalue(~isnan(myDBKvalue));
            myCBKvalue2=myCBKvalue(~isnan(myCBKvalue));
            
            %Calculate correlation coefficient
            myCorrelation=corrcoef(myDBKvalue,myCBKvalue,'rows','complete');
            myCorrelation=myCorrelation(2,1);
                        
            %Principal component Analysis
            [eigenvec, eigenval]=eig(corrcoef(myDBKvalue,myCBKvalue,'rows','complete'));
            myPC1=eigenval(1,1)/(eigenval(1,1)+eigenval(2,2));
            myPC2=eigenval(2,2)/(eigenval(1,1)+eigenval(2,2));
            myPC1a=eigenvec(1,1);
            myPC1b=eigenvec(1,2);
            myPC2a=eigenvec(2,1);
            myPC2b=eigenvec(2,2);
            
            myPCAVALUE=myPC1a*myDBKvalue+myPC1b*myCBKvalue;
            myPCAVALUE2=myPC2a*myDBKvalue+myPC2b*myCBKvalue;
            myTradePredictor=-myPC1b*myCBKvalue/myPC1a+nanmean(myPCAVALUE)/myPC1a;
            myTradePredictor2=myTradePredictor(~isnan(myTradePredictor));
            myDifference=myDBKvalue-myTradePredictor;
            myDifference2=myDifference(~isnan(myDifference));
            %length(myTradePredictor)
            %myPC1b/myPC1a
            
            %Check for divergence or convergence
            
            %Linear relation
            alpha=0.05;
            idx = isnan(myCBKvalue) | isnan(myDBKvalue);
            myParameters = polyfit(myCBKvalue(~idx),myDBKvalue(~idx),1);
            [a,b] = polyfit(myCBKvalue(~idx),myDBKvalue(~idx),1);
            Regr= polyfit(myCBKvalue(~idx),myDBKvalue(~idx),1);
            [Y,DELTA]=polyconf(a,myCBKvalue,b,'alpha',alpha);
            yfit = polyval(a,myCBKvalue);
            %hfit = polyval(p,xfit);
            
            myRegression = myParameters(1)*myCBKvalue+myParameters(2);
            myRegrError = sqrt(diag(inv(b.R)*inv(b.R'))./b.normr.^2./b.df);
            myRegressionUp = (myParameters(1)+myRegrError(1))*myCBKvalue+myParameters(2)+myRegrError(2);
            myRegressionDown = (myParameters(1)-myRegrError(1))*myCBKvalue+myParameters(2)-myRegrError(2);
            
            myRegrDifference = myDBKvalue(~idx)-myRegression(~idx);
            myRegrDifferenceUp = myDBKvalue(~idx)-myRegressionUp(~idx);
            myRegrDifferenceDown = myDBKvalue(~idx)-myRegressionDown(~idx);
            
            %Make plotss
            %subplot(2,2,1);
%             hold on
%             yyaxis left
%             plot(myTime(~isnan(aBot.BestBidsCBK)),myBidCBK,'-')
%             plot(myTime(~isnan(aBot.BestOffersCBK)),myAskCBK,'-','Color','blue')
%             ylabel('Best offer and bid prices')
%             text(100,(max(myAskCBK)-min(myBidCBK))*0.95+min(myBidCBK),strcat('r_{Valuations} = ',num2str(myCorrelation)))
%             text(100,(max(myAskCBK)-min(myBidCBK))*0.85+min(myBidCBK),strcat('PC1 = ',num2str(myPC1)))
%             text(100,(max(myAskCBK)-min(myBidCBK))*0.75+min(myBidCBK),strcat('PC1 = ',num2str(myPC1a),'*DBKvalue +',num2str(myPC1b),'*DBKvalue'))
%             text(100,(max(myAskCBK)-min(myBidCBK))*0.65+min(myBidCBK),strcat('PC2 = ',num2str(myPC2)))
%             text(100,(max(myAskCBK)-min(myBidCBK))*0.55+min(myBidCBK),strcat('PC2 = ',num2str(myPC2a),'*CBKvalue +',num2str(myPC2b),'*CBKvalue'))
%             yyaxis right
%             plot(myTime(~isnan(myCBKvalue)),myCBKvalue2,'-','LineWidth',2)
%             ylabel('Valuation')
%             xlabel('Time')
%             title('CBK')
%             hold off
            
            %subplot(2,2,2);
%             hold on
%             yyaxis left
%             plot(myTime(~isnan(aBot.BestBidsDBK)),myBidDBK,'-')
%             plot(myTime(~isnan(aBot.BestOffersDBK)),myAskDBK,'-','Color','blue')
%             ylabel('Best offer and bid prices')
%             %text(100,15.75,strcat('r_{CBKDBK} = ',num2str(myCorrelation)))
%             yyaxis right
%             plot(myTime(~isnan(myDBKvalue)),myDBKvalue2,'-','LineWidth',2)
%             ylabel('Valuation')
%             xlabel('Time')
%             title('DBK')
%             hold off
            
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
            text(100,(max(myDBKvalue)-min(myDBKvalue))*0.85+min(myDBKvalue),strcat('Unc1 = ',num2str(myRegrError(1))))
            text(100,(max(myDBKvalue)-min(myDBKvalue))*0.75+min(myDBKvalue),strcat('Unc2 = ',num2str(myRegrError(2))))
            title('Regression')
            hold off
            
            subplot(2,2,3);
            hold on
            yyaxis left
            %plot(myTime(~isnan(myRegrDifference)),myRegrDifference(~isnan(myRegrDifference)),'-','Color','black')
            %plot(myTime(~isnan(myRegrDifferenceUp)),myRegrDifferenceUp(~isnan(myRegrDifferenceUp)),'-','Color','blue')
            %plot(myTime(~isnan(myRegrDifferenceDown)),myRegrDifferenceDown(~isnan(myRegrDifferenceDown)),'-','Color','red')
            y1=Y+DELTA;
            y2=Y-DELTA;
            plot(myTime(~isnan(y1)),y1(~isnan(y1)),'b-');
            plot(myTime(~isnan(y2)),y2(~isnan(y2)),'b-')
            plot(myTime(~isnan(yfit)),yfit(~isnan(yfit)),'b-')
            plot(myTime(~isnan(myDBKvalue)),myDBKvalue(~isnan(myDBKvalue)),'-')
            text(100,(max(myDBKvalue)-min(myDBKvalue))*0.75+min(myDBKvalue),strcat('Delta =',num2str(nanmean(DELTA))))
            title(strcat('Regression and  ',num2str(100*(1.0-alpha)),'% Confidence intervals'))
            hold off
            
            subplot(2,2,4);
            hold on
            yyaxis left
            plot(myTime(~isnan(myRegressionUp)),myRegressionUp(~isnan(myRegressionUp)),'-','Color','blue')
            plot(myTime(~isnan(myRegressionDown)),myRegressionDown(~isnan(myRegressionDown)),'-','Color','red')
            plot(myTime(~isnan(myRegression)),myRegression(~isnan(myRegression)),'-','Color','black')
            text(100,(max(myRegressionUp)-min(myRegressionUp))*0.95+min(myRegressionUp),strcat('r_{Valuations} = ',num2str(myCorrelation)))
            title('Regression Difference')
            hold off
            
            
        end
    end
end