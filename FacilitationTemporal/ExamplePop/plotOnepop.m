function plotOnepop(ROI,slowParams,hz055)
    figure('color','w','Position',[100,100,500,300])
    % stimulusPattern
    subplot(4,1,1)
    if hz055==1
        plotSlowPattern055(slowParams)
    else
        plotSlowPattern2(slowParams)
    end
    % Population
    data=zeros(length(ROI),size(ROI(1,1).meanSlow,1),size(ROI(1,1).meanSlow,2));
    for roi=1: length(ROI(:,1))
        data(roi,:,:)=ROI(roi).meanSlow;
    end
    % create struct compatible with plotOne. called std_flash
    % because of this, but it is actually SEM
    pop.mean_Slow=zeros(size(ROI(1,1).meanSlow,1),size(ROI(1,1).meanSlow,2)); 
    pop.stdSlow=zeros(size(ROI(1,1).meanSlow,1),size(ROI(1,1).meanSlow,2));
    pop.meanSlow(:,1)=mean(data(:,:,1));
    pop.stdSlow(:,1)=std(data(:,:,1))./sqrt(length(ROI));
    pop.meanSlow(:,2)=mean(data(:,:,2));
    pop.stdSlow(:,2)=std(data(:,:,2))./sqrt(length(ROI));
    pop.meanSlow(:,3)=mean(data(:,:,3));
    pop.stdSlow(:,3)=std(data(:,:,3))./sqrt(length(ROI)); 
    maxlim=max(max(pop.meanSlow+pop.stdSlow));
    minlim=min(min(pop.meanSlow-pop.stdSlow));
    lim=[min(minlim)-0.1,max(maxlim+0.1)];
    cmap=[255,198,30;175,88,186;0,205,108]./255;
    subplot(4,1,[2,3,4])
    plotOne(pop,slowParams,cmap,lim,[1:3])% t=2
    box off
    hold on
%     peaks=0+14./15.49;
%     for i=1:12
%         xline(peaks)
%         peaks=peaks+28./15.49
%     end
end