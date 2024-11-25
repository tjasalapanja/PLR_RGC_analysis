classdef loadData
    properties
        dffNotNorm % smoothed data with movmean window of 3
        statIsCell %Suite2p result
        spks % normalized (z-scored) spikes
    end
    methods(Static)
        %factor= how much neuropil to remove. Suite2p autors suggest 0.7
        %varargin=[start,stop] part of the recording to consider
        function obj=loadData(suite2pDataset,factor,varargin) 
            [obj.dffNotNorm, obj.statIsCell, obj.spks]=obj.getBoutonsData(suite2pDataset,factor,varargin);
        end
        function[dffNotNorm, statIsCell, spks]=getBoutonsData(suite2pDataset,factor,varargin) 
            data=load(suite2pDataset);
            F=data.F;
            Fneu=data.Fneu;
            iscell=data.iscell;
            stat=data.stat;
            spikes=data.spks;
            iscell_ROIs=length(iscell(iscell==1));
            spks=zeros(iscell_ROIs,size(F,2));
            dffIsCell = zeros(iscell_ROIs,size(F,2));
            neuIsCell = zeros(iscell_ROIs,size(F,2));
            statIsCell =cell(1,iscell_ROIs);
            count=1;
            for ROI = 1:size(F,1)
                if iscell(ROI,1)==1
                    dffIsCell(count,:)= F(ROI,:); 
                    neuIsCell(count,:) = Fneu(ROI,:);
                    statIsCell(1,count) = stat(ROI);
                    spks(count,:) = spikes(ROI,:);
                    count=count+1;
                end
            end
            % z-score spikes
            spks=normalize(spks,2);
            dffNotNorm=zeros(size(dffIsCell,1),size(dffIsCell,2));
            for ROI = 1:size(dffIsCell,1)
                dffNotNorm(ROI,:)=dffIsCell(ROI,:)-factor*(neuIsCell(ROI,:));
            end
            dffNotNorm=smoothdata(dffNotNorm,2,'movmean',3);
            if ~isempty(varargin{1})
                dffNotNorm=dffNotNorm(:,varargin{1}{1}(1):varargin{1}{1}(2));
            end
        end
    end
end