cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,600,250])
tiledlayout(1,35,"TileSpacing","tight",'Padding','compact')
nexttile(1,[1,10])
plotOnePupil(pupil2,flashParams2,cmap,[-0.2,0.12],[1:3],0.02,1.5,1)
xlabel('')
ylabel('')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(11,[1,25])
plotOnePupil(pupil055,flashParams055,cmap,[-0.2,0.12],[1:3],0.02,1.5,1)
xlabel('')
yticks([])
ylabel('')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';