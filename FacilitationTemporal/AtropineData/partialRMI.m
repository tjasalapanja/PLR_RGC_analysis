function [rmiEarly,rmiLate,randomEarly,randomLate]=partialRMI(classROI,slowParams,span,startPeak)
cuts=slowParams.framesBeforeSlow+span:2*span:slowParams.framesBeforeSlow+slowParams.framesDuringSlow;
% early: Peaks 2,3,4
earlyFrames=[cuts(startPeak):cuts(5)];
allEarly=zeros(length(classROI),length(earlyFrames),2);
% late: Peaks 6:12
lateFrames=[cuts(7):cuts(end)];
allLate=zeros(length(classROI),length(lateFrames),2);
for roi=1:length(classROI)
    allEarly(roi,:,:)=movmean(classROI(roi).meanSlow(earlyFrames,1:2),3);
    allLate(roi,:,:)=movmean(classROI(roi).meanSlow(lateFrames,1:2),3);
end
areaEarly=squeeze(abs(trapz(allEarly,2)));
rmiEarly=squeeze((areaEarly(:,1)-areaEarly(:,2))./(areaEarly(:,1)+areaEarly(:,2)));
areaLate=squeeze(abs(trapz(allLate,2)));
rmiLate=squeeze((areaLate(:,1)-areaLate(:,2))./(areaLate(:,1)+areaLate(:,2)));
randomEarly=findRandomRMI(classROI,earlyFrames,1);
randomLate=findRandomRMI(classROI,lateFrames,1);
end