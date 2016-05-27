function [volatility] = ImpVol(spotVec,strikeVec,expVec,optionVec,booleVec)
%Given certain vectors this function retunrs the implied volatility

sigmaVec=zeros(length(spotVec),1);
looplength = length(spotVec);
for j=1:looplength,
    sigma=0.2;
    while value-optionVec(j)>0.01,
        [call, put] = blsprice(spotVec(j),strikeVec(j),0,expVec(j),sigma,0)
        if booleVec(j)==1,
            value=call
        else
            value=put
        end
        sigma=sigma+(optionVec(j)-value)/blsvega(spotVec(j),strikeVec(j),0,expVec(j),sigma,0)
    end
    sigmaVec(j)=sigma;    

end
volatility=sigmaVec;
end

