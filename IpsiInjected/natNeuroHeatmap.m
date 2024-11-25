% time= -1s:end
figure('color','w','Position',[100,100,600,250])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(5,2,"TileSpacing","compact","Padding","compact")
nexttile(1)
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2)
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
%sortResponses
areaOFF=zeros(length(OFFroi),1); 
for roi=1:length(OFFroi)
    areaOFF(roi)=trapz(abs(OFFroi(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(OFFroi),144,3);% rois,flashes

c=1;
for a=ind'
    sortedResp(c,:,:)=OFFroi(a).mean_flash(11:154,[1:3]);
    c=c+1;
end

nexttile(3,[4,1])
%heatmap contra
clr=[175,88,186]+([175,88,186])*0.35;
contraColor=getColormap(clr);
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.1,2.5]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

nexttile(4,[4,1])
%heatmapIpsi
clr=[0,205,108]+([0,205,108])*0.2;
contraColor=getColormap(clr);
h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,2.5]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
