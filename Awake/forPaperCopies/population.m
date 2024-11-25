pca=lowContrastPCA(respondingAll);
cmap=[255,198,30;175,88,186;0,205,108]./255;
for i=2
    figure('Color','w','Position',[100,100,250,400]);%200 600
    class=find(pca.clsKmeans==i);
    classROI=respondingAll(class,:);
    tiledlayout(5,1,"TileSpacing","compact","Padding","compact")
    nexttile
    plotSeq(flashParams)
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(2,[4,1])
    populationResponse(classROI,flashParams,cmap,[2:3],0.05,1.5);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
% 
%     nexttile(5,[3,1])
%     populationResponse(classROI,flashParams,cmap,[3],0.05,1.5);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
end
