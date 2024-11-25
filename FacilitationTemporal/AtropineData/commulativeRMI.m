%% Colors
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
colorGray=[0.6,0.6,0.6];
%% CalculateRMI
cutPart=2;
[RMI055,sorted055]=calculateRMI(allROI055,slowParams055);
[RMI2,sorted2]=calculateRMI(allROI2,slowParams2);
[RMIAtr,sortedAtr]=calculateRMI(atropine055,slowParams055);
x055=linspace(1,100,length(sorted055));
x2=linspace(1,100,length(sorted2));
xAtr=linspace(1,100,length(sortedAtr));
% Random
% [RMIrandom, edge]=findRandomRMI(allROI055,[1:480],3);
% sortedRandom=sort(RMIrandom,'ascend');
%% Plot
figure('Color','w','Position',[100,100,300,280])
plot(sorted055,x055,'Color',colorBlue,'LineWidth',1.5)
hold on
plot(sorted2,x2,'Color',colorRed,'LineWidth',1.5)
plot(sortedAtr,xAtr,'Color',colorGray,'LineWidth',1.5)
% plot(sortedRandom,x055,'Color',[0.2,0.2,0.2],'LineWidth',1,'LineStyle',':')
xline(0,'--k')
xlabel('RMI')
yticks([50,100])
ylabel('Comulative Percentage')
legend({'0.55Hz','2Hz','0.55Hz Atr'},'Location','southoutside','NumColumns',3)
legend box off
box off
