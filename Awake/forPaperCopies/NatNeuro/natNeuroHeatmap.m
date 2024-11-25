% time= -1s:end
figure('color','w','Position',[100,100,600,150])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(1,2,"TileSpacing","compact","Padding","compact")
%sortResponses
areaOFF=zeros(length(offROI),1); 
for roi=1:length(offROI)
    areaOFF(roi)=trapz(abs(offROI(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(offROI),171,3);% rois,flashes

c=1;
for a=ind'
    sortedResp(c,:,:)=offROI(a).mean_flash(22:192,[1:3]);
    c=c+1;
end

nexttile
%heatmap contra
clr=[175,88,186]+([175,88,186])*0.35;
contraColor=getColormap(clr);
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.1,2]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

nexttile
%heatmapIpsi
clr=[0,205,108]+([0,205,108])*0.2;
contraColor=getColormap(clr);
h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,2]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented