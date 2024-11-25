%% Plot bar plot
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,250,350])
bar(1,mean(correlations2Mouse,'omitnan'),'FaceColor',colorRed)
hold on
errorbar(1,mean(correlations2Mouse,'omitnan'),std(correlations2Mouse,'omitnan'),'Color',[0.2,0.2,0.2])
%scatter(1,correlations2Mouse,'k.')

bar(2,mean(correlations055Mouse,'omitnan'),'FaceColor',colorBlue)
errorbar(2,mean(correlations055Mouse,'omitnan'),std(correlations055Mouse,'omitnan'),'Color',[0.2,0.2,0.2])
%scatter(3,correlations055Mouse,'k.')
xticks([1,2])
xticklabels({'2Hz','0.55Hz'})
xtickangle(30)
ylabel('correlation coefficient')
yline(0,'k')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
box off