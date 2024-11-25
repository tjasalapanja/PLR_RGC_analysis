function [RMI, RMIrandom, pd]=calculateRMI(allROI,flashParams,repeats)
RMI=zeros(length(allROI),1);
areaContra=zeros(length(allROI),1); % the precalculated are strange
areaBoth=zeros(length(allROI),1); % the precalculated are strange
for roi=1:length(allROI)
    areaBoth(roi)=trapz(abs(allROI(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,1)));
    areaContra(roi)=trapz(abs(allROI(roi).mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,2)));
    RMI(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
end
RMIrandom=zeros(length(allROI),1);
    for roi=1:length(allROI)
        area1list=zeros(1,repeats);
        area2list=zeros(1,repeats);
        c1_mix=zeros(size(allROI(roi).all_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,:,2)));
        c2_mix=zeros(size(allROI(roi).all_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,:,2)));
        for repeat=1:repeats
            c1_index=randi(5,[1,5]);
            c2_index=randi(5,[1,5]);
            for flash=1:5
                c1_mix(:,flash)=allROI(roi).all_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,c1_index(flash),3);
                c2_mix(:,flash)=allROI(roi).all_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,c2_index(flash),3);
            end
            c1_mean=mean(c1_mix,2);
            c2_mean=mean(c2_mix,2);
            area1list(repeat)=trapz(abs(c1_mean));
            area2list(repeat)=trapz(abs(c2_mean));
        end
        area1=mean(area1list);
        area2=mean(area2list);
        RMIrandom(roi)=(area1-area2)/(area1+area2);
    end
pd=fitdist(RMIrandom,'Normal');
end