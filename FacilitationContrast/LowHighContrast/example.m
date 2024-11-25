for i=142 % Animal PM_230224_OBO041195_pupilControl
% Plot example contra example both difference heatmap
cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,400,600])
tiledlayout(9,2,'TileSpacing','tight','Padding','compact')
% Pattern
nexttile(1)
plotSeq(flashParams2)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
nexttile(2)
plotSeq(flashParams2)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example low contra
nexttile(3,[4,1])
plotOne(allROI(i,2),flashParams2,cmap,[-0.45,1.2],[2],0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example high contra
nexttile(4,[4,1])
plotOne(allROI(i,5),flashParams5,cmap,[-0.45,1.2],[2],0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example low both
nexttile(11,[4,1])
plotOne(allROI(i,2),flashParams2,cmap,[-0.45,1.2],[1],0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example high both
nexttile(12,[4,1])
plotOne(allROI(i,5),flashParams5,cmap,[-0.45,1.2],[1],0)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
end