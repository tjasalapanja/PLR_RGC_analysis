pcaPre=lowContrastPCA(allDataPre,4);
pcaPost=lowContrastPCA(allDataPost,4);
type=[3,1,4,2];
for i=1:4
    classPre=find(pcaPre.clsKmeans==i);
    classPost=find(pcaPost.clsKmeans==type(i));
    cmap=[255,198,30;175,88,186;0,205,108]./255;
    figure('Color','w','Position',[100,100,300,200])
    tiledlayout(1,2,'TileSpacing','compact','Padding','compact')
    nexttile
    populationResponse(allDataPre(classPre),flashParams,cmap,[2:3],0.05,1.5);
    xticks([0,5])
    yticks([0,0.5,1]) 
    title('pre TTX')
    axis off
    nexttile
    populationResponse(allDataPost(classPost),flashParams,cmap,[2:3],0.05,1.5);
    xticks([0,5])
    yticks([0,0.5,1]) 
    title('post TTX')
    axis off
end
