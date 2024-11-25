figure('color','w','Position',[100,100,400,600])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(9,2,"TileSpacing","tight","Padding","tight")

%pattern
nexttile(1,[1,1])
plotSeq(flashParams3)
ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

nexttile(2,[1,1])
plotSeq(flashParams3)
ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

%pupilContra
nexttile(3,[4,1])
plotOnePupil(LL3,flashParams3,cmap,[-0.45,0.1],[2],0.05,1.5,0)
ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

%pupilIpsi
nexttile(4,[4,1])
plotOnePupil(LL3,flashParams3,cmap,[-0.18,0.08],[3],0.05,1.5,0)
ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

%popContra
nexttile(11,[4,1])
populationOne(OFFroi,flashParams3,cmap,[2],[-0.3,2])
ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

%popIpsi
nexttile(12,[4,1])
populationOne(OFFroi,flashParams3,cmap,[3],[-0.3,2])
ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';