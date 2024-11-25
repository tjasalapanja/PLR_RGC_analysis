function plotOneFilled(ROI_list,chirpParams,color,lim_y,t)
    stim_before = zeros(1, chirpParams.framesBeforeChirp);
    stim_during = ones(1, chirpParams.framesDuringChirp); 
    stim_after = zeros(1, chirpParams.framesAfterChirp);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./chirpParams.FRAMERATE)-(chirpParams.framesBeforeChirp./chirpParams.FRAMERATE));  
    hold on
    for type=t
        plot(seconds, ROI_list.meanChirp(:,type)', 'color',color(type,:),'LineWidth',0.8);
        min_y=min(ROI_list.meanChirp(:,type));
        fill([seconds, fliplr(seconds)],[ROI_list.meanChirp(:,type)', min_y*ones(length(seconds),1)'], color(type,:), 'FaceAlpha', 0.6);
        hold on
    end
    xlabel('time [s]','FontSize',10)
    %ylabel('df/f','FontSize',10)
    xlim([seconds(1),seconds(end)])
    ylim(lim_y)
end