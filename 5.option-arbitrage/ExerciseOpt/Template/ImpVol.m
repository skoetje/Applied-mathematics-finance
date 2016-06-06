function [volatility] = ImpVol(spotVec,strikeVec,timeVec,optionVec,booleVec)
%Given certain vectors this function retunrs the implied volatility
    sigmaVec=zeros(length(spotVec),1);
    looplength = length(spotVec);
    for i=1:looplength,
        sigma=0.2;
        spot=spotVec(i);
        strike=strikeVec(i);
        time=timeVec(i);
        boolean=booleVec(i);
        optionv=optionVec(i);
        value=100;
        
        while value-optionVec(i)>0.01,
            [call, put] = blackscholes(spot,strike,time,0,sigma);
            if boolean==1,
                value=call;
            else
                value=put;
            end
            sigma=sigma+(optionv-value)/vega(spot,strike,time,0,sigma);
        end
        sigmaVec(i)=sigma;    
    end
    volatility=sigmaVec;
end