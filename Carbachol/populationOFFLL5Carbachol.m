pca=lowContrastPCA(highPre,2);
cmap=[255,198,30;175,88,186;0,205,108]./255;
OFFroiHigh=[];
for i=1:4
    figure('Color','w','Position',[100,100,200,600]);
    class=find(pca.clsKmeans==i);
    classROI=highPre(class,:);
    tiledlayout(7,1,"TileSpacing","compact","Padding","compact")
    nexttile
    plotSeq(flashParams)
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(2,[3,1])
    populationResponse(classROI,flashParams,cmap,[1],0.05,1.5,[-0.4,2]);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';

    nexttile(5,[3,1])
    populationResponse(classROI,flashParams,cmap,[2],0.05,1.5,[-0.4,2]);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
if i==2||i==3
    OFFroiHigh=[OFFroiHigh;classROI];
end
end
figure() 
populationResponse(OFFroiHigh,flashParams,cmap,[1:2],0.05,1.5,[-0.5,2]);