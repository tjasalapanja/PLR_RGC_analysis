classdef getFlashData % all flash data for one ROI
    properties
        mean_pupil % [flashParams.framesTotal,2 or 3] norm mean dF/F before+during+after flash for BOTH, CONTRA, (IPSI if present)
        std_pupil  % [flashParams.framesTotal,2 or 3] std norm dF/F before+during+after flash for BOTH, CONTRA, (IPSI if present)
        all_pupil  % [flashParams.framesTotal, number of flashes, 2 or 3] norm dF/F before+during+after flash for each flash for BOTH, CONTRA, (IPSI if present)
        pupilSize        % [1, number of frames] total dF/F for ROI not normalized
        mean_zscore
        std_zscore
        all_zscore
    end
    methods
        function obj=getFlashData(pupil,flashParams,ipsi,randomized,b,c,i)
        [obj.mean_pupil,...
            obj.std_pupil,...
            obj.all_pupil,...
            obj.pupilSize,...
            obj.mean_zscore,...
            obj.std_zscore,...
            obj.all_zscore]=obj.meanByFlash(pupil,flashParams,ipsi,randomized,b,c,i);
        end
        function [mean_pupil,std_pupil,all_pupil,pupilSize,mean_zscore,std_zscore,all_zscore]=meanByFlash(~,pupil,flashParams,ipsi,randomized,b,c,i)
        % Extract dF/F for each flash (before-during-after), normalize,
        % Calculate mean, std.
        % Extract predicted deconvolved spike rates and mean spikes
            pupilSize=pupil;
            if ipsi==1
                dim=3;
            else
                dim=2;
            end
            mean_pupil=zeros(flashParams.framesTotal,dim);
            std_pupil=zeros(flashParams.framesTotal,dim);
            all_pupil=zeros(flashParams.framesTotal,flashParams.numFlashes,dim);
            mean_zscore=zeros(flashParams.framesTotal,dim);
            std_zscore=zeros(flashParams.framesTotal,dim);
            all_zscore=zeros(flashParams.framesTotal,flashParams.numFlashes,dim);
            for pupil_type=1:dim
                if randomized==1
                    if pupil_type==1
                        f=b;
                    elseif pupil_type==2
                        f=c;
                    else
                        f=i;
                    end
                end
                begining_flash=flashParams.flashStart(f);
                all_pupiltype=zeros(flashParams.framesTotal,flashParams.numFlashes);
                all_zscoretype=zeros(flashParams.framesTotal,flashParams.numFlashes);
                for flash=1:length(begining_flash)
                    all_pupiltype(:,flash)=rescale(pupilSize(begining_flash(flash)-flashParams.framesBeforeFlash+1:begining_flash(flash)-flashParams.framesBeforeFlash+flashParams.framesTotal));
                    meanBegining=mean(all_pupiltype(1:flashParams.framesBeforeFlash,flash));
                    all_pupiltype(:,flash)=(all_pupiltype(:,flash)-meanBegining);%
                    std_all=std(pupilSize(begining_flash(flash)-flashParams.framesBeforeFlash+1:begining_flash(flash)-flashParams.framesBeforeFlash+flashParams.framesTotal));
                    all_zscoretype(:,flash)=((pupilSize(begining_flash(flash)-flashParams.framesBeforeFlash+1:begining_flash(flash)-flashParams.framesBeforeFlash+flashParams.framesTotal))-meanBegining)./std_all;
                end
                mean_pupil(:,pupil_type)=mean(all_pupiltype,2);
                std_pupil(:,pupil_type)=std(all_pupiltype,0,2); %0 for norm parameter of std, default, 3 for dimension 
                all_pupil(:,:,pupil_type)=all_pupiltype;
                mean_zscore(:,pupil_type)=mean(all_zscoretype,2);
                std_zscore(:,pupil_type)=std(all_zscoretype,0,2);
                all_zscore(:,:,pupil_type)=all_zscoretype;
            end
        end
    end
end
