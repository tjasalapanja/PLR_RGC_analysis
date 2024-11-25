pcaPre=lowContrastPCA(allDataPre,2);
pcaPost=lowContrastPCA(allDataPost,2);
type=[3,1,4,2];
% % 
for i=1
    classPre=find(pcaPre.clsKmeans==1);
    classPost=find(pcaPost.clsKmeans==1);
    cmap=[255,198,30;175,88,186;0,205,108]./255;
    figure('Color','w','Position',[100,100,400,600])
    tiledlayout(9,2,'TileSpacing','compact','Padding','compact')
    nexttile(1)
    plotSeq(flashParams)
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(2)
    plotSeq(flashParams)
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(3,[4,1])
    populationResponse(allDataPre(classPre),flashParams,cmap,[2],0.05,2,[-0.3,2]);
    xticks([0,5])
    ylim([-0.3,2])
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    xlabel('')
    nexttile(4,[4,1])
    populationResponse(allDataPost(classPost),flashParams,cmap,[2],0.05,2,[-0.3,2]);
    xticks([])
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    ylabel('')
    ylim([-0.3,2])
    xlabel('')
    nexttile(11,[4,1])
    populationResponse(allDataPre(classPre),flashParams,cmap,[3],0.025,2,[-0.5,2]);
    xticks([0,5])
    ylim([-0.3,0.5])
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    nexttile(12,[4,1])
    populationResponse(allDataPost(classPost),flashParams,cmap,[3],0.025,2,[-0.5,2]);
    xticks([0,5])
    ylim([-0.3,0.5])
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
end
