classdef getSlowData % all flash data for one ROI
    properties
        meanSlow % [flashParams.framesTotal,2 or 3] norm mean dF/F before+during+after flash for BOTH, CONTRA, (IPSI if present)
        meanSpks  % [flashParams.framesTotal,2 or 3] spks before+during+after flash for BOTH, CONTRA, (IPSI if present)
        stdSlow  % [flashParams.framesTotal,2 or 3] std norm dF/F before+during+after flash for BOTH, CONTRA, (IPSI if present)
        allSlow  % [flashParams.framesTotal, number of flashes, 2 or 3] norm dF/F before+during+after flash for each flash for BOTH, CONTRA, (IPSI if present)
        allSpks   % [flashParams.framesTotal, number of flashes, 2 or 3] spks before+during+after flash for each flash for BOTH, CONTRA, (IPSI if present)
        dff        % [1, number of frames] total dF/F for ROI not normalized
        respondingROI % [1, 2 or 3] 1 if responding 0 if not responding for BOTH, CONTRA, (IPSI if present)
        meanAreaBoth % area under the curve during and same length after stimulus 
        meanAreaContra % area under the curve during and same length after stimulus 
        meanAreaIpsi % area under the curve during and same length after stimulus
    end
    methods
        function obj=getSlowData(loadedSuite2pData,slowParams,number,randomized)
        [obj.meanSlow,...
            obj.stdSlow,...
            obj.allSlow,...
            obj.allSpks,...
            obj.meanSpks,...
            obj.dff]=obj.meanBySlow(loadedSuite2pData,slowParams,number,randomized);
        obj.respondingROI=obj.findResponding();
        [obj.meanAreaBoth,obj.meanAreaContra,obj.meanAreaIpsi]=obj.findResponseIntensity(slowParams);
        end
        function [meanSlow,stdSlow,allSlow,allSpks,meanSpks,dff]=meanBySlow(~,loadedSuite2pData,slowParams,number,randomized)
        % Extract dF/F for each flash (before-during-after), normalize,
        % Calculate mean, std.
        % Extract predicted deconvolved spike rates and mean spikes
            dff=loadedSuite2pData.dffNotNorm(number,:);
            dim=3;
            numSlowTotal=slowParams.numSlow*dim;
            meanSlow=zeros(slowParams.framesTotal,dim);
            meanSpks=zeros(slowParams.framesTotal,dim);
            stdSlow=zeros(slowParams.framesTotal,dim);
            allSlow=zeros(slowParams.framesTotal,slowParams.numSlow,dim);
            allSpks=zeros(slowParams.framesTotal,slowParams.numSlow,dim);
            % Randomized stim pattern
            for slowType=1:dim
                if randomized==1
                    if slowType==1
                        c=[1,5,8,12,15]; 
                    elseif slowType==2
                        c=[3,6,9,11,14]; %3
                    else
                        c=[2,4,7,10,13]; %2
                    end
                else
                    if slowType==1
                        c=1:dim:numSlowTotal;
                    elseif slowType==2
                        c=2:dim:numSlowTotal;
                    else
                        c=3:dim:numSlowTotal;
                    end
                end
                beginingSlow=slowParams.slowStart(c);
                allSlowType=zeros(slowParams.framesTotal,slowParams.numSlow);
                allS=zeros(slowParams.framesTotal,slowParams.numSlow);
                for slow=1:length(beginingSlow)
                    allSlowType(:,slow)=loadedSuite2pData.dffNotNorm(number,beginingSlow(slow)-slowParams.framesBeforeSlow+1:beginingSlow(slow)-slowParams.framesBeforeSlow+slowParams.framesTotal);
                    allS(:,slow)=loadedSuite2pData.spks(number,beginingSlow(slow)-slowParams.framesBeforeSlow+1:beginingSlow(slow)-slowParams.framesBeforeSlow+slowParams.framesTotal);
                    %Normalize separately for each group dF/F but not
                    %spikes!!!!! Look into it!!!!! Ask Gioia!
                    meanBegining=mean(allSlowType(1:slowParams.framesBeforeSlow,slow));
                    allSlowType(:,slow)=(allSlowType(:,slow)-meanBegining)/meanBegining;%
                end
                %
                meanSlow(:,slowType)=mean(allSlowType,2);
                meanSpks(:,slowType)=mean(allS,2);%3
                stdSlow(:,slowType)=std(allSlowType,0,2); %0 for norm parameter of std, default, 3 for dimension 
                allSlow(:,:,slowType)=allSlowType;
                allSpks(:,:,slowType)=allS;
            end
        end
        function respondingROI=findResponding(obj)
        % Test if responding for each of flash types based on Baden/Euler
        % 2016 paper
            dim=3;
            respondingROI=zeros(1,dim);
            for slowType=1:dim
                meanRoT=squeeze(mean(squeeze(obj.allSlow(:,:,slowType)),2));
                varmeanRoT=squeeze(var(meanRoT,0,1))';
                varRoT=squeeze(var(squeeze(obj.allSlow(:,:,slowType)),0,1))';
                meanvarRoT=squeeze(mean(varRoT,1));
                RQI=(varmeanRoT./meanvarRoT)';
                if RQI>0.35
                    respondingROI(slowType)=1;
                end
            end
            
        end
        function [meanAreaBoth,meanAreaContra,meanAreaIpsi]=findResponseIntensity(obj,slowParams)
            meanAreaBoth=trapz(obj.meanSlow(slowParams.framesBeforeSlow:slowParams.framesBeforeSlow+slowParams.framesDuringSlow,1));
            meanAreaContra=trapz(obj.meanSlow(slowParams.framesBeforeSlow:slowParams.framesBeforeSlow+slowParams.framesDuringSlow,2));
            meanAreaIpsi=trapz(obj.meanSlow(slowParams.framesBeforeSlow:slowParams.framesBeforeSlow+slowParams.framesDuringSlow,3));
        end
    end
end
