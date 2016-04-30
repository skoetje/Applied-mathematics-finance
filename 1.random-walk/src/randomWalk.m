function theRandomWalk = randomWalk(aS, aMu, aSigma, aT)
    %Preambule.
    %vecaS is a list that gathers aS per timestep
    %vectime is a time vector, for plotting purposes
    tic;
    aMu= aMu/252;
    dt = 1;
    aSigma = aSigma/sqrt(252);
    vecaS = [aS];
    vectime = [0];
    time=0;
    
    %The time loop that solves the differential
    %equation (2.1 from Willmot) numerically
    for y=1:(aT/dt),
        dX = normrnd(0,dt);
        dS = aMu*dt*aS+aS*aSigma*dX;
        vecaS=[vecaS aS+dS];
        aS = aS+dS;
        time = time+dt;
        vectime=[vectime time];
    end
    
    %The requested list
    theRandomWalk = [vecaS];
    
    %To create the figures
    plot(vectime,vecaS,'LineWidth',2.5,'Color','red')
    line([0,82],[11,11*exp(aMu*85)],'LineWidth',1.5,'LineStyle','--','Color','blue')
    line([0,82],[12,12],'LineWidth',1.5,'LineStyle','--','Color','black')
    xlabel('Time (days)','FontSize', 15)
    ylabel('Asset price (€)','FontSize', 15)
    xlim([0,82])
    ylim([8.5,13.5])
    set(gca,'FontSize',13)
    toc
end
