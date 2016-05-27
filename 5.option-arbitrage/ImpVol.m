function [volatility] = ImpVol(spotVec,strikeVec,expVec,optionVec,booleVec)
%Given certain vectors this function retunrs the implied volatility

    sigmaVec=zeros(length(spotVec),1);
    looplength = length(spotVec);
    for i=1:looplength,
        sigma=0.2;
        spot=spotVec(i);
        strike=strikeVec(i);
        expiry=expVec(i);
        boolean=booleVec(i);
        optionv=optionVec(i);
        value=100;
        while value-optionVec(i)>0.01,
            [call, put] = blsprice(spot,strike,0,expiry,sigma,0);
            if boolean==1,
                value=call;
            else
                value=put;
            end
            sigma=sigma+(optionv-value)/blsvega(spot,strike,0,expiry,sigma,0);
        end
        sigmaVec(i)=sigma;    
    end
    volatility=sigmaVec;
end