function Volatility=ImpVol(spotVec,strikeVec,timeVec,optionVec,booleVec)

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
            [call, put] = BlackScholes(spot,strike,time,0,sigma);
            if boolean==1,
                value=call;
            else
                value=put;
            end
<<<<<<< HEAD:5.option-arbitrage/ExerciseOpt/Template/ImpVol.m
            sigma=sigma+(optionv-value)/vega(spot,strike,time,0,sigma);
=======
            sigma=sigma+(optionv-value)/Vega(spot,strike,time,0,sigma);
>>>>>>> 1e3b6c48ef3aad26db860c6562a7eab07947b5f4:5.option-arbitrage/ExerciseOpt/Template/HelpFunctions/ImpVol.m
        end
        sigmaVec(i)=sigma;
    end
<<<<<<< HEAD:5.option-arbitrage/ExerciseOpt/Template/ImpVol.m
    volatility=sigmaVec;
=======
    Volatility=sigmaVec;
>>>>>>> 1e3b6c48ef3aad26db860c6562a7eab07947b5f4:5.option-arbitrage/ExerciseOpt/Template/HelpFunctions/ImpVol.m
end