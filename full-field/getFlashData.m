classdef getFlashData % all flash data for one ROI
    properties
        mean_flash % [flashParams.framesTotal,2 or 3] norm mean dF/F before+during+after flash for BOTH, CONTRA, (IPSI if present)
        mean_spks  % [flashParams.framesTotal,2 or 3] spks before+during+after flash for BOTH, CONTRA, (IPSI if present)
        std_flash  % [flashParams.framesTotal,2 or 3] std norm dF/F before+during+after flash for BOTH, CONTRA, (IPSI if present)
        all_flash  % [flashParams.framesTotal, number of flashes, 2 or 3] norm dF/F before+during+after flash for each flash for BOTH, CONTRA, (IPSI if present)
        all_spks   % [flashParams.framesTotal, number of flashes, 2 or 3] spks before+during+after flash for each flash for BOTH, CONTRA, (IPSI if present)
        dff        % [1, number of frames] total dF/F for ROI not normalized
        respondingROI % [1, 2 or 3] 1 if responding 0 if not responding for BOTH, CONTRA, (IPSI if present)
        mean_area_both % area under the curve during and same length after stimulus 
        mean_area_contra % area under the curve during and same length after stimulus 
        mean_area_ipsi % area under the curve during and same length after stimulus
        max_response % max response to each stimulus type during and same length after stimulus
        min_response %min response to each stimulus type during and same length after stimulus
    end
    methods
        function obj=getFlashData(loadedSuite2pData,flashParams,ipsi,number,randomized)
        [obj.mean_flash,...
            obj.std_flash,...
            obj.all_flash,...
            obj.all_spks,...
            obj.mean_spks,...
            obj.dff]=obj.meanByFlash(loadedSuite2pData,flashParams,ipsi,number,randomized);
        obj.respondingROI=obj.findResponding(ipsi);
        [obj.mean_area_both,obj.mean_area_contra,obj.mean_area_ipsi,obj.max_response,obj.min_response]=obj.findResponseIntensity(flashParams,ipsi);
        end
        function [mean_flash,std_flash,all_flash,all_spks,mean_spks,dff]=meanByFlash(~,loadedSuite2pData,flashParams,ipsi,number,randomized)
        % Extract dF/F for each flash (before-during-after), normalize,
        % Calculate mean, std.
        % Extract predicted deconvolved spike rates and mean spikes
            dff=loadedSuite2pData.dffNotNorm(number,:);
            if ipsi==1
                dim=3;
            else
                dim=2;
            end
            numFlashTotal=flashParams.numFlashes*dim;
            mean_flash=zeros(flashParams.framesTotal,dim);
            mean_spks=zeros(flashParams.framesTotal,dim);
            std_flash=zeros(flashParams.framesTotal,dim);
            all_flash=zeros(flashParams.framesTotal,flashParams.numFlashes,dim);
            all_spks=zeros(flashParams.framesTotal,flashParams.numFlashes,dim);
            for flash_type=1:dim
                if randomized ==1
                    if flash_type==1
                        f=[1,3,5,7,9,11];%[1,4,8,11,15,18];
                    else 
                        f=[2,4,6,8,10,12];%[3,6,9,12,14,17];
                    end

                else
                    if flash_type==1
                        f=1:dim:numFlashTotal;
                    elseif flash_type==2
                        f=2:dim:numFlashTotal;
                    else
                        f=3:dim:numFlashTotal;
                    end
                end
                begining_flash=flashParams.flashStart(f);
                all_flashtype=zeros(flashParams.framesTotal,flashParams.numFlashes);
                all_s=zeros(flashParams.framesTotal,flashParams.numFlashes);
                for flash=1:length(begining_flash)
                    all_flashtype(:,flash)=loadedSuite2pData.dffNotNorm(number,begining_flash(flash)-flashParams.framesBeforeFlash+1:begining_flash(flash)-flashParams.framesBeforeFlash+flashParams.framesTotal);
                    all_s(:,flash)=loadedSuite2pData.spks(number,begining_flash(flash)-flashParams.framesBeforeFlash+1:begining_flash(flash)-flashParams.framesBeforeFlash+flashParams.framesTotal);
                    %Normalize separately for each group dF/F but not
                    %spikes!!!!! Look into it!!!!! Ask Gioia!
                    meanBegining=mean(all_flashtype(1:flashParams.framesBeforeFlash,flash));
                    all_flashtype(:,flash)=(all_flashtype(:,flash)-meanBegining)/meanBegining;%
                end
                %
                mean_flash(:,flash_type)=mean(all_flashtype,2);
                mean_spks(:,flash_type)=mean(all_s,2);%3
                std_flash(:,flash_type)=std(all_flashtype,0,2); %0 for norm parameter of std, default, 3 for dimension 
                all_flash(:,:,flash_type)=all_flashtype;
                all_spks(:,:,flash_type)=all_s;
            end
        end
        function respondingROI=findResponding(obj,ipsi)
        % Test if responding for each of flash types based on Baden/Euler
        % 2016 paper
            if ipsi==1
                dim=3;
            else
                dim=2;
            end
            respondingROI=zeros(1,dim);
            for flashType=1:dim
                meanRoT=squeeze(mean(squeeze(obj.all_flash(:,:,flashType)),2));
                varmeanRoT=squeeze(var(meanRoT,0,1))';
                varRoT=squeeze(var(squeeze(obj.all_flash(:,:,flashType)),0,1))';
                meanvarRoT=squeeze(mean(varRoT,1));
                RQI=(varmeanRoT./meanvarRoT)';
                if RQI>0.45
                    respondingROI(flashType)=1;
                end
            end
            
        end
        function [mean_area_both,mean_area_contra,mean_area_ipsi,max_response,min_response]=findResponseIntensity(obj,flashParams,ipsi)
            mean_area_both=trapz(obj.mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,1));
            mean_area_contra=trapz(abs(obj.mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,2)));
            if ipsi ==1
                mean_area_ipsi=trapz(abs(obj.mean_flash(flashParams.framesBeforeFlash:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,3)));
            else
                mean_area_ipsi=0;
            end
            max_response=max(obj.mean_flash(flashParams.framesBeforeFlash:flashParams.framesDuringFlash+flashParams.framesAfterFlash,:));
            min_response=min(obj.mean_flash(flashParams.framesBeforeFlash:flashParams.framesDuringFlash+flashParams.framesAfterFlash,:));
        end
    end
end
