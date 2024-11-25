function thesisOnlyMeansPlotFilled(allROI,chirpParams,chirpClass)
    limitsExContra=[-0.8,5;-0.8,5.5;-0.8,4;-0.8,4;-0.8,4];
    limitsExIpsi=[-0.8,4.5;-0.8,3.5;-0.8,2.5;-0.8,1.5;-0.8,1];
    limitsPopContra=[-0.5,2;-1,2;-0.5,2;-0.5,2;-0.5,1.5];
    limitsPopIpsi=[-0.5,1.2;-0.5,1.2;-0.5,1.8;-0.2,0.5;-0.3,0.3];
    figure('Color','w','Position',[100,100,500,650])
    tiledlayout(11,2, 'Padding', 'tight', 'TileSpacing', 'tight')
    nexttile
    plotPattern(1)
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
    nexttile
    plotPattern(1)
    stim_before = zeros(1, chirpParams.framesBeforeChirp);
    stim_during = ones(1, chirpParams.framesDuringChirp); 
    stim_after = zeros(1, chirpParams.framesAfterChirp);
    seq = [stim_before, stim_during, stim_after];
    color=[0,101,146;0,154,222;44,255,215;210,0,56;255,109,148]./255;%[68,119,170;102,204,238;34,136,51;204,187,68;170,51,119]./255;
    p=color*0.7;
    colorDark=0.1+p;
%     colorDark=crameri('hawaii',6);
    plotOrder=[3,7,11,15,19];
    seconds = (([1:length(seq)]./chirpParams.FRAMERATE)-(chirpParams.framesBeforeChirp./chirpParams.FRAMERATE));
    listOfROI=[1,1,8,101,2];
    for c=1:5
        colorToUse=[colorDark(c,:);colorDark(c,:);colorDark(c,:)];
        classList=find(chirpClass.linkagecls==c);
        allClass=zeros(length(classList),size(allROI(1).meanChirp,1),3);
        for i=1:length(classList)
            allClass(i,:,:)=allROI(classList(i)).meanChirp(:,[1:3]);    
        end
        % create struct compatible with plotOne. called std_flash
        % because of this, but it is actually SEM
        pop.meanChirp=zeros(size(allClass,2),size(allClass,3)); 
        pop.stdChirp=zeros(size(allClass,2),size(allClass,3));
        pop.meanChirp(:,1)=mean(allClass(:,:,1));
        pop.stdChirp(:,1)=std(allClass(:,:,1))./sqrt(length(classList));
        pop.meanChirp(:,2)=mean(allClass(:,:,2));
        pop.stdChirp(:,2)=std(allClass(:,:,2))./sqrt(length(classList));
        pop.meanChirp(:,3)=mean(allClass(:,:,3));
        pop.stdChirp(:,3)=std(allClass(:,:,3))./sqrt(length(classList)); 
        maxlim=max(max(pop.meanChirp+pop.stdChirp));
        minlim=min(min(pop.meanChirp-pop.stdChirp));
        ax=gca;
        ax.Color='w';
        ax.YColor = 'w';
        ax.XColor ='w';


        nexttile(plotOrder(c),[2,1])
        plotOneFilled(pop,chirpParams,colorToUse,limitsPopContra(c,:),2)% t=2
        xlim([seconds(1),seconds(end)])
        yticks([0,limitsPopContra(c,2)])
        xlabel('')
        box off
        if c~=5
            xticks([])
        end
        hold on
        ax=gca;
        ax.Color='w';
        ax.YColor = 'w';
        ax.XColor ='w';

        nexttile(plotOrder(c)+1,[2,1])
        plotOneFilled(pop,chirpParams,colorToUse,limitsPopIpsi(c,:),3)% t=2
        hold on
        xlim([seconds(1),seconds(end)])
        set(gca,'FontSize',9)
        yticks([0,limitsPopIpsi(c,2)])
        if c~=5
            xticks([])
        end
        xlabel('')
        ax=gca;
        ax.Color='w';
        ax.YColor = 'w';
        ax.XColor ='w';
        box off
    end
end