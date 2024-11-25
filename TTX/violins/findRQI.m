function [RQIs]=findRQI(respondingROI,type)
    RQIs=zeros(1,length(respondingROI));
    for roi=1:length(respondingROI)
        meanRoT=squeeze(mean(squeeze(respondingROI(roi).all_flash(:,:,type)),2));
        varmeanRoT=squeeze(var(meanRoT,0,1))';
        varRoT=squeeze(var(squeeze(respondingROI(roi).all_flash(:,:,type)),0,1))';
        meanvarRoT=squeeze(mean(varRoT,1));
        RQI=(varmeanRoT./meanvarRoT)';
        RQIs(roi)=RQI;
    end
