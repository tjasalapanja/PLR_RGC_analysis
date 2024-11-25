function [cutMean,areaPeaks,maxPeaks,meanAreaRMI,sem,peakRMI]=cutPieces(classSlow,slowParams,stim055)
if stim055==1
    cuts=slowParams.framesBeforeSlow+14:28:slowParams.framesBeforeSlow+slowParams.framesDuringSlow;
else
    cuts=slowParams.framesBeforeSlow+4:8:slowParams.framesBeforeSlow+slowParams.framesDuringSlow;
end
cutMean=zeros(length(classSlow),11,28,3);
for roi=1:length(classSlow)
    for c=1:length(cuts)-1
        cutMean(roi,c,:,:)=classSlow(roi).meanSlow(cuts(c)+1:cuts(c+1),:);
    end
end
maxPeaks=squeeze(max(cutMean,[],3));
peakRMI=squeeze((maxPeaks(:,:,1)-maxPeaks(:,:,2))./(maxPeaks(:,:,1)+maxPeaks(:,:,2)));
areaPeaks=squeeze(abs(trapz(cutMean,3)));
areaRMI=squeeze((areaPeaks(:,:,1)-areaPeaks(:,:,2))./(areaPeaks(:,:,1)+areaPeaks(:,:,2)));
meanAreaRMI=mean(areaRMI);
stdAreaRMI=std(areaRMI);
sem=stdAreaRMI./sqrt(length(classSlow));


