function plotOneSEM(ROI,flashParams,cmap,limy,types,patchRange,i)
    cmapPatch=zeros(5,3);%crameri('vanimo',5);
    selection=[2,4];
    stim_before = zeros(1, flashParams.framesBeforeFlash);
    stim_during = ones(1, flashParams.framesDuringFlash); 
    stim_after = zeros(1, flashParams.framesAfterFlash);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./flashParams.FRAMERATE)-(flashParams.framesBeforeFlash./flashParams.FRAMERATE));  
    SEM=ROI.std_flash./sqrt(5);
    hold on
    for type=types
        plot(seconds, ROI.mean_flash(:,type), 'color',cmap(type,:),'LineWidth',1);
        seconds2 = [seconds, fliplr(seconds)];
        areaStd= [ROI.mean_flash(:,type)'+SEM(:,type)', fliplr(ROI.mean_flash(:,type)'-SEM(:,type)')];
        f_c=fill(seconds2, areaStd,cmap(type,:),'HandleVisibility','off');
        set(f_c,'facealpha', .3, 'EdgeColor', 'none')
        hold on
    end
    xlabel('time [s]','FontSize',11)
    ylabel('df/f','FontSize',11)
    xlim([-1,seconds(end)])
    lim10=(abs(limy(2)-limy(1)))*patchRange;
    patchx=[flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE, (flashParams.framesDuringFlash/flashParams.FRAMERATE), (flashParams.framesDuringFlash/flashParams.FRAMERATE),flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE];
    patchy = [limy(1)+lim10 limy(1)+lim10 limy(1)+2*lim10 limy(1)+2*lim10];
    patch(patchx,patchy,cmapPatch(selection(i),:),'FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
    ylim(limy)
end