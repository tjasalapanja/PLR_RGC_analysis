% Zscore Difference
[zscoreLow,sumDifferenceLow]=zscoreDifference(responsesLL2(OFFcontrol{2}));
[~, ind] = sort(sumDifferenceLow,'descend');
sortedRespLow=zeros(length(responsesLL2(OFFcontrol{2})),size(responsesLL2(1).mean_flash(:,:),1));
heatmapColorsLow=getColormap([255,82,4]);
heatmapColorsHigh=getColormap([8,153,126]);
c=1;
for a=ind'
    sortedRespLow(c,:)=zscoreLow(a,:);
    c=c+1;
end
[zscoreHigh,sumDifferenceHigh]=zscoreDifference(responsesLL5(OFFcontrol{5}));
[~, ind] = sort(sumDifferenceHigh,'descend');
sortedRespHigh=zeros(length(responsesLL5(OFFcontrol{5})),size(responsesLL5(1).mean_flash(:,:),1));
c=1;
for a=ind'
    sortedRespHigh(c,:)=zscoreHigh(a,:);
    c=c+1;
end
cmap=[255,82,4;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,500,700])
tiledlayout(7,2,'TileSpacing','compact','Padding','compact')
nexttile

stim_before = zeros(1,24);
stim_during = ones(1,77); 
stim_after = zeros(1,39);
seq = [stim_before, stim_during, stim_after];
seconds = (([1:length(seq)]./flashParams2.FRAMERATE)-(length(stim_before)./flashParams2.FRAMERATE));  
plot(seconds,seq,'LineWidth',1,'Color',[0.2,0.2,0.2],'LineWidth',1.5)
xlim([seconds(1),seconds(end)])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile
plot(seconds,seq,'LineWidth',1,'Color',[0.2,0.2,0.2],'LineWidth',1.5)
xlim([seconds(1),seconds(end)])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

% heatmap low
nexttile(3,[4,1]) 
h=heatmap(sortedRespLow(:,:),'grid','off');
map=heatmapColorsLow;
h.Colormap = map;
h.ColorLimits=[-0.5,2.7];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% Ax.Position=[1,1,200,200]
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

% heatmap high
nexttile (4,[4,1])
map=heatmapColorsHigh;
h=heatmap(sortedRespHigh(:,:),'grid','off');
h.Colormap = map;
h.ColorLimits=[-0.5,2.7];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% Ax.Position=[1,1,200,200]
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

% mean Zscore low
nexttile(11,[2,1])
time=[-24:141-25]./15.49;
plot(time,mean(sortedRespLow),'Color',colorOrange,'LineWidth',2)
xlim([min(time),max(time)])
ylim([-0.35,0.8])
box off
hold on
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% xline(0,'k--','lineWidth',0.5)
% xline(5,'k--','lineWidth',0.5)
% yticks([])
% xticks([])
% xlabel('time [s]', 'Fontsize',10)

% mean Zscore high
nexttile(12,[2,1])
time=[-24:141-25]./15.49;
plot(time,mean(sortedRespHigh),'Color',[8,153,126]./255,'LineWidth',2)
xlim([min(time),max(time)])
ylim([-0.35,0.8])
box off
hold on
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% xline(0,'k--','lineWidth',0.5)
% xline(5,'k--','lineWidth',0.5)
% yticks([])
% xticks([])
% xlabel('time [s]', 'Fontsize',10)