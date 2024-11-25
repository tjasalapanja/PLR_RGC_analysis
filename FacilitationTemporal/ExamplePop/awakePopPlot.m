figure('Color','w','Position',[100,100,600,700])
tiledlayout(5,2,"TileSpacing","compact","Padding","compact")
nexttile(1,[2,1])
plotOnepopAwake(allROI2Hz,slowParams2Hz)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2,[2,1])
plotOnepopAwake(allROI055Hz,slowParams055Hz)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(5,[2,1])
plotOneSEM(allROI2Hz(160),slowParams2Hz,cmap,[-0.8,2.1],[1:2])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(6,[2,1])
plotOneSEM(allROI055Hz(165),slowParams055Hz,cmap,[-0.8,2.1],[1:2])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(9,[1,1])
plotSlowPattern2(slowParams2Hz)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(10,[1,1])
plotSlowPattern055(slowParams055Hz)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
count=count+1;
