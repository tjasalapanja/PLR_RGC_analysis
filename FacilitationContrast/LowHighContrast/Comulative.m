colorOrange=[240,143,110]./255;
colorViolet=[110,0,95]./255;
[RMIlow, RMIrandomLow, pdLow]=calculateRMI(responsesLL2(OFFcontrol{2}),flashParams2,1);
[RMIhigh, RMIrandomHigh, pdHigh]=calculateRMI(responsesLL5(OFFcontrol{5}),flashParams2,1);
RMIrandom=[RMIrandomHigh;RMIrandomLow];
cLow=sort(RMIlow);
listLow=linspace(1,100,length(RMIlow));
cAtropine=sort(RMIhigh);
listAtropine=linspace(1,100,length(RMIhigh));
cRandom=sort(RMIrandom);
listRandom=linspace(1,100,length(RMIrandom));
pdLow=fitdist(RMIrandom,'Normal');
lowEdge=pdLow.mu-2*pdLow.sigma;
highEdge=pdLow.mu+2*pdLow.sigma;
figure('Color','w','Position',[100,100,300,250]);
scatter(cLow,listLow',5,'filled','MarkerFaceColor',colorOrange)
hold on
scatter(cAtropine,listAtropine',5,'filled','MarkerFaceColor',colorViolet)
scatter(cRandom,listRandom',5,'filled','MarkerFaceColor',[0.6,0.6,0.6])
xline(highEdge,'--k')
xline(0)
xline(lowEdge,'--k')
xlim([-0.7,0.7])
xlabel('RMI')
ylabel('Cumulative percentage')
% title('Low contrast')
% legend({'Low Con.','High Con.','Shuffled'},'Location','southoutside','NumColumns',3)
% legend box off