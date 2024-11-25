%pupils =[rows= animal, columns= LL]
RQIpupil=zeros(5,5); 
% pupils={allPupil1,allPupil2,allPupil3,allPupil4,allPupil5};
pupils={controlLL1,controlLL2,controlLL3,controlLL4,controlLL5};
for p=1:5 % each animal
    for roi=1:5 %each contrast
        meanRoT=squeeze(mean(squeeze([pupils{p}(roi).all_pupil(:,:,3)]),2));
        varmeanRoT=squeeze(var(meanRoT,0,1))';
        varRoT=squeeze(var(squeeze(pupils{p}(roi).all_pupil(:,:,3)),0,1))';
        meanvarRoT=squeeze(mean(varRoT,1));
        RQI=(varmeanRoT./meanvarRoT)';
        RQIpupil(p,roi)=RQI;
    end
end