function timeHistogram(ipsiTimeAwake,ipsiTimeAnasthetized,flashParams,type)
    cmap=[0,154,222;255,198,30;175,88,186;255,31,91;242,133,42]./255;
    %figure('Color','w','Position',[100,100,300,300])
%     subplot(2,1,1)
    h=histogram(ipsiTimeAnasthetized(:,type),[0:3:150],'FaceColor',cmap(1,:),'EdgeAlpha',0.7)
%     [~,V] = max(h.Values);
%     E = h.BinEdges;
%     maximalAna=E(V)+1;
%     maximalAnaTime=maximalAna./15.49;
%     xline(maximalAna,'k','LineWidth',1)
    hold on
    h=histogram(ipsiTimeAwake(:,type),[0:3:150],'FaceColor',cmap(4,:),'EdgeAlpha',0.7)
%     [~,V] = max(h.Values);
%     E = h.BinEdges;
%     maximalAwake=E(V)+2.5;
%     maximalAwakeTime=maximalAwake./15.49;
%     xline(maximalAwake,'r','LineWidth',1)
    xticks([0,5*15.49])
    xticklabels([0,5])
%     patchx=[flashParams.framesBeforeFlash-flashParams.framesBeforeFlash, (flashParams.framesDuringFlash), (flashParams.framesDuringFlash),flashParams.framesBeforeFlash-flashParams.framesBeforeFlash];
    if type ==2
        l=55;
    else
        l=45;
    end
%     patchy = [l-0.05*l,l-0.05*l,l,l];
%     patch(patchx,patchy,'k','FaceAlpha',0.3,'EdgeColor','None','HandleVisibility','off')
    ylim([0,l])
    xlim([-5,135])
    %yticks([10,20,30])
%     ylabel('# Boutons')
%     xlabel('time [s]')
%     legend({'Anasthetized','Awake'},'FontSize',10,'Location','east')
%     legend box off
    box off
    set(gca,'FontSize',10)
%     subplot(2,1,2)
%     histogram(ipsiHeightAnasthetized,[0:0.05:3],'FaceColor',cmap(8,:),'EdgeAlpha',0.7)
%     hold on
%     histogram(ipsiHeightAwake,[0:0.05:3],'FaceColor',cmap(3,:),'EdgeAlpha',0.7)
%     xlim([0,3])
%     ylabel('# Boutons')
%     xlabel('max dF/F')
%     box off
%     set(gca,'FontSize',10)
end