%% Colors
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
colorGray=[0.6,0.6,0.6];
%% Cut pieces 055Hz or 2Hz
cuts055=slowParams055.framesBeforeSlow+14:28:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow;%14 28
cuts2=slowParams2.framesBeforeSlow+4:8:slowParams2.framesBeforeSlow+slowParams2.framesDuringSlow;
%% 0.55Hz
classSlow=allROI055(topPart055);
cutMean055=zeros(length(classSlow),11,28,3);
for roi=1:length(classSlow)
    for c=1:length(cuts055)-1
        cutMean055(roi,c,:,:)=classSlow(roi).meanSlow(cuts055(c)+1:cuts055(c+1),:);
    end
end
maxPeaks055=squeeze(max(cutMean055,[],3));
peakRMI055=squeeze((maxPeaks055(:,:,1)-maxPeaks055(:,:,2))./(maxPeaks055(:,:,1)+maxPeaks055(:,:,2)));
meanPeakRMI055=mean(peakRMI055);
stdPeakRMI055=std(peakRMI055);
areaPeaks055=squeeze(abs(trapz(cutMean055,3)));
areaRMI055=squeeze((areaPeaks055(:,:,1)-areaPeaks055(:,:,2))./(areaPeaks055(:,:,1)+areaPeaks055(:,:,2)));
meanAreaRMI055=mean(areaRMI055);
stdAreaRMI055=std(areaRMI055);
sem055=stdAreaRMI055./sqrt(length(classSlow));
%% 0.55Hz Atropine
classSlow=atropine055(topPart055atropine);
cutMeanAtr=zeros(length(classSlow),11,28,3);
for roi=1:length(classSlow)
    for c=1:length(cuts055)-1
        cutMeanAtr(roi,c,:,:)=classSlow(roi).meanSlow(cuts055(c)+1:cuts055(c+1),:);
    end
end
maxPeaksAtr=squeeze(max(cutMeanAtr,[],3));
peakRMIAtr=squeeze((maxPeaksAtr(:,:,1)-maxPeaksAtr(:,:,2))./(maxPeaksAtr(:,:,1)+maxPeaksAtr(:,:,2)));
meanPeakRMIAtr=mean(peakRMIAtr);
stdPeakRMIAtr=std(peakRMIAtr);
areaPeaksAtr=squeeze(abs(trapz(cutMeanAtr,3)));
areaRMIAtr=squeeze((areaPeaksAtr(:,:,1)-areaPeaksAtr(:,:,2))./(areaPeaksAtr(:,:,1)+areaPeaksAtr(:,:,2)));
meanAreaRMIAtr=mean(areaRMIAtr);
stdAreaRMIAtr=std(areaRMIAtr);
semAtr=stdAreaRMIAtr./sqrt(length(classSlow));
%% 2Hz
classSlow=allROI2(topPart2);
cutMean2=zeros(length(classSlow),11,8,3);
for roi=1:length(classSlow)
    for c=1:length(cuts2)-1
        cutMean2(roi,c,:,:)=classSlow(roi).meanSlow(cuts2(c)+1:cuts2(c+1),:);
    end
end
maxPeaks2=squeeze(max(cutMean2,[],3));
peakRMI2=squeeze((maxPeaks2(:,:,1)-maxPeaks2(:,:,2))./(maxPeaks2(:,:,1)+maxPeaks2(:,:,2)));
meanPeakRMI2=mean(peakRMI2);
stdPeakRMI2=std(peakRMI2);
areaPeaks2=squeeze(abs(trapz(cutMean2,3)));
areaRMI2=squeeze((areaPeaks2(:,:,1)-areaPeaks2(:,:,2))./(areaPeaks2(:,:,1)+areaPeaks2(:,:,2)));
meanAreaRMI2=mean(areaRMI2);
stdAreaRMI2=std(areaRMI2);
sem2=stdAreaRMI2./sqrt(length(classSlow));
%% Plot 
figure('Color','w','Position',[100,100,600,400])
errorbar([1:11]-0.15,meanAreaRMI2,sem2,'Color',colorRed)
hold on
line([1:11]-0.15,meanAreaRMI2,'Color',colorRed,'LineWidth',1.5)
errorbar([1:11],meanAreaRMI055,sem055,'Color',colorBlue)
line([1:11],meanAreaRMI055,'Color',colorBlue,'LineWidth',1.5)
errorbar([1:11]+0.15,meanAreaRMIAtr,semAtr,'Color',colorGray)
line([1:11]+0.15,meanAreaRMIAtr,'Color',colorGray,'LineWidth',1.5)
yline(0,'--k','LineWidth',1)
ylim([-0.25,0.25])
yticks([-0.2,0,0.2])
ylabel('RMI')
xticks([1:11])
xticklabels({'1','2','3','4','5','6','7','8','9','10','11'})
xlabel('PeakNumber')
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';