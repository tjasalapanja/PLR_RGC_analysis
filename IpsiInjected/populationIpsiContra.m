%% Population All
figure('color','w','Position',[100,100,600,300])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(5,2,'TileSpacing','compact','Padding','compact')
% Pattern
nexttile(1)
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2)
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

% Contra before
nexttile(3,[4,1])
populationResponse(OFFroi,flashParams,cmap,[2],0.05,1.5,[-0.1,2]);
% Ipsi before
nexttile(4,[4,1])
populationResponse(OFFroi,flashParams,cmap,[3],0.05,1.5,[-0.1,2]);
