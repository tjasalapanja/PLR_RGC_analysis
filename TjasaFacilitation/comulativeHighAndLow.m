colorOrange=[240,143,110]./255;
colorViolet=[110,0,95]./250;
% colorRed=[255,31,91]./255;
% colorBlue=[0,154,222]./255;
[RMIlow, RMIrandomLow, pdLow]=calculateRMI(responsesLL2(OFFcontrol{2}),flashParams2,1);
[RMIhigh, RMIrandomHigh, pdHigh]=calculateRMI(responsesLL5(OFFcontrol{5}),flashParams2,1);
RMIrandom=[RMIrandomHigh;RMIrandomLow];
cLow=sort(RMIlow);
listLow=linspace(1,100,length(RMIlow));
cHigh=sort(RMIhigh);
listHigh=linspace(1,100,length(RMIhigh));
cRandom=sort(RMIrandom);
listRandom=linspace(1,100,length(RMIrandom));
pd=fitdist(RMIrandom,'Normal');
lowEdge=pd.mu-2*pd.sigma;
highEdge=pd.mu+2*pd.sigma;
figure('Color','w','Position',[100,100,300,300]);
scatter(cLow,listLow',5,'filled','MarkerFaceColor',colorOrange)
hold on
scatter(cHigh,listHigh',5,'filled','MarkerFaceColor',colorViolet)
scatter(cRandom,listRandom',5,'filled','MarkerFaceColor',[0.6,0.6,0.6])
xline(highEdge,'--k')
xline(0)
xline(lowEdge,'--k')
xlim([-0.7,0.7])
xlabel('RMI')
ylabel('Comulative percentage')
% legend({'Low Con.','High Con.','Shuffled'},'Location','southoutside','NumColumns',3)
% legend box off