% Precentages during control
respondingDuring=zeros(2,2);
[ipsiResponding]=findDuring(OFFhighPre,0.3,3);
respondingDuring(2,2)=length(ipsiResponding);
respondingDuring(1,2)=length(OFFhighPre)-length(ipsiResponding);
[contraDuringResponding]=findDuring(OFFhighPre,0.3,2);
respondingDuring(2,1)=length(contraDuringResponding);
respondingDuring(1,1)=length(OFFhighPre)-length(contraDuringResponding);
respondingPercentage=(respondingDuring.*100)./length(OFFhighPre);
% Precentages during atropine
respondingDuringAtropine=zeros(2,2);
[ipsiResponding]=findDuring(OFFhighPost,0.3,3);
respondingDuringAtropine(2,2)=length(ipsiResponding);
respondingDuringAtropine(1,2)=length(OFFhighPost)-length(ipsiResponding);
[contraDuringResponding]=findDuring(OFFhighPost,0.3,2);
respondingDuringAtropine(2,1)=length(contraDuringResponding);
respondingDuringAtropine(1,1)=length(OFFhighPost)-length(contraDuringResponding);
respondingPercentageAtropine=(respondingDuringAtropine.*100)./length(OFFhighPost);
%% Figure
figure('color','w','Position',[100,100,400,800])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(13,10,"TileSpacing","none","Padding","tight")
%pattern
nexttile(1,[1,4])
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(6,[1,4])
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

% nexttile(11,[2,4])
% %pupil ctrl
% plotOnePupil(highPre,flashParams,cmap,[-0.45,0.1],[2],0.05,1.5,0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% 
% nexttile (16,[2,4])
% %pupil atropine
% plotOnePupil(highPost,flashParams,cmap,[-0.45,0.1],[2],0.05,1.5,0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% 
% nexttile(31,[2,4])
% %pupil ctrl ipsi
% plotOnePupil(highPre,flashParams,cmap,[-0.15,0.05],[3],0.05,1.5,0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% 
% nexttile(36,[2,4])
% %pupil atropine ipsi
% plotOnePupil(highPost,flashParams,cmap,[-0.15,0.05],[3],0.05,1.5,0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

nexttile(51,[2,4])
%heatmap contra
clr=[175,88,186]+([175,88,186])*0.35;
contraColor=getColormap(clr);
offROI=OFFhighPre;
areaOFF=zeros(length(offROI),1); % OrderByIpsi
for roi=1:length(offROI)
    areaOFF(roi)=trapz(abs(offROI(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,2)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(offROI),111,3);% rois,flashes
c=1;
for i=ind'
    sortedResp(c,:,:)=offROI(i).mean_flash(31:141,[1:3]);
    c=c+1;
end
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.3,1.5]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

% Percentage
nexttile(55,[2,1])
cmap=[0.7,0.7,0.7;0.6863,0.3451,0.7294];
b=bar([1],respondingPercentage(:,1),'stacked','FaceColor','flat','BarWidth',1);
box off
b(1).CData = cmap(1,:);
b(2).CData=cmap(2,:);
b(1).BaseLine.Visible = 'off';
axis off

nexttile(56,[2,4])
%heatmap contra atropine
areaOFF=zeros(length(OFFhighPost),1); % OrderByIpsi
for roi=1:length(OFFhighPost)
    areaOFF(roi)=trapz(abs(OFFhighPost(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,2)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(OFFhighPost),111,3);% rois,flashes
c=1;
for i=ind'
    sortedResp(c,:,:)=OFFhighPost(i).mean_flash(31:141,[1:3]);
    c=c+1;
end
h=heatmap(sortedResp(:,:,2),'grid','off','Colorlimits',[-0.3,1.5]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

%Percentage atropine
nexttile(60,[2,1])
cmap=[0.7,0.7,0.7;0.6863,0.3451,0.7294];
b=bar([1],respondingPercentageAtropine(:,1),'stacked','FaceColor','flat','BarWidth',1);
box off
b(1).CData = cmap(1,:);
b(2).CData=cmap(2,:);
b(1).BaseLine.Visible = 'off';
axis off

nexttile(71,[2,4])
%heatmap ipsi
clr=[0,205,108]+([0,205,108])*0.2;
contraColor=getColormap(clr);
areaOFF=zeros(length(offROI),1); % OrderByIpsi
for roi=1:length(offROI)
    areaOFF(roi)=trapz(abs(offROI(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(offROI),111,3);% rois,flashes
c=1;
for i=ind'
    sortedResp(c,:,:)=offROI(i).mean_flash(31:141,[1:3]);
    c=c+1;
end
h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,1]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented

% Percentage ipsi
nexttile(75,[2,1])
cmap=[0.7,0.7,0.7;0,0.8039,0.4235];
b=bar([1],respondingPercentage(:,2),'stacked','FaceColor','flat','BarWidth',1);
box off
b(1).CData = cmap(1,:);
b(2).CData=cmap(2,:);
b(1).BaseLine.Visible = 'off';
axis off

nexttile(76,[2,4])
%heatmap ipsi atropine
areaOFF=zeros(length(OFFhighPost),1); % OrderByIpsi
for roi=1:length(OFFhighPost)
    areaOFF(roi)=trapz(abs(OFFhighPost(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3)));
end
[~, ind] = sort(areaOFF,'descend');
sortedResp=zeros(length(OFFhighPost),111,3);% rois,flashes
c=1;
for i=ind'
    sortedResp(c,:,:)=OFFhighPost(i).mean_flash(31:141,[1:3]);
    c=c+1;
end
h=heatmap(sortedResp(:,:,3),'grid','off','Colorlimits',[-0.1,1]);
map=contraColor;
h.Colormap = map;
h.ColorbarVisible =0;
Ax = gca;
Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
S = struct(h); % Undocumented
ax = S.Axes;    % Undocumented
% Percentage ipsi Atropine
nexttile(80,[2,1])
cmap=[0.7,0.7,0.7;0,0.8039,0.4235];
b=bar([1],respondingPercentageAtropine(:,2),'stacked','FaceColor','flat','BarWidth',1);
box off
b(1).CData = cmap(1,:);
b(2).CData=cmap(2,:);
b(1).BaseLine.Visible = 'off';
cmap=[255,198,30;175,88,186;0,205,108]./255;
axis off

nexttile(91,[2,4])
% population response
populationOne(offROI,flashParams,cmap,[2],[-0.4,1.5])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(96,[2,4])
%pop atropine Contra
populationOne(OFFhighPost,flashParams,cmap,[2],[-0.4,1.5])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(111,[2,4])
% population response ipsi
populationOne(offROI,flashParams,cmap,[3],[-0.2,0.4])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(116,[2,4])
%pop atropine
populationOne(OFFhighPost,flashParams,cmap,[3],[-0.2,0.4])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';