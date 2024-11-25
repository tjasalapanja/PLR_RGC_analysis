pca=lowContrastPCA(allTogether);
% Get responding OFF
class=find(pca.clsKmeans==1);
classROI=allTogether(class,:);
% Responding During
respondingDuring=zeros(2,2);
[~,ipsiResponding]=findIpsiZscore(classROI,3,0.3);
respondingDuring(2,2)=length(ipsiResponding);
respondingDuring(1,2)=length(classROI)-length(ipsiResponding);
[contraDuringResponding]=findDuring(classROI,0.3,2);
respondingDuring(2,1)=length(contraDuringResponding);
respondingDuring(1,1)=length(classROI)-length(contraDuringResponding);
respondingPercentage=(respondingDuring.*100)./length(classROI);
% Sort responses
areaIpsi=zeros(length(classROI),1); % OrderByIpsi
for roi=1:length(classROI)
    areaIpsi(roi)=trapz(abs(classROI(roi).mean_flash(flashParams.framesBeforeFlash:end,3)));
end
[~, ind] = sort(areaIpsi,'descend');
sortedResp=zeros(length(classROI),130,2);% rois,flashes
c=1;
for a=ind'
    sortedResp(c,:,:)=classROI(a).mean_flash(31:160,[2,3]);
    c=c+1;
end
%Find Peak Times
peakTimes=zeros(length(classROI),3);
peakHeight=zeros(length(classROI),3);
len=31:160;
for roi=1:length(classROI)
    [peakHeight(roi,:),peakTimes(roi,:)]=max(abs(classROI(roi).mean_flash(len,:)));
end
contraColor=getColormap([175,88,186]);
ipsiColor=getColormap([0,205,108]);
%%
figure('Color','w','Position',[100,100,400,500])
tiledlayout(9,5,'TileSpacing','tight','Padding','compact')
nexttile(1,[1,4])
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
% Heatmap contra
nexttile(6,[2,4])
h=heatmap(sortedResp(:,:,1),'grid','off','Colorlimits',[-0.1,3]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
col = [9,87];  
xline(ax, [col, col], 'k--')
%ylabel('Contra')
% Percentage
nexttile(10,[2,1])
cmap=[0.7,0.7,0.7;0.6863,0.3451,0.7294];
b=bar([1],respondingPercentage(:,1),'stacked','FaceColor','flat','BarWidth',1);
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
% b.FaceColor = 'flat';
b(1).CData = cmap(1,:);
b(2).CData=cmap(2,:);
b(1).BaseLine.Visible = 'off';
% Heatmap ipsi
nexttile(16,[2,4])
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.1,3]);
map=ipsiColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
col = [9,87];  
xline(ax, [col, col], 'k--')
%ylabel('Ipsi')
%Percentage
nexttile(20,[2,1])
cmap=[0.7,0.7,0.7;0,0.8039,0.4235];
b=bar([1],respondingPercentage(:,2),'stacked','FaceColor','flat','BarWidth',1);
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
% b.FaceColor = 'flat';
b(1).CData = cmap(1,:);
b(2).CData=cmap(2,:);
b(1).BaseLine.Visible = 'off';
% Peak Times
nexttile(26,[4,4])
histogram(peakTimes(:,3),[0:3:130],'FaceColor',[0,205,108]./255,'EdgeColor',[0,0.7,0.32])
hold on
histogram(peakTimes(:,2),[0:3:130],'FaceColor',[175,88,186]./255,'EdgeColor',([175,88,186]./255)-0.1)
% patchx=[8,9+77,9+77,8];
% patchy = [81,81,85,85];
% patch(patchx,patchy,[0,0,0],'FaceAlpha',0.6,'EdgeColor','None','HandleVisibility','off')
xline(8.5,'--')
xline(86.5,'--')
box off
ylim([0,200])
xlim([0,130])
h=gca;
%  h.YRuler.Axle.Visible = 'off'; 
% ylabel('max peak time [s]')
h.Color='w';
h.YColor = 'w';
h.XColor ='w';
yticks([])
xticks([8,9+77])
xticklabels([0,5])
xlabel('time [s]')
