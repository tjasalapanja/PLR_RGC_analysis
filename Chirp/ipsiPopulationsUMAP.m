function linkagecls=ipsiPopulationsUMAP(ipsi,chirpParams,NumNeighbors) 
    for i=1:length(ipsi)
        meanChirp(i,:)=ipsi(i).meanChirp(chirpParams.framesBeforeChirp+1:chirpParams.framesBeforeChirp+chirpParams.framesDuringChirp,3);
    end
    difference=normalize(meanChirp,2); % returns the vectorwise z-score of the data in A with center 0 and standard deviation 1
    ParameterNames={};
    for i=1:size(difference,2)
        ParameterNames{i}=num2str(i);
    end
    rng(0);UMAPmatrix=run_umap(difference,'parameter_names',ParameterNames,'n_neighbors',NumNeighbors);
    rng(0);eval=evalclusters(UMAPmatrix,'linkage','silhouette','klist',1:30);
    clsnumLinkage=eval.OptimalK;
    rng(0);linkagecls=clusterdata(UMAPmatrix,'linkage','ward',clsnumLinkage);
    figure('Color','w','Position',[100,100,800,400])
    %subplot(5,6,[1,2,7,8,13,14,19,20,25,26])
    tiledlayout(5,10,"TileSpacing","compact","Padding","compact")
    nexttile(1,[5,5])
%     cmap=crameri('bukavu',10);
%     color=cmap([4,8],:);
    color=[255,105,147;61,0,197;0.4,0.4,0.4]./255;%[68,170,153;136,34,85;0.5,0.5,0.5]./255;
    sz=40;
    for class=1:clsnumLinkage
        cls=find(linkagecls==class);
        subtsne=UMAPmatrix(cls,:);
        scatter(subtsne(:,1),subtsne(:,2),sz,color(class,:),'filled','MarkerFaceAlpha',0.3)
        hold on
    end
    xticklabels('')
    yticklabels('')
%     xticks([])
%     yticks([])
%     xlim([-25,5])
%     ylim([-10,10])
    xlabel('UMAP-X','FontSize',11)
    ylabel('UMAP-Y','FontSize',11)
        ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
    nexttile(6,[1,5])
%     subplot(5,6,[3:6])
    plotPattern(1)
    yticklabels({''})
    yticks([])
        ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
%     subplot(5,6,[9:12,15:18])
    nexttile(16,[2,5])
    class=find(linkagecls==2);
    classROI=ipsi(class,:);
    data=zeros(length(classROI),size(classROI(1,1).meanChirp,1),size(classROI(1,1).meanChirp,2));
    for roi=1: length(classROI(:,1))
        data(roi,:,:)=classROI(roi).meanChirp;
    end
    pop.mean_Chirp=zeros(size(classROI(1,1).meanChirp,1),1); 
    pop.stdChirp=zeros(size(classROI(1,1).meanChirp,1),1);
    pop.meanChirp(:)=mean(data(:,:,3));
    pop.stdChirp(:)=std(data(:,:,3))./sqrt(length(classROI)); 
    maxlim=max(max(pop.meanChirp+pop.stdChirp));
    minlim=min(min(pop.meanChirp-pop.stdChirp));
    lim=[min(minlim)-0.1,max(maxlim+0.1)];
        stim_before = zeros(1, chirpParams.framesBeforeChirp);
    stim_during = ones(1, chirpParams.framesDuringChirp); 
    stim_after = zeros(1, chirpParams.framesAfterChirp);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./chirpParams.FRAMERATE)-(chirpParams.framesBeforeChirp./chirpParams.FRAMERATE));  
    hold on
    plot(seconds, pop.meanChirp(:), 'color',color(2,:),'LineWidth',1.5);
    seconds2 = [seconds, fliplr(seconds)];
    areaStd= [pop.meanChirp(:)'+pop.stdChirp(:)', fliplr(pop.meanChirp(:)'-pop.stdChirp(:)')];
    f_c=fill(seconds2, areaStd,color(2,:),'HandleVisibility','off');
    set(f_c,'facealpha', .5, 'EdgeColor', 'none')
    hold on
    xticklabels({''})
    xticks([])
    ylabel('dF/F','FontSize',12)
    xlim([seconds(1),seconds(end)])
    ylim(lim)
    box off
        ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
%     subplot(5,6,[21:24,27:30])
    nexttile(36,[2,5])
    class=find(linkagecls==1);
    classROI=ipsi(class,:);
    data=zeros(length(classROI),size(classROI(1,1).meanChirp,1),size(classROI(1,1).meanChirp,2));
    for roi=1: length(classROI(:,1))
        data(roi,:,:)=classROI(roi).meanChirp;
    end
    pop.mean_Chirp=zeros(size(classROI(1,1).meanChirp,1),1); 
    pop.stdChirp=zeros(size(classROI(1,1).meanChirp,1),1);
    pop.meanChirp(:)=mean(data(:,:,3));
    pop.stdChirp(:)=std(data(:,:,3))./sqrt(length(classROI)); 
    maxlim=max(max(pop.meanChirp+pop.stdChirp));
    minlim=min(min(pop.meanChirp-pop.stdChirp));
    lim=[min(minlim)-0.1,max(maxlim+0.1)];
        stim_before = zeros(1, chirpParams.framesBeforeChirp);
    stim_during = ones(1, chirpParams.framesDuringChirp); 
    stim_after = zeros(1, chirpParams.framesAfterChirp);
    seq = [stim_before, stim_during, stim_after];
    seconds = (([1:length(seq)]./chirpParams.FRAMERATE)-(chirpParams.framesBeforeChirp./chirpParams.FRAMERATE));  
    hold on
    plot(seconds, pop.meanChirp(:), 'color',color(1,:),'LineWidth',1.5);
    seconds2 = [seconds, fliplr(seconds)];
    areaStd= [pop.meanChirp(:)'+pop.stdChirp(:)', fliplr(pop.meanChirp(:)'-pop.stdChirp(:)')];
    f_c=fill(seconds2, areaStd,color(1,:),'HandleVisibility','off');
    set(f_c,'facealpha', .5, 'EdgeColor', 'none')
    hold on
    xlabel('time [s]','FontSize',12)
    ylabel('dF/F','FontSize',12)
    xlim([seconds(1),seconds(end)])
    ylim(lim)
    box off
        ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
end
