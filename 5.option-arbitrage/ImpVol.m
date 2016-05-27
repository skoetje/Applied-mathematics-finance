function [volatility] = ImpVol(spotVec,strikeVec,expVec,optionVec,booleVec)
%Given certain vectors this function retunrs the implied volatility

sigmaVec=zeros(length(spotVec),1);
looplength = length(spotVec);
for i=1:looplength,
    sigma=0.2;
    while value-optionVec(i)>0.01,
        [call, put] = blsprice(spotVec(i),strikeVec(i),0,expVec(i),sigma,0)
        if booleVec(i)==1,
            value=call
        else
            value=put
        end
        sigma=sigma+(optionVec(i)-value)/blsvega(spotVec(i),strikeVec(i),0,expVec(i),sigma,0)
    end
    sigmaVec(i)=sigma;    

end
volatility=sigmaVec;
end

