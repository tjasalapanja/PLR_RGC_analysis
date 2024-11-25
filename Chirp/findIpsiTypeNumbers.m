function [numbers,reorder]=findIpsiTypeNumbers(allROI,tsneContra,RQIipsi,linkagecls,classificationType)
    if classificationType==1
        t=linkagecls;
    else
        t=linkagecls;
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
%     reorder=[1,2,3,5,6,4,7,8]; 
%     numbers=numbers(:,reorder);
    %cmap=[208,204,208;75,136,162;187,10,33]./255; %34,136,51  204,187,68
    cmap=[200,200,200;255,105,147;61,0,197]./255;%[0,146,45;255,193,110;0.4,0.4,0.4]./255;%[221,221,221;136,34,85;68,170,153]./255;
    figure('Color','w','Position',[100,100,400,400])%[100,100,350,400])
    tiledlayout(1,1,"TileSpacing","compact","Padding","compact")
    nexttile
    b=bar(numbers','stacked',FaceColor='flat',EdgeColor='none');
%     legend({'No ipsi','Ipsi 1','Ipsi 2'},'FontSize',10,'Location','southoutside','NumColumns',3)
%     legend box off
    for k = 1:3
        b(k).CData = cmap(k,:);
    end
    hold on
    patchx=[0.6,3.4,3.4,0.6];
    patchy = [420,420,423,423];
    patch(patchx,patchy,'k','FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
    text(1.2,435,'OFF boutons')
    patchx=[3.6,5.4,5.4,3.6];
    patch(patchx,patchy,'k','FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
    text(3.8,435,'ON boutons')
    box off
    xticks([])
    yticks([200,400])
    set(gca,'FontSize',12)
    %xlabel({'RGC bouton type'},'FontSize',11)
    ylabel('# Boutons','FontSize',12)
    numbersPart=numbers./sum(numbers);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    %figure('Color','w','Position',[100,100,600,300])
%     nexttile
%     b=bar(numbersPart','stacked',FaceColor='flat',EdgeColor='none');
%     legend({'No ipsi','Ipsi 1','Ipsi 2'},'FontSize',10,'Location','southoutside','NumColumns',3)
%     legend box off
%     for k = 1:3
%         b(k).CData = cmap(k,:);
%     end
%     hold on
% %     patchx=[0.6,3.4,3.4,0.6];
% %     patchy = [1.2,1.2,1.21,1.21];
% %     patch(patchx,patchy,'k','FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
% %     text(1.5,1.35,'OFF boutons')
% %     patchx=[3.6,5.4,5.4,3.6];
% %     patch(patchx,patchy,'k','FaceAlpha',0.7,'EdgeColor','None','HandleVisibility','off')
% %     text(4,1.35,'ON boutons')
%     box off
%     xlabel({'RGC bouton type'},'FontSize',11)
%     ylabel('% Responding','FontSize',11)
%     yticks([0.5,1])
%     yticklabels({'50','100'})
end