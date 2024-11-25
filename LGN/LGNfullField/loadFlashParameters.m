classdef loadFlashParameters % Analysis of synchronization file. Length, timing and number of flashes. Frames during hardcoded to 77. uncoment to change
    properties
        flashStart %Frames when stimulus started
        flashStop %Frames when stimulus stopped
        stimLED %String of 0s and 1s, indicating the stimulus pattern
        framesBeforeFlash % Number of frames before stimulation to be included (same length as the stimulus)
        framesDuringFlash % Stimulus length
        framesAfterFlash % Number of frames after stimulus to be included (twice the stimulus length)
        framesTotal % sum of before, during and after
        numFlashes % number of flashes. If the first flash happened to early to have before flash info 
                   % first flash start and stop for each type is excluded and numFlashes for one lower  
        FRAMERATE % 15.49fps
    end
    methods
        function obj=loadFlashParameters(recLength,syncDataset,ipsi,varargin)
            %recLength= number of frames in the recording
            %syncDataset= path so sync data
            %ipsi= True if ipsi stimulation is included
            %Varargin: 1: flashes to include (vector length of 2, first to last included sync data (automatic [1,24]))
            %          2: number of flashes (automatic 6)
            [obj.flashStart,...
                  obj.flashStop,...
                  obj.stimLED,...
                  obj.framesBeforeFlash,...
                  obj.framesDuringFlash,...
                  obj.framesAfterFlash,...
                  obj.framesTotal,...
                  obj.numFlashes,...
                  obj.FRAMERATE]=obj.getFlashParams(recLength,syncDataset,ipsi,varargin);
        end
        function [flashStart,...
                  flashStop,...
                  stimLED,...
                  framesBeforeFlash,...
                  framesDuringFlash,...
                  framesAfterFlash,...
                  framesTotal,...
                  numFlashes,...
                  FRAMERATE]=getFlashParams(~,recLength,syncDataset,ipsi,varargin)
            if size(varargin{1},2)<2
                numFlashes=5;
            else
                numFlashes=varargin{1}{2};
            end
            if ipsi==1
                flashTypes=3;
            else
                flashTypes=2;
            end
            if isempty(varargin{1})
                flashes=[1,2*numFlashes*flashTypes];
            else
                flashes=varargin{1}{1};
            end
            s=load(syncDataset); 
            sync=s.info.frame;
            sync=unique(sync);
            %sync(sync<1000)=[];
            if sync(1)==0
                sync(1)=[];
            end
            flashStart=sync(flashes(1):2:flashes(2));
            flashStop=sync(flashes(1)+1:2:flashes(2));
            %Create a string length of dff frames with 0 when stim OFF and 
            %1 when stim ON
            stimLED = zeros(1,recLength);
            for stim = 1:length(flashStart)
                if flashStart(stim)==0
                    stimLED(1,flashStart(stim)+1:flashStop(stim)-1)=1;
                else
                    stimLED(1,flashStart(stim):flashStop(stim)-1)=1;
                end
            end
            framesBeforeFlash =floor(77/2); %floor(flashStop(2)-flashStart(2));
            framesDuringFlash = 77; %flashStop(2)-flashStart(2);
            framesAfterFlash  = 77; %floor((flashStop(2)-flashStart(2))*2);
            framesTotal = ...
                framesBeforeFlash + ...
                framesDuringFlash + ...
                framesAfterFlash;
            % If first flash is too close to the begining of the recording
            % exclude first flash of each category (both, contra, ipsi)
            if flashStart(1)<framesBeforeFlash
               numFlashes = numFlashes-1;
               flashStart(1:flashTypes)=[];
               flashStop(1:flashTypes)=[];
            end
            FRAMERATE=15.49; 
        end  
    end
end