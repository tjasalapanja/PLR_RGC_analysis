%% Get patterns for human and mouse data
% Human data is recorded at 20 fps and first 100 frames are without
% stimulus. The pattern is -sin.
% Mouse data is recorded at 15.5 fps. The pattern is sin 
pattern055Human=getPattern(400,1);
pattern055Mouse=getPattern(325,0);
pattern2Human=getPattern(183,1);
pattern2Mouse=getPattern(93,0);
%% All example correlations
correlations055Mouse=zeros(30,1);
correlations2Mouse=zeros(17,1);
correlations055Human=zeros(14,1);
correlations2Human=zeros(15,1);
for i=1:30
    correlations055Mouse(i)=corr(pattern055Mouse(:),pupil055.all_pupil(326:2*325,i,1),'type','Spearman');
end
for i=1:17
    correlations2Mouse(i)=corr(pattern2Mouse(:),pupil2.all_pupil(94:2*93,i,1),'type','Spearman');
end
for i=1:14
    correlations055Human(i)=corr(pattern055Human(:),allPupil055Human.allData(i,101:end)','type','Spearman');
end
for i=1:15
    correlations2Human(i)=corr(pattern2Human(46:end)',allPupil2Human.allData(i,46:end)','type','Spearman');
end
%% Mouse by mouse mean zscore correlations
corr055MouseMean=zeros(5,1);
corr2MouseMean=zeros(3,1);
corr055HumanMean=zeros(3,1);
corr2HumanMean=zeros(3,1);
for i=1:5
    corr055MouseMean(i)=corr(pattern055Mouse(:),pupil055.mean_zscore(i,326:2*325,1)','type','Spearman');
end
for i=1:3
    corr2MouseMean(i)=corr(pattern2Mouse(:),pupil2.mean_zscore(i,94:2*93,1)','type','Spearman');
end
for i=1:3
    corr055HumanMean(i)=corr(pattern055Human(:),allPupil055Human.zscoreMeans(i,101:end)','type','Spearman');
end
for i=1:3
    corr2HumanMean(i)=corr(pattern2Human(:),allPupil2Human.zscoreMeans(i,:)','type','Spearman');
end
%% Plot bar plot
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,250,350])
bar(1,mean(correlations2Mouse,'omitnan'),'FaceColor',colorRed)
hold on
errorbar(1,mean(correlations2Mouse,'omitnan'),std(correlations2Mouse,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(1,correlations2Mouse,'k.')

bar(2,mean(correlations2Human,'omitnan'),'FaceColor',colorRed)
errorbar(2,mean(correlations2Human,'omitnan'),std(correlations2Human,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(2,correlations2Human,'k.')

bar(3,mean(correlations055Mouse,'omitnan'),'FaceColor',colorBlue)
errorbar(3,mean(correlations055Mouse,'omitnan'),std(correlations055Mouse,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(3,correlations055Mouse,'k.')

bar(4,mean(correlations055Human,'omitnan'),'FaceColor',colorBlue)
errorbar(4,mean(correlations055Human,'omitnan'),std(correlations055Human,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(4,correlations055Human,'k.')
xticks([1,2,3,4])
xticklabels({'mouse', 'human','mouse','human'})
xtickangle(30)
ylabel('correlation coefficient')
legend({'2 Hz','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','0.55 Hz'},'Location','southoutside','NumColumns',2)
legend box off
box off
%% Plot bar plot
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,500,700])
bar(1,mean(corr2MouseMean,'omitnan'),'FaceColor',colorRed)
hold on
errorbar(1,mean(corr2MouseMean,'omitnan'),std(corr2MouseMean,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(1,corr2MouseMean,'k.')

bar(2,mean(corr2HumanMean,'omitnan'),'FaceColor',colorRed)
errorbar(2,mean(corr2HumanMean,'omitnan'),std(corr2HumanMean,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(2,corr2HumanMean,'k.')

bar(3,mean(corr055MouseMean,'omitnan'),'FaceColor',colorBlue)
errorbar(3,mean(corr055MouseMean,'omitnan'),std(corr055MouseMean,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(3,corr055MouseMean,'k.')

bar(4,mean(corr055HumanMean,'omitnan'),'FaceColor',colorBlue)
errorbar(4,mean(corr055HumanMean,'omitnan'),std(corr055HumanMean,'omitnan'),'Color',[0.2,0.2,0.2])
scatter(4,corr055HumanMean,'k.')
xticks([1,2,3,4])
xticklabels({'mouse', 'human','mouse','human'})
xtickangle(30)
ylabel('correlation coefficient')
% legend({'2 Hz','','','','','','','','','','0.55 Hz',''},'Location','southoutside','NumColumns',2)
% legend box off
yline(0,'LineWidth',0.8)
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';