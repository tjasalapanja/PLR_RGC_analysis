function [peakHeightLow,peakHeightHigh]=findPeakTimes(low,high,flashParams)
    len=flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash;
    peakHeightLow=zeros(length(low),3);
    peakHeightHigh=zeros(length(high),3);
    for roi=1:length(low)
        [peakHeightLow(roi,:)]=max(abs(low(roi).mean_flash(len,:)));
    end
    for roi=1:length(high)
        [peakHeightHigh(roi,:)]=max(abs(high(roi).mean_flash(len,:)));
    end
end