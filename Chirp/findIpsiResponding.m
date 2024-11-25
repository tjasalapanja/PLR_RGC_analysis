function [ipsiZscore,ipsiRQI]=findIpsiResponding(ROI, chirpParams,cutoff,RQIcutoff)
    cut=chirpParams.framesBeforeChirp:chirpParams.framesBeforeChirp+420;
    ipsiRQI=[];
    ipsiZscore=[];
    for roi=1:length(ROI)
        m=mean(ROI(roi).meanChirp(cut,3));
        s=std(ROI(roi).meanChirp(cut,3));
        z=max(abs((ROI(roi).meanChirp(cut,3)-m)./s));
        if z>cutoff
            ipsiZscore=[ipsiZscore,roi];
        end
        meanRoT=squeeze(mean(squeeze(ROI(roi).allChirp(cut,:,3)),2));
        varmeanRoT=squeeze(var(meanRoT,0,1))';
        varRoT=squeeze(var(squeeze(ROI(roi).allChirp(cut,:,3)),0,1))';
        meanvarRoT=squeeze(mean(varRoT,1));
        RQI=(varmeanRoT./meanvarRoT)';
        if RQI>RQIcutoff
            ipsiRQI=[ipsiRQI,roi];
        end
    end
end