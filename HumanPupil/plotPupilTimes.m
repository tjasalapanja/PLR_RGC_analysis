% delayPupilConstrictionMouse
% starting at stim begining
% framerate 15.49 mouse 20 human
% Mean drop start point: 9.75
% Standard deviation of drop start point: 2.3629
% delayPupilConstrictionHuman
% Mean drop start point: 10.3333
% Standard deviation of drop start point: 1.1547
mouseSeconds=start_pointsMouse./15.49;
humanSeconds=start_pointsHuman./20;

% pupilBottomTimeHuman
% Mean inflection point position: 20.6667
% Standard deviation of inflection point position: 1.5275
% pupilBottomTimeMouse
% Mean inflection point position: 16.6
% Standard deviation of inflection point position: 7.3689
mousePeakSeconds=inflection_pointsMouse./15.49;
humanPeakSeconds=inflection_pointsHuman./20;

figure('color','w','Position',[100,100,400,200])
tiledlayout(1,2,"TileSpacing","compact","Padding","compact")
nexttile
bar(1,mean(mouseSeconds,'omitnan'),'FaceColor',[40, 156, 140]./255,'EdgeColor','none')
hold on
errorbar(1,mean(mouseSeconds,'omitnan'),2.36./15.49,'Color','k')
scatter(1,mouseSeconds,45,'.k')
bar(2,mean(humanSeconds,'omitnan'),'FaceColor',[241, 162, 38]./255,'EdgeColor','none')
scatter(2,humanSeconds,45,'.k')
errorbar(2,mean(humanSeconds,'omitnan'),1.15./20,'Color','k')
xticks([])
% xticklabels({'Mouse','Human'})
ylim([0,1.6])
yline(0,'k')
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile
bar(1,mean(mousePeakSeconds,'omitnan'),'FaceColor',[40, 156, 140]./255,'EdgeColor','none')
hold on
errorbar(1,mean(mousePeakSeconds,'omitnan'),7.37./15.49,'Color','k')
scatter(1,mousePeakSeconds,45,'.k')
bar(2,mean(humanPeakSeconds,'omitnan'),'FaceColor',[241, 162, 38]./255,'EdgeColor','none')
scatter(2,humanPeakSeconds,45,'.k')
errorbar(2,mean(humanPeakSeconds,'omitnan'),1.53./20,'Color','k')
xticks([])
% xticklabels({'Mouse','Human'})
ylim([0,1.6])
yline(0,'k')
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';