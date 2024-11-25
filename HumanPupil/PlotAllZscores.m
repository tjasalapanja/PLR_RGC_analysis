colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,250,400])
tiledlayout(7,2,'TileSpacing','compact','Padding','compact')
nexttile(1)
plotSlowPattern055(flashParams055,15.49,0) % Mouse side
title ('Mouse')
axis off

nexttile(2)
plotSlowPattern055(flashParams055,15.49,1) % Human side
title('Human')
axis off

nexttile(3,[3,1])
for i=1:17
    plotExamplePupil(pupil2,flashParams2,[0.7,0.7,0.7],[-4.5,2.8],[1],0.1,0.3,0,i)
end
plotOnePupil(pupil2,flashParams2,colorRed,[-4.5,2.8],[1],0.1,1,0)
xlim([0,9])
xlabel('')
xticks([])
axis off

nexttile(4,[3,1])
for i=1:15
    plotExamplePupilHuman(allPupil2Human,[0.7,0.7,0.7],[-4.5,2.8],[1],0.1,0.3,0,i,0)
end
plotOnePupilHuman(allPupil2Human,colorRed,[-4.5,2.8],[1],0.1,1,0,0)
xlim([0,9])
axis off

nexttile(9,[3,1])
for i=1:30
    plotExamplePupil(pupil055,flashParams055,[0.7,0.7,0.7],[-4.5,2.8],[1],0.1,0.3,0,i)
end
plotOnePupil(pupil055,flashParams055,colorBlue,[-4.5,2.8],[1],0.1,1,0)
xlim([0,25])
xlabel('')
xticks([])
ylabel('')
yticks([])
axis off

nexttile(10,[3,1])
for i=1:14
    plotExamplePupilHuman(allPupil055Human,[0.7,0.7,0.7],[-4.5,2.9],[1],0.1,0.3,0,i,1)
end
plotOnePupilHuman(allPupil055Human,colorBlue,[-4.5,2.9],[1],0.1,1,0,1)
xlim([0,20])
axis off