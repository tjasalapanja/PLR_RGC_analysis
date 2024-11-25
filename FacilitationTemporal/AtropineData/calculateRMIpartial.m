%% CalculateRMI 
function RMI=calculateRMIpartial(allROI,cutPart)
RMI=zeros(length(allROI),1);
for roi=1:length(RMI)
    areaBoth(roi)=abs(trapz(movmean(allROI(roi).meanSlow(cutPart,1),3)));
    areaContra(roi)=abs(trapz(movmean(allROI(roi).meanSlow(cutPart,2),3)));
    RMI(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
end
