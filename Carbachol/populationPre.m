fail=[];
for i=1:length(highPre)
    if max(max(highPre(i).mean_flash))>30||min(min(highPre(i).mean_flash))<-30
        fail=[fail,i];
    end
end
highPre(fail)=[];
pca=lowContrastPCA(highPre);
cmap=[255,198,30;175,88,186;0,205,108]./255;
for i=1:2
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
    populationResponse(classROI,flashParams,cmap,[2],0.05,1.5,[-0.5,1.5]);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';

    nexttile(5,[3,1])
    populationResponse(classROI,flashParams,cmap,[3],0.05,1.5,[-0.5,0.5]);
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
end
