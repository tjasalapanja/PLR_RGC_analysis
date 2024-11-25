figure('color','w','Position',[100,100,350,200])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(2,2,"TileSpacing","tight","Padding","tight")
% nexttile
% %pupil ctrl
% plotOnePupil(LL3,flashParams3,cmap,[-0.45,0.1],[2],0.05,1.5,1)
% ylabel('')
% yticks([])
% xlabel('')
% xticks([])
% axis off
% title('Control')
% nexttile
% %pupil atropine
% plotOnePupil(LL3atropine,flashParams3,cmap,[-0.25,0.1],[2],0.05,1.5,1)
% ylabel('')
% yticks([])
% xlabel('')
% xticks([])
% axis off
% title('Atropine')
% nexttile
% %pupil ctrl ipsi
% plotOnePupil(LL3,flashParams3,cmap,[-0.15,0.05],[3],0.05,1.5,0)
% ylabel('')
% yticks([])
% xlabel('')
% xticks([])
% axis off
% nexttile
% %pupil atropine ipsi
% plotOnePupil(LL3atropine,flashParams3,cmap,[-0.15,0.05],[3],0.05,1.5,0)
% ylabel('')
% yticks([])
% xlabel('')
% xticks([])
% axis off
% nexttile
% %heatmap contra
 clr=[175,88,186]+([175,88,186])*0.35;
 contraColor=getColormap(clr);
% offROI=responsesLL3(allOFFcontrol{3});
% areaOFF=zeros(length(allOFFcontrol{3}),1); % OrderByIpsi
% for roi=1:length(offROI)
%     areaOFF(roi)=trapz(abs(offROI(roi).mean_flash(flashParams3.framesBeforeFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,2)));
% end
% [~, ind] = sort(areaOFF,'descend');
% sortedResp=zeros(length(allOFFcontrol{3}),111,3);% rois,flashes
% c=1;
% for a=ind'
%     sortedResp(c,:,:)=offROI(a).mean_flash(31:141,[1:3]);
%     c=c+1;
% end
% h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.1,2.5]);
% map=contraColor;
% h.Colormap = map;
% h.ColorbarVisible =0;
% Ax = gca;
% Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
% Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% S = struct(h); % Undocumented
% ax = S.Axes;    % Undocumented
nexttile
%heatmap contra atropine
areaOFF=zeros(length(allDataPost),1); % OrderByIpsi
for roi=1:length(allDataPost)
    areaOFF(roi)=trapz(abs(allDataPost(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,2)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(allDataPost),152,3);% rois,flashes
c=1;
for a=ind'
    sortedResp(c,:,:)=allDataPost(a).mean_flash(31:182,[1:3]);
    c=c+1;
end
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.1,2]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% nexttile
% %heatmap ipsi
clr=[0,205,108]+([0,205,108])*0.2;
contraColor=getColormap(clr);
% offROI=responsesLL3(allOFFcontrol{3});
% areaOFF=zeros(length(allOFFcontrol{3}),1); % OrderByIpsi
% for roi=1:length(offROI)
%     areaOFF(roi)=trapz(abs(offROI(roi).mean_flash(flashParams3.framesBeforeFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,3)));
% end
% [~, ind] = sort(areaOFF,'descend');
% sortedResp=zeros(length(allOFFcontrol{3}),111,3);% rois,flashes
% c=1;
% for a=ind'
%     sortedResp(c,:,:)=offROI(a).mean_flash(31:141,[1:3]);
%     c=c+1;
% end
% h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,2.5]);
% map=contraColor;
% h.Colormap = map;
% h.ColorbarVisible =0;
% Ax = gca;
% Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
% Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
% S = struct(h); % Undocumented
% ax = S.Axes;    % Undocumented
nexttile
%heatmap ipsi atropine
areaOFF=zeros(length(allDataPost),1); % OrderByIpsi
for roi=1:length(allDataPost)
    areaOFF(roi)=trapz(abs(allDataPost(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(allDataPost),152,3);% rois,flashes
c=1;
for a=ind'
    sortedResp(c,:,:)=allDataPost(a).mean_flash(31:182,[1:3]);
    c=c+1;
end
h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,2]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
nexttile
% population response
% populationOne(offROI,flashParams,cmap,[2:3])
% axis off
% nexttile
%pop atropine
populationOne(allDataPost,flashParams,cmap,[2],[-0.1,1])
axis off
nexttile
populationOne(allDataPost,flashParams,cmap,[3],[-0.1,1])
axis off