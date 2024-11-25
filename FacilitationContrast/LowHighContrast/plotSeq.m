function plotSeq(flashParams)
    stim_before = zeros(1, flashParams.framesBeforeFlash);
    stim_during = ones(1, flashParams.framesDuringFlash); 
    stim_after = zeros(1, flashParams.framesAfterFlash);seq = [stim_before, stim_during, stim_after];
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./flashParams.FRAMERATE)-(flashParams.framesBeforeFlash./flashParams.FRAMERATE));  
    plot(seconds,seq,'LineWidth',1,'Color',[0.2,0.2,0.2])
    xlim([seconds(1),seconds(end)])
end