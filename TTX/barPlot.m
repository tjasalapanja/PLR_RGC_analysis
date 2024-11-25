%% Make bar plot with peakDuring size
% get colorscheme
cmap=[175,88,186;0,205,108;125,125,125]./255;
% get Max value during and before (in case I use background -during)
maxPeakDuringContra=zeros(length(OFFpostTTX),1);
maxPeakDuringIpsi=zeros(length(OFFpostTTX),1);
maxPeakBeforeContra=zeros(length(OFFpostTTX),1);
maxPeakBeforeIpsi=zeros(length(OFFpostTTX),1);

for roi=1:length(OFFpostTTX)
    maxPeakBeforeContra(roi)=max(OFFpostTTX(roi).mean_flash(1:flashParams.framesBeforeFlash,2));
    maxPeakBeforeIpsi(roi)=max(OFFpostTTX(roi).mean_flash(1:flashParams.framesBeforeFlash,3));
    maxPeakDuringContra(roi)=max(OFFpostTTX(roi).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,2));
    maxPeakDuringIpsi(roi)=max(OFFpostTTX(roi).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3));
end
meanIpsi=mean(maxPeakDuringIpsi);
semIpsi=std(maxPeakDuringIpsi)./sqrt(length(maxPeakDuringIpsi));
meanContra=mean(maxPeakDuringContra);
semContra=std(maxPeakDuringContra)./sqrt(length(maxPeakDuringContra));
meanBckg=mean(maxPeakBeforeContra);
semBckg=std(maxPeakBeforeContra)./sqrt(length(maxPeakBeforeContra));
diffIpsi=(maxPeakDuringIpsi-maxPeakBeforeIpsi)./(maxPeakBeforeIpsi+maxPeakDuringIpsi);
diffContra=(maxPeakDuringContra-maxPeakBeforeContra)./(maxPeakBeforeContra+maxPeakDuringContra);
meanDiffIpsi=mean(diffIpsi);
semDiffIpsi=std(diffIpsi)./sqrt(length(diffIpsi));
meanDiffContra=mean(diffContra);
semDiffContra=std(diffContra)./sqrt(length(diffContra));
% get bar plot
figure('Color','w','Position',[100,100,200,600])
tiledlayout(2,1)

nexttile
b=bar([1,2,3],[meanContra, meanIpsi,meanBckg]);
b.FaceColor = 'flat';
b.CData(1,:) = cmap(1,:);
b.CData(2,:) = cmap(2,:);
b.CData(3,:) = cmap(3,:);
hold on
errorbar([1,2,3],[meanContra,meanIpsi,meanBckg],[semContra,semIpsi,semBckg],'k','LineStyle','none')
title('mean during')
xticklabels({'Contra','Ipsi'})
xtickangle(45)
ylim([0,1.2])
yline(0,'k')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% xticks([])

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