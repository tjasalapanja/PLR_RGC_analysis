% zscore difference calculation
[zscoreLow,sumDifferenceLow]=zscoreDifference(type1, lowParams);
[~, ind] = sort(sumDifferenceLow,'descend');
sortedRespLow=zeros(length(type1),size(type1(1).mean_flash(:,:),1));
heatmapColorsLow=getColormap([0,154,222]);
heatmapColorsHigh=getColormap([255,31,91]);
c=1;
for a=ind'
    sortedRespLow(c,:)=zscoreLow(a,:);
    c=c+1;
end
[zscoreHigh,sumDifferenceHigh]=zscoreDifference(type2, highParams);
[~, ind] = sort(sumDifferenceHigh,'descend');
sortedRespHigh=zeros(length(type2),size(type2(1).mean_flash(:,:),1));
c=1;
for a=ind'
    sortedRespHigh(c,:)=zscoreHigh(a,:);
    c=c+1;
end
% Plot example contra example both difference heatmap
cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,200,300])
tiledlayout(6,2,'TileSpacing','tight','Padding','compact')
% example low contra
nexttile(1,[2,1])
plotOne(lowBoth(78),highParams,cmap,[-0.5,2.2],[2],1)
axis off
% example high contra
nexttile(2,[2,1])
plotOne(highBoth(78),lowParams,cmap,[-0.5,2.2],[2],1)
axis off
% example low both
nexttile(5,[2,1])
plotOne(lowBoth(78),highParams,cmap,[-0.5,2.2],[1],0)
axis off
% example high both
nexttile(6,[2,1])
plotOne(highBoth(78),lowParams,cmap,[-0.5,2.2],[1],0)
axis off
% heatmap low
nexttile(9) 
h=heatmap(sortedRespLow(:,:),'grid','off');
map=heatmapColorsLow;
h.Colormap = map;
h.ColorLimits=[-0.3,2];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% Ax.Position=[1,1,200,200]
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% heatmap high
nexttile (10)
map=heatmapColorsHigh;
h=heatmap(sortedRespHigh(:,:),'grid','off');
h.Colormap = map;
h.ColorLimits=[-0.3,2];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% Ax.Position=[1,1,200,200]
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% mean Zscore low
nexttile(11)
time=[-24:154-25]./15.49;
plot(time,mean(sortedRespLow),'Color',colorBlue,'LineWidth',1)
xlim([min(time),max(time)])
ylim([-0.5,1.5])
box off
hold on
xline(0,'k--','lineWidth',0.5)
xline(5,'k--','lineWidth',0.5)
yticks([])
xticks([])
% xlabel('time [s]', 'Fontsize',10)
% mean Zscore high
nexttile(12)
time=[-24:154-25]./15.49;
plot(time,mean(sortedRespHigh),'Color',colorRed,'LineWidth',1)
xlim([min(time),max(time)])
ylim([-0.5,1.5])
box off
hold on
xline(0,'k--','lineWidth',0.5)
xline(5,'k--','lineWidth',0.5)
yticks([])
xticks([])
% xlabel('time [s]', 'Fontsize',10)