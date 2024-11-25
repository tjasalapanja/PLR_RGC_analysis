function plotOne(ROI_list,slowParams,color,lim_y,t)
    stim_before = zeros(1, slowParams.framesBeforeSlow);
    stim_during = ones(1, slowParams.framesDuringSlow); 
    stim_after = zeros(1, slowParams.framesAfterSlow);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./slowParams.FRAMERATE)-(slowParams.framesBeforeSlow./slowParams.FRAMERATE));  
    hold on
    for type=t
        plot(seconds, ROI_list.meanSlow(:,type), 'color',color(type,:),'LineWidth',1.5);
        seconds2 = [seconds, fliplr(seconds)];
       
        areaStd= [ROI_list.meanSlow(:,type)'+ROI_list.stdSlow(:,type)', fliplr(ROI_list.meanSlow(:,type)'-ROI_list.stdSlow(:,type)')];
        f_c=fill(seconds2, areaStd,color(type,:),'HandleVisibility','off');
        set(f_c,'facealpha', .4, 'EdgeColor', 'none')
        hold on
    end
    xlabel('time [s]','FontSize',10)
    %ylabel('df/f','FontSize',10)
    xlim([seconds(1),seconds(end)])
    ylim(lim_y)
end