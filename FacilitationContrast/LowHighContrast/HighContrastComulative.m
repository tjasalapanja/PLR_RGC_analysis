colorViolet=[110,0,95]./255;
colorLightViolet=[240,214,255]./255;
[RMIhigh, RMIrandomHigh, pdHigh]=calculateRMI(responsesLL5(OFFcontrol{5}),flashParams2,1);
[RMIatropine, RMIrandomAtropine, pdAtropine]=calculateRMI(atropineLL5(OFFatropine{5}),flashParams2,1);
RMIrandom=[RMIrandomAtropine;RMIrandomHigh];
cLow=sort(RMIhigh);
listLow=linspace(1,100,length(RMIhigh));
cAtropine=sort(RMIatropine);
listAtropine=linspace(1,100,length(RMIatropine));
cRandom=sort(RMIrandom);
listRandom=linspace(1,100,length(RMIrandom));
pdHigh=fitdist(RMIrandom,'Normal');
lowEdge=pdHigh.mu-2*pdHigh.sigma;
highEdge=pdHigh.mu+2*pdHigh.sigma;
figure('Color','w','Position',[100,100,300,250]);
scatter(cLow,listLow',5,'filled','MarkerFaceColor',colorViolet)
hold on
scatter(cAtropine,listAtropine',5,'filled','MarkerFaceColor',colorLightViolet)
scatter(cRandom,listRandom',5,'filled','MarkerFaceColor',[0.6,0.6,0.6])
xline(highEdge,'--k')
xline(0)
xline(lowEdge,'--k')
xlim([-0.7,0.7])
xlabel('RMI')
ylabel('Cumulative percentage')
title('High contrast')
% legend({'Low Con.','High Con.','Shuffled'},'Location','southoutside','NumColumns',3)
% legend box off