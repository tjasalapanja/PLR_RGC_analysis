%% figure difference frame by frame
% First sort 2Hz
% pca2=lowContrastPCA(allROI2);
% pca055=lowContrastPCA(allROI055);
%%
colorRed=[255,31,91]./255;
heatmapRed=getColormap([210,0,56]);
colorBlue=[0,154,222]./255;
heatmapBlue=getColormap([0,101,146]);
colorGray=[150,150,150]./255;
heatmapGray=getColormap([150,150,150]);
% sort 2Hz
[zscoreSlow2,sumDifferenceLow2]=zscoreDifference(allROI2,slowParams2.framesTotal);
[~, ind] = sort(sumDifferenceLow2,'descend');
sortedRespSlow2=zeros(length(allROI2),248);
c=1;
for a=ind'
    sortedRespSlow2(c,:)=zscoreSlow2(a,:);%52
    c=c+1;
end
%sort 0.55Hz
[zscoreSlow055,sumDifferenceLow055]=zscoreDifference(allROI055,slowParams055.framesTotal);
[~, ind] = sort(sumDifferenceLow055,'descend');
sortedRespSlow055=zeros(length(allROI055),480);
c=1;
for a=ind'
    sortedRespSlow055(c,:)=zscoreSlow055(a,:);%52
    c=c+1;
end
%Then sort 0.55Hz atropine
[zscoreAtropine,sumDifferenceAtropine]=zscoreDifference(atropine055,slowParams055.framesTotal);
[~, ind] = sort(sumDifferenceAtropine,'descend');
sortedRespAtropine055=zeros(length(atropine055),480);
c=1;
for a=ind'
    sortedRespAtropine055(c,:)=zscoreAtropine(a,:);%52
    c=c+1;
end
% Plot 2Hz
hm=figure('Color','white','Position',[100,100,800,500]);
tiledlayout(5,3,'TileSpacing','compact','Padding','compact')

nexttile(1,[3,1])
h=heatmap(sortedRespSlow2(:,52:78+93),'grid','off');
h.Colormap =heatmapRed;
h.ColorLimits=[-0.2,1.8];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% ylabel('\Delta z score')
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% col = [25];  
% xline(ax, [col], 'k-','LineWidth',0.5);
% title('2 HZ')

% Plot 0.55Hz
nexttile(2,[3,1])
h=heatmap(sortedRespSlow055(:,52:78+325),'grid','off');
h.Colormap =heatmapBlue;
h.ColorLimits=[-0.2,1.8];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% col = [25, ];  
% xline(ax, [col], 'k-','LineWidth',0.5);
% title('0.55 Hz')


% Plot Atropine
nexttile(3,[3,1])
h=heatmap(sortedRespAtropine055(:,52:78+325),'grid','off');
h.Colormap =heatmapGray;
h.ColorLimits=[-0.2,1.8];
h.ColorbarVisible = 'off';
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% col = [25];  
% xline(ax, [col], 'k-','LineWidth',0.5);
% title('0.55H Atr.')


%Plot mean zscore 2Hz
nexttile(10,[2,1])
time=[-77:93+77]./15.49;
plot(time,mean(sortedRespSlow2),'LineWidth',2,'Color',colorRed)
xlim([-25,93]./15.49)
ylim([-0.05,max(mean(sortedRespSlow055))+0.01])
box off
hold on
ylim([-0.15,0.25])
% xlabel('time [s]', 'Fontsize',10)
ylabel('mean \Delta zscore','Fontsize',9)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';


%Plot mean zscore 0.55Hz
nexttile(11,[2,1])
time=[-77:325+77]./15.49;
plot(time,mean(sortedRespSlow055),'LineWidth',2,'Color',colorBlue)
hold on
xlim([-25,325]./15.49)
ylim([-0.05,max(mean(sortedRespSlow055))+0.01])
box off
hold on
ylim([-0.15,0.25])
% xlabel('time [s]', 'Fontsize',10)
% ylabel('mean','Fontsize',10)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';


% Plot mean atropine
nexttile(12,[2,1])
time=[-77:325+77]./15.49;
plot(time,mean(sortedRespAtropine055),'LineWidth',2,'Color',colorGray)
xlim([-25,325]./15.49)
ylim([-0.05,max(mean(sortedRespSlow055))+0.01])
box off
hold on
ylim([-0.15,0.25])
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
   