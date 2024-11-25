function [ipsiRespondingRQI]=findDuring(respondingROI,RQIcutoff,type)
    ipsiRespondingRQI=[];
    for roi=1:length(respondingROI)
        meanRoT=squeeze(mean(squeeze(respondingROI(roi).all_flash(39:115,:,type)),2));
        varmeanRoT=squeeze(var(meanRoT,0,1))';
        varRoT=squeeze(var(squeeze(respondingROI(roi).all_flash(39:115,:,type)),0,1))';
        meanvarRoT=squeeze(mean(varRoT,1));
        RQI=(varmeanRoT./meanvarRoT)';
        if RQI>RQIcutoff
            ipsiRespondingRQI=[ipsiRespondingRQI,roi];
        end
    end
