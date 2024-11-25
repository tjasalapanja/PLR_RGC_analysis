figure('Color','w','Position',[100,100,450,720])
tiledlayout(9,1,"Padding","compact","TileSpacing","compact")
nexttile(1)
lines=zeros(140,1);
lines(6:77+5)=1;
plot(lines,'Color',[0.2,0.2,0.2],'LineWidth',1.5)
xlim([1,140])
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
nexttile(2,[4,1])
timeHistogram(awaTimes,anaTimes,flashParams,2)
xticks([])
yticks([0,25,50])
ylabel('Contra')
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
nexttile(6,[4,1])
timeHistogram(awaTimes,anaTimes,flashParams,3)
xlabel('time [s]')
ylabel('Ipsi')
legend({'Anasthetized','Awake'},'FontSize',12,'Location','southoutside','NumColumns',2)
legend box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';