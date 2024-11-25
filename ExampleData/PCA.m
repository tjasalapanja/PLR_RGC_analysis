function kmeansplot=PCA(lowContrastPCA)
    kmeansplot=figure('Color','w','Position',[100,100,600,600]);
    figure(kmeansplot)
    cmap=[1,0,0;0,1,0;0,0,1];
    plot(lowContrastPCA.Ckmeans(:,1),lowContrastPCA.Ckmeans(:,2),'ko')
    for i=1:size(lowContrastPCA.D_PCA,1)
        c=lowContrastPCA.clsKmeans(i);
        scatter(lowContrastPCA.D_PCA(i,1),lowContrastPCA.D_PCA(i,2),25,'MarkerEdgeColor',cmap(c,:),'MarkerFaceColor',cmap(c,:),'MarkerFaceAlpha',0.5)
        axis equal
        hold on
    end
    p1=round(lowContrastPCA.percentage(1),1);
    p2=round(lowContrastPCA.percentage(2)-lowContrastPCA.percentage(1),1);
    xTitle=['PC1: ',num2str(p1),'%'];
    yTitle=['PC2: ',num2str(p2),'%'];
    xlabel(xTitle,'FontSize',12)
    ylabel(yTitle,'FontSize',12)
    xticklabels([])
    yticklabels([])
    grid off
    Title=['k-means clusters=',num2str(lowContrastPCA.clusterNumber)];
    title(Title,'FontSize',12)
    hold off
end