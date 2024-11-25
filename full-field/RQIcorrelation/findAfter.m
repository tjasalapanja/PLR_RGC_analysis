function [ipsiRespondingRQI,allRQI]=findAfter(respondingROI,RQIcutoff,type)
    ipsiRespondingRQI=[];
    allRQI=zeros(1,length(respondingROI));
    for roi=1:length(respondingROI)
        meanRoT=squeeze(mean(squeeze(respondingROI(roi).all_flash(115:192,:,type)),2));
        varmeanRoT=squeeze(var(meanRoT,0,1))';
        varRoT=squeeze(var(squeeze(respondingROI(roi).all_flash(115:192,:,type)),0,1))';
        meanvarRoT=squeeze(mean(varRoT,1));
        RQI=(varmeanRoT./meanvarRoT)';
        allRQI(roi)=RQI;
        if RQI>RQIcutoff
            ipsiRespondingRQI=[ipsiRespondingRQI,roi];
        end
    end
