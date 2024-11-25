cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,400,500])
tiledlayout(9,2,'TileSpacing','tight','Padding','compact')
% Pattern
nexttile(1)
plotSeq(flashParams2)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2)
plotSeq(flashParams2)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
% example low contra
nexttile(3,[4,1])
classROI=responsesLL2(OFFcontrol{2},:);
populationResponse(classROI,flashParams2,cmap,[1:2],0.05,2);
xticks([0,5])
yticks([0,0.5,1]) 
ylim([-0.15,1.8])
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example high contra
nexttile(4,[4,1])
classROI=responsesLL5(OFFcontrol{5},:);
populationResponse(classROI,flashParams2,cmap,[1:2],0.05,2);
xticks([0,5])
yticks([0,0.5,1]) 
ylim([-0.15,1.8])
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example low both
xlabel('')
ylabel('')
nexttile(11,[4,1])
plotOnePupil(LL2,flashParams2,cmap,[-0.35,0.1],[1:2],0.02,1.5)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% example high both

nexttile(12,[4,1])
plotOnePupil(LL5,flashParams2,cmap,[-0.35,0.1],[1:2],0.02,1.5)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
xlabel('')
ylabel('')