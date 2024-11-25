%% Plot commulative early/late RMI
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,400,350])
tiledlayout(2,2,'TileSpacing','compact','Padding','compact')
steps2=linspace(1,100,length(allROI2));
steps055=linspace(1,100,length(allROI055));
nexttile
plot(sort(rmiEarly2),steps2,'Color',colorBlue,'LineWidth',1.5)
hold on
plot(sort(randomEarly2),steps2,'Color',[0.4,0.4,0.4],'LineWidth',1.5)
xline(0,'k--')
xlim([-1,1])
xticks([])
yticks([25,50,75])
box off
title('Low contrast')
ylabel('2 Hz')
nexttile
plot(sort(rmiLate2),steps2,'Color',colorRed,'LineWidth',1.5)
hold on
plot(sort(randomLate2),steps2,'Color',[0.4,0.4,0.4],'LineWidth',1.5)
xline(0,'k--')
yticks([])
xticks([])
xlim([-1,1])
box off
title('High contrast')
nexttile
plot(sort(rmiEarly055),steps055,'Color',colorBlue,'LineWidth',1.5)
hold on
plot(sort(randomEarly055),steps055,'Color',[0.4,0.4,0.4],'LineWidth',1.5)
xline(0,'k--')
yticks([25,50,75])
xlim([-1,1])
box off
ylabel('0.55 Hz')
nexttile
plot(sort(rmiLate055),steps055,'Color',colorRed,'LineWidth',1.5)
hold on
plot(sort(randomLate055),steps055,'Color',[0.4,0.4,0.4],'LineWidth',1.5)
xline(0,'k--')
xlim([-1,1])
yticks([])
box off
