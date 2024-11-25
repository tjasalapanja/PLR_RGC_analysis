%% Plot population and pupil size
cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('color','w','Position',[100,100,200,300])
tiledlayout(2,1,"TileSpacing","tight","Padding","compact")
nexttile
classROI=atropineLL2(OFFatropine{2},:);
populationResponse(classROI,flashParams2,cmap,[1:2],0.05,1.5);
xticks([0,5])
yticks([0,0.5,1]) 
ylim([-0.15,1.8])
axis off
nexttile
% LL2.SEM=std(LL2.allTraces,0,2)./5;
plotOnePupil(LL2atropine,flashParams2,cmap,[-0.1,0.1],[1:2],0.02,1.5)
axis off