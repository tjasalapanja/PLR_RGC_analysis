function [numbers,reorder]=findIpsiTypeNumbers(allROI,tsneContra,RQIipsi,chirpIpsi,classificationType)
    if classificationType==1
        t=chirpIpsi.clsKmeans;
    else
        t=chirpIpsi.linkagecls;
    end
    numbers=zeros(3,tsneContra.clsnumLinkage);
    ipsiType=zeros(length(allROI),1);
    for roi=1:length(allROI)
        if ismember(roi,RQIipsi)
            [~,loc]=ismember(roi,RQIipsi);
            ipsiType(roi)=t(loc);
        end
    end
    for c=1:tsneContra.clsnumLinkage
        all=find(tsneContra.linkagecls==c);
        allType=ipsiType(all);
        numbers(2,c)=length(find(allType==1));
        numbers(3,c)=length(find(allType==2));
        numbers(1,c)=length(all)-(numbers(2,c)+numbers(3,c));
    end
    % reorder bars to group by type
%     reorder=[1,2,4,3]; 
%     numbers=numbers(:,reorder);
    %cmap=[208,204,208;75,136,162;187,10,33]./255;
    cmap=[221,221,221;0,146,45;68,170,153]./255;%0,146,45
    figure('Color','w','Position',[100,100,300,400])
    tiledlayout(1,1,"TileSpacing","compact","Padding","compact")
    nexttile
    b=bar(numbers','stacked',FaceColor='flat',EdgeColor='none');
    legend({'No ipsi','Ipsi'},'FontSize',10,'Location','southoutside','NumColumns',2)
    legend box off
    for k = 1:3
        b(k).CData = cmap(k,:);
    end
    hold on
%     patchx=[0.6,3.4,3.4,0.6];
%     patchy = [520,520,523,523];
%     patch(patchx,patchy,'k','FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
%     text(1.5,565,'OFF boutons')
%     patchx=[3.6,5.4,5.4,3.6];
%     patch(patchx,patchy,'k','FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
%     text(4,565,'ON boutons')
    box off
    xlabel({'LGN bouton class'},'FontSize',10)
%     xticks([])
    ylabel('# Boutons','FontSize',10)
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
end