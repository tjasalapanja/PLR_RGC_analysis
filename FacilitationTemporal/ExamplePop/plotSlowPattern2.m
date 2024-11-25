function plotSlowPattern2(slowParams)
    %47 frames between 2 peaks 
    g1=zeros(1,ceil(slowParams.framesBeforeSlow*60/15.5));
    g2=zeros(1,ceil(slowParams.framesAfterSlow*60/15.5));
    times = linspace(0, 6, slowParams.framesDuringSlow*60/15.5);  
    scale=times/2;
    scaledIntensity=[];
    for i =1:length(times)
        intensities=sin(12*times(i));
        scaledIntensity=[scaledIntensity,intensities*scale(i)];
    end
    fullTrace=[g1,scaledIntensity,g2];
    plot(fullTrace,'color', [0.3,0.3,0.3])
    xlim([0,length(fullTrace)])
    xticks([])
    ylim([min(scaledIntensity),max(scaledIntensity)])
    yticks([])
%     yticklabels({'black','gray','white'})
    box off
    ax = gca;
    ax.FontSize = 12;
%     onePeak=299;
%     allPeaks=onePeak;
    hold on
%     for i=1:16
%         xline(onePeak)
%         onePeak=onePeak+82.4;
%         allPeaks=[allPeaks,onePeak];
%     end
%     allPeaks=(allPeaks./60);
end
