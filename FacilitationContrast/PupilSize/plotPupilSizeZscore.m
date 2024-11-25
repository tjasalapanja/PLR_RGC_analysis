% [LL1.mean,LL1.poolSD]=findPoolMean(goodPupilLL1);
% [LL2.mean,LL2.poolSD]=findPoolMean(goodPupilLL2);
% [LL3.mean,LL3.poolSD]=findPoolMean(goodPupilLL3);
% [LL4.mean,LL4.poolSD]=findPoolMean(goodPupilLL4);
% [LL5.mean,LL5.poolSD]=findPoolMean(goodPupilLL5);
%% Plot all together
cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,800,300])
tiledlayout(1,5,'TileSpacing','compact','Padding','compact')
LightLevels={LL1,LL2,LL3,LL4,LL5};
for i=[1,2,3,4,5]%[2,4,3,1,5]%[4,1,3,2,5]
    nexttile
    LL=LightLevels{i};
    LL.SEM=squeeze(std(LL.allZscores,0,2))./5;
    LL.mean=squeeze(mean(LL.allmeanZscores));
    plotOnePupilZscore(LL,flashParams1,cmap,[-35,5],[1:2],0.02,1.5)
    if i~=2
        ylabel('')
        yticks([])
        xlabel('')
        xticks([])
    else
        yticks([-0.5,-0.25,0])
        xticks([0,2,4,6])
    end
    axis off
end
