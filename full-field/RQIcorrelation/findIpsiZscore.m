function [ipsiRespondingZscore, ipsiRespondingRQI,allRQI]=findIpsiZscore(respondingROI,limScore,RQIcutoff)
    ipsiRespondingZscore=[];
    ipsiRespondingRQI=[];
    allRQI=zeros(1,length(respondingROI));
    for roi=1:length(respondingROI)
        longTrace=movmean([respondingROI(roi).mean_flash(:,1),respondingROI(roi).mean_flash(:,2),respondingROI(roi).mean_flash(:,3)],3);
        mLong=mean(longTrace);
        sLong=std(longTrace);
        zscores=(respondingROI(roi).mean_flash(:,3)-mLong)/sLong;
        if max(abs(zscores)>limScore)
            ipsiRespondingZscore=[ipsiRespondingZscore,roi];
        end
        meanRoT=squeeze(mean(squeeze(respondingROI(roi).all_flash(:,:,3)),2));
        varmeanRoT=squeeze(var(meanRoT,0,1))';
        varRoT=squeeze(var(squeeze(respondingROI(roi).all_flash(:,:,3)),0,1))';
        meanvarRoT=squeeze(mean(varRoT,1));
        RQI=(varmeanRoT./meanvarRoT)';
        allRQI(roi)=RQI;
        if RQI>RQIcutoff
            ipsiRespondingRQI=[ipsiRespondingRQI,roi];
        end
    end
