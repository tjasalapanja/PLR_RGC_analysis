classdef loadSlowParameters % Analysis of synchronization file. Length, timing and number of flashes. Frames during hardcoded to 77. uncoment to change
    properties
        slowStart %Frames when stimulus started
        slowStop %Frames when stimulus stopped
        stimulus %String of 0s and 1s, indicating the stimulus pattern
        framesBeforeSlow % Number of frames before stimulation to be included (same length as the stimulus)
        framesDuringSlow % Stimulus length
        framesAfterSlow % Number of frames after stimulus to be included (twice the stimulus length)
        framesTotal % sum of before, during and after
        numSlow % number of flashes. If the first flash happened to early to have before flash info 
                   % first flash start and stop for each type is excluded and numFlashes for one lower  
        FRAMERATE % 15.49fps
    end
    methods
        function obj=loadSlowParameters(recLength,syncDataset,varargin)
            %recLength= number of frames in the recording
            %syncDataset= path so sync data
            %ipsi= True if ipsi stimulation is included
            %Varargin: 1: flashes to include (vector length of 2, first to last included sync data (automatic [1,24]))
            %          2: number of flashes (automatic 6)
            [obj.slowStart,...
                  obj.slowStop,...
                  obj.stimulus,...
                  obj.framesBeforeSlow,...
                  obj.framesDuringSlow,...
                  obj.framesAfterSlow,...
                  obj.framesTotal,...
                  obj.numSlow,...
                  obj.FRAMERATE]=obj.getSlowParams(recLength,syncDataset,varargin);
        end
        function [slowStart,...
                  slowStop,...
                  stimulus,...
                  framesBeforeSlow,...
                  framesDuringSlow,...
                  framesAfterSlow,...
                  framesTotal,...
                  numSlow,...
                  FRAMERATE]=getSlowParams(~,recLength,syncDataset,varargin)
            if size(varargin{1},2)<2
                numSlow=5;
            else
                numSlow=varargin{1}{2};
            end
            slowTypes=3;
            if isempty(varargin{1})
                slow=[1,2*numSlow*slowTypes];
            else
                slow=cell2mat(varargin{1}{1});
            end
            s=load(syncDataset); 
            sync=s.info.frame;
            sync=unique(sync);
            %sync(sync<1000)=[];
            if sync(1)==0
                sync(1)=[];
            end
            slowStart=sync(slow(1):2:slow(2));
            slowStop=sync(slow(1)+1:2:slow(2));
            %Create a string length of dff frames with 0 when stim OFF and 
            %1 when stim ON
            stimulus = zeros(1,recLength);
            for stim = 1:length(slowStart)
                if slowStart(stim)==0
                    stimulus(1,slowStart(stim)+1:slowStop(stim)-1)=1;
                else
                    stimulus(1,slowStart(stim):slowStop(stim)-1)=1;
                end
            end
            framesBeforeSlow =floor((slowStart(3)-slowStop(2))/2);
            framesDuringSlow =slowStop(2)-slowStart(2);
            framesAfterSlow  =ceil((slowStart(3)-slowStop(2))/2);
            framesTotal = ...
                framesBeforeSlow + ...
                framesDuringSlow + ...
                framesAfterSlow;
            % If first flash is too close to the begining of the recording
            % exclude first flash of each category (both, contra, ipsi)
            if slowStart(1)<framesBeforeSlow
               numSlow = numSlow-1;
               slowStart(1:slowTypes)=[];
               slowStop(1:slowTypes)=[];
            end
            FRAMERATE=15.49; 
        end  
    end
end