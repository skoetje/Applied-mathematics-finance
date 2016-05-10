function thePrice = callPrice(aS, aMu, aSigma, aE, aT, N)
    % Return:
    %  thePrice : double - the price of an option with given parameters.
    % Parameters:
    %  aS     : double - start value
    %  aMu    : double - drift per year
    %  aSigma : double - volatility per year
    %  aE     : double - the exercise price
    %  aT     : double - time until expiry in years
    %  N      : int - number of times run
    
    %Preambule
  %  tic;
    dt = 1;
    aMu= aMu/252;
    aSigma = aSigma/sqrt(252);
    
    %Monte Carlo (MC) runs: N times
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
    thePrice = mean(Valuevec);
  %  toc

end
