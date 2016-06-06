function Arbitrage(aBot)
myTime=1000;
%aBot.Time(end)?
mySpot=aBot.StockDepth.askLimitPrice(1);
myStrikeVec=[8,9,9.50,9.75,10,10.25,10.50,11,12,14];
myImpVolVec=zeros(10,2);
myCallOptionVec=[aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1),aBot.Call1000Depth.askLimitPrice(1)];
myPutOptionVec=[aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1),aBot.Put1000Depth.askLimitPrice(1)];
myISINCallVec=['ING20160906CALL800','ING20160906CALL900','ING20160906CALL950','ING20160906CALL975','ING20160906CALL1000','ING20160906CALL1025','ING20160906CALL1050','ING20160906CALL1100','ING20160906CALL1200','ING20160906CALL1400'];
myISINPutVec=['ING20160906PUT800','ING20160906PUT900','ING20160906PUT950','ING20160906PUT975','ING20160906PUT1000','ING20160906PUT1025','ING20160906PUT1050','ING20160906PUT1100','ING20160906PUT1200','ING20160906PUT1400'];
myISINVec=[myISINCallVec;myISINPutVec];
myOptionVec=[myCallOptionVec;myPutOptionVec];

for i=1:10,
    myStrike=myStrikeVec(i);
    myCallOption=myCallOptionVec(i);
    myPutOption=myPutOptionVec(i);
    myImpVolVec(i,1)=ImpVol(mySpot,myStrike,169999-myTime,myCallOption,1);
    myImpVolVec(i,2)=ImpVol(mySpot,myStrike,169999-myTime,myPutOption,0);
end

%Now check for anomalies
for j=1:2,
    for i=5:5,
        if myImpVolVec(i,j)<(mean(myImpVolVec(:,j))-std(myImpVolVec(:,j))),
            aBot.SendNewOrder(myOptionVecP(i,j), myOptionVecV(i,j),  1, {myISINVec(i,j)}, {'IMMEDIATE'}, 0);
        end
    end
end
    

end