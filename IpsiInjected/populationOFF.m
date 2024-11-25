pca=lowContrastPCA(allROI,2);
cmap=[255,198,30;175,88,186;0,205,108]./255;
OFFroi=[];
for i=1:2
    figure('Color','w','Position',[100,100,200,600]);
    class=find(pca.clsKmeans==i);
    classROI=allROI(class,:);
    tiledlayout(7,1,"TileSpacing","compact","Padding","compact")
    nexttile
    plotSeq(flashParams)
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(2,[3,1])
    populationResponse(classROI,flashParams,cmap,[2],0.05,1.5,[-0.4,2]);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';

    nexttile(5,[3,1])
    populationResponse(classROI,flashParams,cmap,[3],0.05,1.5,[-0.4,2]);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
if i==1
    OFFroi=[OFFroi;classROI];
end
end
figure() 
populationResponse(OFFroi,flashParams,cmap,[1:3],0.05,1.5,[-0.5,2]);