% pca055=lowContrastPCA(allROI055);
% pca2=lowContrastPCA(allROI2);
cmap=[255,198,30;175,88,186;0,205,108]./255;
RQI055=RQIcalculation(allROI055)%(pca055.clsKmeans==1));
RQI2=RQIcalculation(allROI2)%(pca2.clsKmeans==1));
i.a=RQI055(:,3);
i.b=RQI2(:,3);
c.a=RQI055(:,2);
c.b=RQI2(:,2);
xnames={'0.25Hz','2Hz'};
figure('Color','w','Position',[100,100,500,450])
tiledlayout(1,2,"TileSpacing","tight","Padding","compact")
nexttile
violinplot(i,xnames,'ViolinColor',cmap(3,:))
title('Ipsi')
yline(0.3,'k--')
xlim([0,3])
ylim([0.1,1])
ylabel('RQI')
xticklabels({'0.55Hz','2Hz'})
yticks([0.1,0.3,0.5,0.7,0.9])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile
title('Contra')
violinplot(c,xnames,'ViolinColor',cmap(2,:))
xlim([0,3])
ylim([0.1,1])
yticks([])
xticklabels({'0.55Hz','2Hz'})
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';