%% Plot Same Bouton 2Hz and 055Hz
% Candidates:4,10,12,14,25,41,93,65,62,53,124,101,159,213
cmap=[255,198,30;175,88,186;0,205,108]./255;
limits=[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]-1;
limits2=[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]-1.7;
count=1;
for candidate=[82 152 154 165]%[4,10,12,14,25,41,93,65,62,53,124,101,159,213]% Awake 82 152 154 165
figure('Color','w','Position',[100,100,700,400])
tiledlayout(4,2,"TileSpacing","compact","Padding","compact")
nexttile(1,[3,1])
plotOne(allROI2Hz(candidate),slowParams2Hz,cmap,[-0.7,limits2(count)],[1:2])
% title('2 Hz')
axis off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(2,[3,1])
plotOne(allROI055Hz(candidate),slowParams055Hz,cmap,[-0.7,limits(count)],[1:2])
% yticks([])
% title('0.55 Hz')
axis off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(7,[1,1])
plotSlowPattern2(slowParams2Hz)
axis off
nexttile(8,[1,1])
plotSlowPattern055(slowParams055Hz)
axis off
count=count+1;
end