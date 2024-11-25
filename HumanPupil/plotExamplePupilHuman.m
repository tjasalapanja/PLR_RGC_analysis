function plotExamplePupilHuman(LL,cmap,limy,types,patchRange,lines,patchVis,example,len)
    cmapPatch=[0.3,0.3,0.3];
    %stim_before = zeros(1, flashParams1.framesBeforeFlash);
    if len==1
        stim_during = ones(1, length(LL.zscoreMean(101:end))); 
    else
        stim_during = ones(1, length(LL.zscoreMean)); 
    end
    %stim_after = zeros(1, flashParams1.framesAfterFlash);
    seq = [stim_during];
    seconds = (([1:length(seq)]./20));
    hold on
    for type=types
        if len==1
            plot(seconds, LL.zscoreAll(example,101:end), 'color',cmap(type,:),'LineWidth',lines);
        else
            plot(seconds, LL.zscoreAll(example,:), 'color',cmap(type,:),'LineWidth',lines);
        end
%         seconds2 = [seconds, fliplr(seconds)];
%         areaStd= [LL.zscoreMean+LL.zscoreSem, fliplr(LL.zscoreMean-LL.zscoreSem)];
%         f_c=fill(seconds2, areaStd,cmap(type,:),'HandleVisibility','off');
%         set(f_c,'facealpha', .6, 'EdgeColor', 'none')
        hold on
    end
    xlabel('time [s]','FontSize',11)
    ylabel('size [norm]','FontSize',11)
%     xlim([-1,seconds(end)-((flashParams1.framesAfterFlash-77)./15.49)])
    lim10=(abs(limy(2)-limy(1)))*patchRange;
    %patchx=[flashParams1.framesBeforeFlash/20-flashParams1.framesBeforeFlash./20, (flashParams1.framesDuringFlash/20), (flashParams1.framesDuringFlash/20),flashParams1.framesBeforeFlash/20-flashParams1.framesBeforeFlash./20];
    %patchy = [limy(2)-lim10 limy(2)-lim10 limy(2)-2*lim10 limy(2)-2*lim10];
    if patchVis==1
        patch(patchx,patchy,cmapPatch,'FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
    end
    ylim(limy)