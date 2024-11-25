figure('Color','w','Position',[100,100,400,200])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(5,2,"TileSpacing","compact","Padding","compact")
% pattern
nexttile(1)
plotSeq(flashParams3)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2)
plotSeq(flashParams3)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
% contra stim
nexttile(3,[4,1])
plotOnePupil(LL3atropine,flashParams3,cmap,[-0.2,0.2],[2],0.05,1.5,0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% ipsi stim
nexttile(4,[4,1])
plotOnePupil(LL3atropine,flashParams3,cmap,[-0.2,0.2],[3],0.05,1.5,0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
xlabel('')
yticks([])
ylabel('')