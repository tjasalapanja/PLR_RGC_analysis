function plotOnePupil(LL,flashParams1,cmap,limy,types,patchRange,lines,patchVis)
    cmapPatch=[0.3,0.3,0.3];
    stim_before = zeros(1, flashParams1.framesBeforeFlash);
    stim_during = ones(1, flashParams1.framesDuringFlash); 
    stim_after = zeros(1, flashParams1.framesAfterFlash);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./flashParams1.FRAMERATE)-(flashParams1.framesBeforeFlash./flashParams1.FRAMERATE));
    hold on
    for type=types
        plot(seconds, LL.mean(:,type), 'color',cmap(type,:),'LineWidth',lines);
        seconds2 = [seconds, fliplr(seconds)];
        areaStd= [LL.mean(:,type)'+LL.sem(:,type)', fliplr(LL.mean(:,type)'-LL.sem(:,type)')];
        f_c=fill(seconds2, areaStd,cmap(type,:),'HandleVisibility','off');
        set(f_c,'facealpha', .6, 'EdgeColor', 'none')
        hold on
    end
    xlabel('time [s]','FontSize',11)
    ylabel('size [norm]','FontSize',11)
    xlim([-1,seconds(end)])
    lim10=(abs(limy(2)-limy(1)))*patchRange;
    patchx=[flashParams1.framesBeforeFlash/flashParams1.FRAMERATE-flashParams1.framesBeforeFlash./flashParams1.FRAMERATE, (flashParams1.framesDuringFlash/flashParams1.FRAMERATE), (flashParams1.framesDuringFlash/flashParams1.FRAMERATE),flashParams1.framesBeforeFlash/flashParams1.FRAMERATE-flashParams1.framesBeforeFlash./flashParams1.FRAMERATE];
    patchy = [limy(2)-lim10 limy(2)-lim10 limy(2)-2*lim10 limy(2)-2*lim10];
    if patchVis==1
        patch(patchx,patchy,cmapPatch,'FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
    end
    ylim(limy)