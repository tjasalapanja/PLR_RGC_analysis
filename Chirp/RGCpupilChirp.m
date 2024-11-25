% RGC chirp example bouton=47,49,214 in animal OBO044997
color=[255,198,30;175,88,186;0,205,108]./255;
for i= [49]
    figure("Color","w","Position",[100,100,600,400])
    tiledlayout(3,1,"TileSpacing","compact","Padding","compact")
    nexttile
    plotOne(respondingROI(i),chirpParams,color,[-1,2],[2])
    hold on
    xlabel('')
    xticks([])
%     xline(2,'--k','LineWidth',0.8)
%     xline(5,'--k','LineWidth',0.8)
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
    nexttile
    plotOne(respondingROI(i),chirpParams,color,[-0.5,0.7],[3])
    hold on
    xlabel('')
    xticks([])
%     xline(0,'-k')
%     xline(2,'--k','LineWidth',0.8)
%     xline(5,'--k','LineWidth',0.8)
%     xline(55.2,'-k')
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
    nexttile
    seconds=[1:962]./15.49-2;
    plot(seconds,chirpPupil.all_pupil(:,:,3),'Color',[0.6,0.6,0.6])
    hold on
    plot(seconds,chirpPupil.mean_pupil(:,3),'k','LineWidth',1)
    xlim([seconds(1),seconds(end)])
    box off
%     xline(0,'-k')
%     xline(2,'--k','LineWidth',1)
%     xline(5,'--k','LineWidth',1)
%     xline(55.2,'-k')
    xlabel('')
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
end
%%
figure("Color","w","Position",[100,100,700,400])
seconds=[1:962]./15.49-2;
tiledlayout(2,1,"TileSpacing","tight","Padding","compact")
nexttile
plotOne(respondingROI(49),chirpParams,color,[-0.5,0.7],[3])
xlabel('')
xticks([])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile
plot(seconds,chirpPupil.all_pupil(:,:,3),'Color',[0.6,0.6,0.6])
hold on
plot(seconds,chirpPupil.mean_pupil(:,3),'k','LineWidth',1)
xlim([seconds(1),seconds(end)])
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';