%% Make bar plot with peakDuring size
% get colorscheme
cmap=[175,88,186;0,205,108;125,125,125]./255;
% get OFF data
OFFcontrol=responsesLL3(allOFFcontrol{3});
OFFatr=atropineLL3(OFFatropine{3});
% get Max value during and before (in case I use background -during)
maxPeakDuringContra=zeros(length(OFFcontrol),1);
maxPeakDuringIpsi=zeros(length(OFFcontrol),1);
maxPeakBeforeContra=zeros(length(OFFcontrol),1);
maxPeakBeforeIpsi=zeros(length(OFFcontrol),1);

maxAtrDuringContra=zeros(length(OFFatr),1);
maxAtrDuringIpsi=zeros(length(OFFatr),1);
maxAtrBeforeContra=zeros(length(OFFatr),1);
maxAtrBeforeIpsi=zeros(length(OFFatr),1);


for roi=1:length(OFFcontrol)
    maxPeakBeforeContra(roi)=max(OFFcontrol(roi).mean_flash(27:flashParams3.framesBeforeFlash,2));
    maxPeakBeforeIpsi(roi)=max(OFFcontrol(roi).mean_flash(27:flashParams3.framesBeforeFlash,3));
    maxPeakDuringContra(roi)=max(OFFcontrol(roi).mean_flash(flashParams3.framesBeforeFlash+1:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,2));
    maxPeakDuringIpsi(roi)=max(OFFcontrol(roi).mean_flash(flashParams3.framesBeforeFlash+1:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,3));
end
meanIpsi=mean(maxPeakDuringIpsi);
semIpsi=std(maxPeakDuringIpsi)./sqrt(length(maxPeakDuringIpsi));
meanContra=mean(maxPeakDuringContra);
semContra=std(maxPeakDuringContra)./sqrt(length(maxPeakDuringContra));
meanBackground=mean(maxPeakBeforeContra);
semBackground=std(maxPeakBeforeContra)./sqrt(length(maxPeakBeforeContra));

diffIpsiNorm=(maxPeakDuringIpsi-maxPeakBeforeIpsi)./((maxPeakDuringIpsi+maxPeakBeforeIpsi));
diffContraNorm=(maxPeakDuringContra-maxPeakBeforeContra)./((maxPeakDuringContra+maxPeakBeforeContra));
meanDiffIpsi=mean(diffIpsiNorm);
semDiffIpsi=std(diffIpsiNorm)./sqrt(length(diffIpsiNorm));
meanDiffContra=mean(diffContraNorm);
semDiffContra=std(diffContraNorm)./sqrt(length(diffContraNorm));

for roi=1:length(OFFatr)
    maxAtrBeforeContra(roi)=max(OFFatr(roi).mean_flash(27:flashParams3.framesBeforeFlash,2));
    maxAtrBeforeIpsi(roi)=max(OFFatr(roi).mean_flash(27:flashParams3.framesBeforeFlash,3));
    maxAtrDuringContra(roi)=max(OFFatr(roi).mean_flash(flashParams3.framesBeforeFlash+1:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,2));
    maxAtrDuringIpsi(roi)=max(OFFatr(roi).mean_flash(flashParams3.framesBeforeFlash+1:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,3));
end
meanIpsiAtr=mean(maxAtrDuringIpsi);
semIpsiAtr=std(maxAtrDuringIpsi)./sqrt(length(maxAtrDuringIpsi));
meanContraAtr=mean(maxAtrDuringContra);
semContraAtr=std(maxAtrDuringContra)./sqrt(length(maxAtrDuringContra));
meanBackgroundAtr=mean(maxAtrBeforeContra);
semBackgroundAtr=std(maxAtrBeforeContra)./sqrt(length(maxAtrBeforeContra));

diffIpsiNorm=(maxAtrDuringIpsi-maxAtrBeforeIpsi)./((maxAtrDuringIpsi+maxAtrBeforeIpsi));
diffContraNorm=(maxAtrDuringContra-maxAtrBeforeContra)./((maxAtrDuringContra+maxAtrBeforeContra));
meanDiffIpsiAtr=mean(diffIpsiNorm);
semDiffIpsiAtr=std(diffIpsiNorm)./sqrt(length(diffIpsiNorm));
meanDiffContraAtr=mean(diffContraNorm);
semDiffContraAtr=std(diffContraNorm)./sqrt(length(diffContraNorm));


% get bar plot
figure('Color','w','Position',[100,100,400,600])
tiledlayout(2,2)

nexttile
b=bar([1,2,3],[meanContra, meanIpsi,meanBackground]);
b.FaceColor = 'flat';
b.CData(1,:) = cmap(1,:);
b.CData(2,:) = cmap(2,:);
b.CData(3,:) = cmap(3,:);
hold on
errorbar([1,2,3],[meanContra,meanIpsi,meanBackground],[semContra,semIpsi,semBackground],'k','LineStyle','none')
title('max during')
xticklabels({'Contra','Ipsi','Bckg'})
xtickangle(45)
ylim([0,1.2])
yline(0,'k')
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
xticks([])

nexttile
b=bar([1,2,3],[meanContraAtr, meanIpsiAtr,meanBackgroundAtr]);
b.FaceColor = 'flat';
b.CData(1,:) = cmap(1,:);
b.CData(2,:) = cmap(2,:);
b.CData(3,:) = cmap(3,:);
hold on
errorbar([1,2,3],[meanContraAtr,meanIpsiAtr,meanBackgroundAtr],[semContraAtr,semIpsiAtr,semBackgroundAtr],'k','LineStyle','none')
title('max during atropine')
xticklabels({'Contra','Ipsi','Bckg.'})
xtickangle(45)
ylim([0,1.2])
yline(0,'k')
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
xticks([])

nexttile
b=bar([1,2],[meanDiffContra, meanDiffIpsi]);
b.FaceColor = 'flat';
b.CData(1,:) = cmap(1,:);
b.CData(2,:) = cmap(2,:);
hold on
errorbar([1,2],[meanDiffContra,meanDiffIpsi],[semDiffContra,semDiffIpsi],'k','LineStyle','none')
title('mean difference')
xticklabels({'Contra','Ipsi'})
xtickangle(45)
ylim([-0.6,1])
yline(0,'k')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% xticks([])

nexttile
b=bar([1,2],[meanDiffContraAtr, meanDiffIpsiAtr]);
b.FaceColor = 'flat';
b.CData(1,:) = cmap(1,:);
b.CData(2,:) = cmap(2,:);
hold on
errorbar([1,2],[meanDiffContraAtr,meanDiffIpsiAtr],[semDiffContraAtr,semDiffIpsiAtr],'k','LineStyle','none')
title('mean difference atropine')
xticklabels({'Contra','Ipsi'})
xtickangle(45)
ylim([-0.6,1])
yline(0,'k')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
xticks([])