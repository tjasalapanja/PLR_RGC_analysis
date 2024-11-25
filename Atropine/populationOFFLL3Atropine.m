pca=lowContrastPCA(atropineLL3,5);
cmap=[255,198,30;175,88,186;0,205,108]./255;
OFFroi=[];
for i=1:5
    figure('Color','w','Position',[100,100,200,600]);
    class=find(pca.clsKmeans==i);
    classROI=atropineLL3(class,:);
    tiledlayout(7,1,"TileSpacing","compact","Padding","compact")
    nexttile
    plotSeq(flashParams3)
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(2,[3,1])
    populationResponse(classROI,flashParams3,cmap,[2],0.05,1.5);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';

    nexttile(5,[3,1])
    populationResponse(classROI,flashParams3,cmap,[3],0.05,1.5);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
if i==5|| i==4
    OFFroi=[OFFroi;classROI];
end
end
figure() 
populationResponse(OFFroi,flashParams3,cmap,[2:3],0.05,1.5);