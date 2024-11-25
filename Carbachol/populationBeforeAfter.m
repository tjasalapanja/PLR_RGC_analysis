%% Population All
figure('color','w','Position',[100,100,600,600])
cmap=[255,198,30;175,88,186;0,205,108]./255;
tiledlayout(9,2,'TileSpacing','compact','Padding','compact')
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
populationResponse(OFFroiHigh,flashParams,cmap,[2],0.05,1.5,[-0.5,1.2]);
% Ipsi before
nexttile(4,[4,1])
populationResponse(OFFroiHigh,flashParams,cmap,[3],0.05,1.5,[-0.25,0.25]);
% Contra After
nexttile(11,[4,1])
populationResponse(OFFroiHighPost,flashParams,cmap,[2],0.05,1.5,[-0.5,1.2]);
% Ipsi After
nexttile(12,[4,1])
populationResponse(OFFroiHighPost,flashParams,cmap,[3],0.05,1.5,[-0.25,0.25]);
