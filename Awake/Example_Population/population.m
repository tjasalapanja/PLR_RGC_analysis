pca=lowContrastPCA(respondingROI);
cmap=[255,198,30;175,88,186;0,205,108]./255;
for i=1:2
    class=find(pca.clsKmeans==i);
    classROI=respondingROI(class,:);
    popTog=populationResponse(classROI,flashParams,cmap,[2:3],0.05,1.5);
    xticks([0,5])
    yticks([0,0.2,0.4]) 
end
