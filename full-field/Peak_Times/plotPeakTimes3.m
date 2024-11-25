%Get ipsi responding OFF
class=find(pca.clsKmeans==1);
classROI=allTogether(class,:);
[~,ipsiResponding]=findIpsiZscore(classROI,3,0.3);
ipsi=classROI(ipsiResponding);
% Sort responses
areaIpsi=zeros(length(ipsi),1); % OrderByIpsi
for roi=1:length(ipsi)
    areaIpsi(roi)=trapz(abs(ipsi(roi).mean_flash(flashParams.framesBeforeFlash:end,3)));
end
[~, ind] = sort(areaIpsi,'descend');
sortedResp=zeros(length(ipsi),130,3);% rois,flashes
c=1;
for a=ind'
    sortedResp(c,:,:)=ipsi(a).mean_flash(31:160,[1:3]);
    c=c+1;
end
%Find Peak Times
peakTimes=zeros(length(ipsi),3);
peakHeight=zeros(length(ipsi),3);
len=31:160;
for roi=1:length(ipsi)
    [peakHeight(roi,:),peakTimes(roi,:)]=max(abs(ipsi(roi).mean_flash(len,:)));
end
bothColor=getColormap([255,198,30]);
contraColor=getColormap([175,88,186]);
ipsiColor=getColormap([0,205,108]);
figure('Color','w','Position',[100,100,200,300])
tiledlayout(5,1,'TileSpacing','compact','Padding','compact')
nexttile(1)
h=heatmap(sortedResp(:,:,1),'grid','off','Colorlimits',[-0.1,3]);
map=bothColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
col = [9,87];  
xline(ax, [col, col], 'k--')
ylabel('Both')
nexttile(2)
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.1,3]);
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
ylabel('Contra')
nexttile(3)
h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,3]);
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
ylabel('Ipsi')
nexttile(4,[2,1])
histogram(peakTimes(:,3),[0:3:130],'Facealpha',0.5,'FaceColor',[0,205,108]./255,'EdgeColor',[0,0.7,0.32])
hold on
histogram(peakTimes(:,2),[0:3:130],'Facealpha',0.5,'FaceColor',[175,88,186]./255,'EdgeColor',([175,88,186]./255)-0.1)
hold on
histogram(peakTimes(:,1),[0:3:130],'Facealpha',0.5,'FaceColor',[255,198,30]./255,'EdgeColor',([255,198,30]./255)-0.1)
% patchx=[8,9+77,9+77,8];
% patchy = [50,50,55,55];
% patch(patchx,patchy,[0,0,0],'FaceAlpha',0.6,'EdgeColor','None','HandleVisibility','off')
xline(8.5,'--')
xline(86.5,'--')
box off
ylim([0,90])
xlim([0,130])
h=gca;
h.YRuler.Axle.Visible = 'off'; 
% ylabel('max peak time [s]')
yticks([])
xticks([8,9+77])
xticklabels([0,5])
xlabel('time [s]')
