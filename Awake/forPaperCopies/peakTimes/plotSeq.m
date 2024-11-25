function plotSeq(flashParams)
    stim_before = zeros(1, 8)%flashParams.framesBeforeFlash);
    stim_during = ones(1, 77)%flashParams.framesDuringFlash); 
    stim_after = zeros(1, 130-86)%flashParams.framesAfterFlash);seq = [stim_before, stim_during, stim_after];
    seq = [stim_before, stim_during, stim_after];
%     seconds = (([1:length(seq)]./flashParams.FRAMERATE)-(flashParams.framesBeforeFlash./flashParams.FRAMERATE));  
    plot(seq,'LineWidth',1.5,'Color',[0.2,0.2,0.2])
xlim([0,130])
end