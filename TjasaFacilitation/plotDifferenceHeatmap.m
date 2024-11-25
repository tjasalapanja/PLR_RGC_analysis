function plotDifferenceHeatmap(classLow,classHigh, flashParams)
    [zscoreLow,sumDifferenceLow]=zscoreDifference(classLow, flashParams);
    [~, ind] = sort(sumDifferenceLow,'descend');
    sortedRespLow=zeros(length(classLow),size(classLow(1).mean_flash(:,:),1));
    c=1;
    for a=ind'
        sortedRespLow(c,:)=zscoreLow(a,:);
        c=c+1;
    end
    [zscoreHigh,sumDifferenceHigh]=zscoreDifference(classHigh, flashParams);
    [~, ind] = sort(sumDifferenceHigh,'descend');
    sortedRespHigh=zeros(length(classHigh),size(classHigh(1).mean_flash(:,:),1));
    c=1;
    for a=ind'
        sortedRespHigh(c,:)=zscoreHigh(a,:);
        c=c+1;
    end
    hm=figure('Color','white','Position',[100,100,600,500]);
    names={'BOTH', 'CONTRA'};
    subplot(5,2,[1,3,5,7])
    h=heatmap(sortedRespLow(:,:),'grid','off');
    map=crameri('vik');
    h.Colormap = map;
    h.ColorLimits=[-5,5];
    h.ColorbarVisible = 'off';
    Ax = gca;
    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    % Ax.Position=[1,1,200,200]
    ylabel('z score response difference')
    S = struct(h); % Undocumented
    ax = S.Axes;    % Undocumented
    col = [25, 26+77];  
    xline(ax, [col, col], 'k--','LineWidth',0.5);
    title('Low contrast')
    subplot(5,2,9)
    time=[-24:154-25]./15.49;
    plot(time,mean(sortedRespLow),'LineWidth',1,'Color',map(10,:))
    xlim([min(time),max(time)])
    ylim([-0.5,1.5])
    box off
    hold on
    xline(0,'k--','lineWidth',0.5)
    xline(5,'k--','lineWidth',0.5)
    yticks([])
    xlabel('time [s]', 'Fontsize',10)
    ylabel('mean','Fontsize',10)
    subplot(5,2,[2,4,6,8])
    h=heatmap(sortedRespHigh(:,:),'grid','off');
    map=crameri('vik');
    h.Colormap = map;
    h.ColorLimits=[-5,5];
    h.ColorbarVisible = 'on';
    Ax = gca;
    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
    % Ax.Position=[1,1,200,200]
    S = struct(h); % Undocumented
    ax = S.Axes;    % Undocumented
    col = [25, 26+77];  
    xline(ax, [col, col], 'k--','LineWidth',0.5);
    title('HighContrast')
    subplot(5,2,10)
    time=[-24:154-25]./15.49;
    plot(time,mean(sortedRespHigh),'LineWidth',1,'Color',map(10,:))
    xlim([min(time),max(time)])
    ylim([-0.5,1.5])
    box off
    hold on
    xline(0,'k--','lineWidth',0.5)
    xline(5,'k--','lineWidth',0.5)
    yticks([])
    xlabel('time [s]', 'Fontsize',10)
end