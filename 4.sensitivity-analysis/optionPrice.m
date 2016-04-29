function thePrice = optionPrice(aS, aMu, aSigma, aE, aT)
    % Return:
    %  thePrice : double - the price of an option with given parameters.
    % Parameters:
    %  aS     : double - start value
    %  aMu    : double - drift per year
    %  aSigma : double - volatility per year
    %  aE     : double - the exercise price
    %  aT     : double - time until expiry in years

    %Preambule
    tic;
    dt = 1;
    aMu= aMu/252;
    aSigma = aSigma/sqrt(252);
    
    %Monte Carlo (MC) runs: N times
    N=10000;
    Valuevec=[];
    for MC=1:N,
        
        %Below is one simulation (inside the MC loop), where aSMC is aS
        %within the loop. The variable value represents the expected profit
        %of the option for exercise price aE compared to expected asset
        %price aSMC. 
        aSMC=aS;
        for y=1:(aT/dt),
            dX = normrnd(0,dt);
            dS = aMu*dt*aSMC+aSMC*aSigma*dX;
            aSMC = aSMC+dS;
        end
        value = aSMC-aE;
        
        %The value is 0 if the asset price is lower than the exercise price.
        if value<0,
            value=0;
        end
        
        %Valuevec is the vector with all the option values throughout the
        %complete MC series.
        Valuevec=[Valuevec value];
    end
    
    %Some code for the histogram
    simvec=[1:N];
    disp(Valuevec);
    histfit(Valuevec,100)
    ylim([0,N/20])
    xlim([0,4])
    xlabel('Option value (�)','FontSize', 15)
    ylabel('Frequency','FontSize', 15)
    thePrice = mean(Valuevec);
    set(gca,'FontSize',13)
    toc
end
