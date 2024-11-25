%% CalculateRMI 
function [RMI,sorted]=calculateRMI(allROI,slowParams)
RMI=zeros(length(allROI),1);
for roi=1:length(RMI)
    areaBoth(roi)=abs(trapz(movmean(allROI(roi).meanSlow(slowParams.framesBeforeSlow:slowParams.framesBeforeSlow+slowParams.framesDuringSlow,1),3)));
    areaContra(roi)=abs(trapz(movmean(allROI(roi).meanSlow(slowParams.framesBeforeSlow:slowParams.framesBeforeSlow+slowParams.framesDuringSlow,2),3)));
    RMI(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
end
sorted=sort(RMI,'ascend');