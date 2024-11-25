% function [zscore,sumDifference]=zscoreDifference(classROI, flashParams)
%     %concatinate contra+both, find zscore mean and std for both together
%     allTrace=zeros(length(classROI),flashParams.framesDuringFlash+flashParams.framesAfterFlash,2);
%     zscore=zeros(length(classROI),size(classROI(1).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,1:2),1));
%     sumDifference=zeros(length(classROI),1);
%     for roi=1:length(classROI)
%         allTrace(roi,:,:)=classROI(roi).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,1:2);
%         concat=[classROI(roi).mean_flash(:,1),classROI(roi).mean_flash(:,2)];
%         m=mean(concat);
%         s=std(concat);
%         zscoreB=(classROI(roi).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,1)-m)/s;
%         zscoreC=(classROI(roi).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,2)-m)/s;
%         zscore(roi,:)=movmean((zscoreB-zscoreC),10);
%         sumDifference(roi)=sum(zscore(roi,:));
%     end
% end
function [zscore,sumDifference]=zscoreDifference(classROI)
    %concatinate contra+both, find zscore mean and std for both together
    allTrace=zeros(length(classROI),141,2);
    zscore=zeros(length(classROI),141);
    sumDifference=zeros(length(classROI),1);
    for roi=1:length(classROI)
        allTrace(roi,:,:)=classROI(roi).mean_flash(:,1:2);
        concat=[classROI(roi).mean_flash(:,1),classROI(roi).mean_flash(:,2)];
        m=mean(concat);
        s=std(concat);
        zscoreB=(classROI(roi).mean_flash(:,1)-m)/s;
        zscoreC=(classROI(roi).mean_flash(:,2)-m)/s;
        zscore(roi,:)=movmean((zscoreB-zscoreC),5);
        sumDifference(roi)=sum(zscore(roi,:));
    end
end