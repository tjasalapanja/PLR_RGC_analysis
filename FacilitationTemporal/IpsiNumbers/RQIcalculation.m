function RQI=RQIcalculation(respondingROI)
    RQI=zeros(length(respondingROI),3);
    for roi=1:length(respondingROI)
        for type=1:3
            meanRoT=squeeze(mean(squeeze(respondingROI(roi).allSlow(:,:,type)),2));
            varmeanRoT=squeeze(var(meanRoT,0,1))';
            varRoT=squeeze(var(squeeze(respondingROI(roi).allSlow(:,:,type)),0,1))';
            meanvarRoT=squeeze(mean(varRoT,1));
            RQI(roi,type)=(varmeanRoT./meanvarRoT)';
        end
    end
end