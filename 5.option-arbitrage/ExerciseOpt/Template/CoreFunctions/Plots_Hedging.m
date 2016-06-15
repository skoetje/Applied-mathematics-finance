

%%
hold on
plot(myTradingRobot.DeltaPositionBef(100:end),'-','Color','black','LineWidth',2)
plot(myTradingRobot.DeltaPositionAft(100:end),'-','Color','red','LineWidth',2)
hold off
xlabel('Time','FontSize',15)
ylabel('Delta position','FontSize',15)
set(gca,'FontSize',13)

%%

hold on
plot(myTradingRobot.StartDeltas(100:end,5),'-','Color','black','LineWidth',2)
plot(myTradingRobot.DeltaConstantG(100:end,5),'-','Color','red','LineWidth',2)
hold off
xlabel('Time','FontSize',15)
ylabel('Delta','FontSize',15)
set(gca,'FontSize',13)