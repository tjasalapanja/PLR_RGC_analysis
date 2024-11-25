% Colors
colorOrange=[240,143,110]./255;
colorLightOrange=[252,225,164]./255;
color_Gray=[0.5,0.5,0.5];
colorViolet=[8,153,126]./255;
colorLightViolet=[158,250,233]./255;
% RMIs
[RMIlow, RMIrandomLow, pdLow]=calculateRMI(responsesLL2(OFFcontrol{2}),flashParams2,1);
[RMIatropineLow, RMIrandomAtropineLow, pdAtropineLow]=calculateRMI(atropineLL2(OFFatropine{2}),flashParams2,1);
[RMIhigh, RMIrandomHigh, pdHigh]=calculateRMI(responsesLL5(OFFcontrol{5}),flashParams2,1);
[RMIatropineHigh, RMIrandomAtropineHigh, pdAtropineHigh]=calculateRMI(atropineLL5(OFFatropine{5}),flashParams2,1);
RMIrandom=[RMIrandomAtropineHigh;RMIrandomHigh;RMIrandomAtropineLow;RMIrandomLow];
% Order
cLow=sort(RMIlow);
listLow=linspace(1,100,length(RMIlow));
cAtropineLow=sort(RMIatropineLow);
listAtropineLow=linspace(1,100,length(RMIatropineLow));
cHigh=sort(RMIhigh);
listHigh=linspace(1,100,length(RMIhigh));
cAtropineHigh=sort(RMIatropineHigh);
listAtropineHigh=linspace(1,100,length(RMIatropineHigh));
cRandom=sort(RMIrandom);
listRandom=linspace(1,100,length(RMIrandom));
% Calculate edges of random dist
pdLow=fitdist(RMIrandom,'Normal');
lowEdge=pdLow.mu-2*pdLow.sigma;
highEdge=pdLow.mu+2*pdLow.sigma;
% Plot
figure('Color','w','Position',[100,100,800,400]);
tiledlayout(1,2,"TileSpacing","compact","Padding","compact")
nexttile
scatter(cLow,listLow',5,'filled','MarkerFaceColor',colorOrange)
hold on
scatter(cAtropineLow,listAtropineLow',5,'filled','MarkerFaceColor',colorLightOrange)
scatter(cRandom,listRandom',5,'filled','MarkerFaceColor',[0.6,0.6,0.6])
xline(highEdge,'--k','LineWidth',0.7)
xline(0,'LineWidth',0.7)
xline(lowEdge,'--k','LineWidth',0.7)
xlim([-0.7,0.7])
xlabel('RMI')
ylabel ('Comulative percentage')
% xticklabels('')
% yticklabels('')

nexttile
scatter(cHigh,listHigh',5,'filled','MarkerFaceColor',colorViolet)
hold on
scatter(cAtropineHigh,listAtropineHigh',5,'filled','MarkerFaceColor',colorLightViolet)
scatter(cRandom,listRandom',5,'filled','MarkerFaceColor',[0.6,0.6,0.6])
xline(highEdge,'--k','LineWidth',0.7)
xline(0,'LineWidth',0.7)
xline(lowEdge,'--k','LineWidth',0.7)
xlim([-0.7,0.7])
% xticklabels('')
% yticklabels('')
xlabel('RMI')
ylabel ('Comulative percentage')