% Colors
colorRandom=[74,35,119]./255;
colorNormal=[245,95,116]./255;
colorAtropine=[140,197,227]./255;
colorCarbachol=[13,125,135]./255;
% RMIs
[RMIlow, RMIrandomLow, pdLow]=calculateRMI(OFF_LL2,flashParams2,1);
[RMIatropineLow, RMIrandomAtropineLow, pdAtropineLow]=calculateRMI(OFFatropineLow,flashParams2,1);
[RMIcarbacholLow, RMIrandomCarbacholLow, pdCarbacholLow]=calculateRMI(OFFcarbacholLow,flashParams2,1);
[RMIhigh, RMIrandomHigh, pdHigh]=calculateRMI(OFF_LL5,flashParams2,1);
[RMIatropineHigh, RMIrandomAtropineHigh, pdAtropineHigh]=calculateRMI(OFFatropineHigh,flashParams2,1);
[RMIcarbacholHigh, RMIrandomCarbacholHigh, pdCarbacholHigh]=calculateRMI(OFFcarbacholHigh,flashParams2,1);
RMIrandom=[RMIrandomAtropineHigh;RMIrandomHigh;RMIrandomAtropineLow;RMIrandomLow;RMIrandomCarbacholLow;RMIrandomCarbacholHigh];
% Order
cLow=sort(RMIlow);
listLow=linspace(1,100,length(RMIlow));
cAtropineLow=sort(RMIatropineLow);
listAtropineLow=linspace(1,100,length(RMIatropineLow));
cCarbacholLow=sort(RMIcarbacholLow);
listCarbacholLow=linspace(1,100,length(RMIcarbacholLow));
cHigh=sort(RMIhigh);
listHigh=linspace(1,100,length(RMIhigh));
cAtropineHigh=sort(RMIatropineHigh);
listAtropineHigh=linspace(1,100,length(RMIatropineHigh));
cCarbacholHigh=sort(RMIcarbacholHigh);
listCarbacholHigh=linspace(1,100,length(RMIcarbacholHigh));
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
scatter(cLow,listLow',15,'filled','MarkerFaceColor',colorNormal)
hold on
scatter(cAtropineLow,listAtropineLow',15,'filled','MarkerFaceColor',colorAtropine)
scatter(cCarbacholLow,listCarbacholLow',15,'filled','MarkerFaceColor',colorCarbachol)
scatter(cRandom,listRandom',15,'filled','MarkerFaceColor',colorRandom)
xline(-0.17,'--k','LineWidth',0.7)
xline(0,'LineWidth',0.7)
xline(0.17,'--k','LineWidth',0.7)
xlim([-0.7,0.7])
xlabel('RMI')
ylabel ('Comulative percentage')
% xticklabels('')
% yticklabels('')

nexttile
scatter(cHigh,listHigh',15,'filled','MarkerFaceColor',colorNormal)
hold on
scatter(cAtropineHigh,listAtropineHigh',15,'filled','MarkerFaceColor',colorAtropine)
scatter(cCarbacholHigh,listCarbacholHigh',15,'filled','MarkerFaceColor',colorCarbachol)
scatter(cRandom,listRandom',15,'filled','MarkerFaceColor',colorRandom)
xline(0.17,'--k','LineWidth',0.7)
xline(0,'LineWidth',0.7)
xline(-0.17,'--k','LineWidth',0.7)
xlim([-0.7,0.7])
% xticklabels('')
% yticklabels('')
xlabel('RMI')
ylabel ('Comulative percentage')