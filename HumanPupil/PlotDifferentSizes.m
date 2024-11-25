colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,700,600])
tiledlayout(8,5,'TileSpacing','compact','Padding','compact')
nexttile(1)
plotSlowPattern055(flashParams055,15.49,0) % Mouse 2Hz
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(2,[1,4])
plotSlowPattern055(flashParams055,15.49,0) % Mouse 0.55Hz
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(6,[3,1]) % Mouse 2Hz 
for i=1:17
    plotExamplePupil(pupil2,flashParams2,[0.7,0.7,0.7],[-4.5,2.8],[1],0.1,0.3,0,i)
end
plotOnePupil(pupil2,flashParams2,colorRed,[-4.5,2.8],[1],0.1,1,0)
xlim([0,9])
xlabel('')
% xticks([])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(7,[3,4]) %Mouse 0.55Hz
for i=1:30
    plotExamplePupil(pupil055,flashParams055,[0.7,0.7,0.7],[-4.5,2.8],[1],0.1,0.3,0,i)
end
plotOnePupil(pupil055,flashParams055,colorBlue,[-4.5,2.8],[1],0.1,1,0)
xlim([0,25])
 xlabel('')
% xticks([])
 ylabel('')
% yticks([])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(21)
plotSlowPattern055(flashParams055,15.49,1) % Human 2Hz
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(22,[1,4]) 
plotSlowPattern055(flashParams055,15.49,1) % Human 0.55Hz
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(26,[3,1]) % Human 2Hz
for i=1:15
    plotExamplePupilHuman(allPupil2Human,[0.7,0.7,0.7],[-4.5,2.8],[1],0.1,0.3,0,i,0)
end
plotOnePupilHuman(allPupil2Human,colorRed,[-4.5,2.8],[1],0.1,1,0,0)
xlim([0,9])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(27,[3,4]) % Human 0.55Hz
for i=1:14
    plotExamplePupilHuman(allPupil055Human,[0.7,0.7,0.7],[-4.5,2.9],[1],0.1,0.3,0,i,1)
end
plotOnePupilHuman(allPupil055Human,colorBlue,[-4.5,2.9],[1],0.1,1,0,1)
xlim([0,20])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';