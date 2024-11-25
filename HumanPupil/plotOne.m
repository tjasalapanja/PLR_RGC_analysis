function plotOne(ROI,slowParams,cmap,limy,types)
    stim_before = zeros(1, slowParams.framesBeforeSlow);
    stim_during = ones(1, slowParams.framesDuringSlow); 
    stim_after = zeros(1, slowParams.framesAfterSlow);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./slowParams.FRAMERATE)-(slowParams.framesBeforeSlow./slowParams.FRAMERATE));  
    hold on
    for type=types
        plot(seconds, ROI.mean_flash(:,type), 'color',cmap(type,:),'LineWidth',1);
        seconds2 = [seconds, fliplr(seconds)];
        areaStd= [ROI.mean_flash(:,type)'+ROI.std_flash(:,type)', fliplr(ROI.mean_flash(:,type)'-ROI.std_flash(:,type)')];
        f_c=fill(seconds2, areaStd,cmap(type,:),'HandleVisibility','off');
        set(f_c,'facealpha', .3, 'EdgeColor', 'none')
        hold on
    end
    xlabel('time [s]','FontSize',11)
    ylabel('df/f','FontSize',11)
    xlim([-1,seconds(end)])
    %patchx=[flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE, (flashParams.framesDuringFlash/flashParams.FRAMERATE), (flashParams.framesDuringFlash/flashParams.FRAMERATE),flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE];
    %patchy = [limy(2)-0.05*limy(2) limy(2)-0.05*limy(2) limy(2) limy(2)];
    %patch(patchx,patchy,'k','FaceAlpha',0.4,'EdgeColor','None','HandleVisibility','off')
    ylim(limy)
end