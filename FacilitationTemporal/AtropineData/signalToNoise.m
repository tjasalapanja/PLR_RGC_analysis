%% StN ration old system Pietro
function StNRatio=signalToNoise(allROI,slowParams,cut)
    % meanSignal/stdNoise
    StNRatio=zeros(length(allROI),3);
    for ROI=1:length(allROI)
        d1 = designfilt("lowpassiir",FilterOrder=6,HalfPowerFrequency=0.3,DesignMethod="butter");
        smooth=filtfilt(d1,allROI(ROI).meanSlow);
        %smooth=movmean(allROI(ROI).meanSlow,5);
        noise=std(smooth(1:slowParams.framesBeforeSlow,:));
        signal=mean(smooth(cut,:));
        StNRatio(ROI,:)=signal./noise;
    end
end