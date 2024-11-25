figure('color','w','Position',[100,100,600,300])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(5,2,"TileSpacing","compact","Padding","compact")
nexttile
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile([4,1])
populationOne(offROI,flashParams,cmap,[2],[-0.2,1.2])
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% xline(0,'--k')
% xline(5,'--k')
nexttile([4,1])
populationOne(offROI,flashParams,cmap,[3],[-0.2,1.2])
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% xline(0,'--k')
% xline(5,'--k')