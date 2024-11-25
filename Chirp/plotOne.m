function plotOne(ROI_list,chirpParams,color,lim_y,t)
    stim_before = zeros(1, chirpParams.framesBeforeChirp);
    stim_during = ones(1, chirpParams.framesDuringChirp); 
    stim_after = zeros(1, chirpParams.framesAfterChirp);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./chirpParams.FRAMERATE)-(chirpParams.framesBeforeChirp./chirpParams.FRAMERATE));  
    hold on
    for type=t
        plot(seconds, ROI_list.meanChirp(:,type)', 'color',color(type,:),'LineWidth',0.8);
        seconds2 = [seconds, fliplr(seconds)];
         areaStd= [ROI_list.meanChirp(:,type)'+ROI_list.stdChirp(:,type)'./sqrt(5), fliplr(ROI_list.meanChirp(:,type)'-ROI_list.stdChirp(:,type)'./sqrt(5))];
         f_c=fill(seconds2, areaStd,color(type,:),'HandleVisibility','off');
        set(f_c,'facealpha', .3, 'EdgeColor', 'none')
        hold on
    end
    xlabel('time [s]','FontSize',10)
    %ylabel('df/f','FontSize',10)
    xlim([seconds(1),seconds(end)])
    ylim(lim_y)
end