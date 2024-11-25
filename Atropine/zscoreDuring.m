% load('X:\Tjasa\Data_analysis\Paper\NatureNeuroscience\newForReview\figure1\barData.mat')
cmap=[175,88,186;0,205,108;125,125,125]./255;
% get OFF data
OFFcontrol=responsesLL3(allOFFcontrol{3});
OFFatr=atropineLL3(OFFatropine{3});
% get zscores
OFFctrlZscore=zeros(length(OFFcontrol),size(OFFcontrol(1).mean_flash,1),size(OFFcontrol(1).mean_flash,2));
OFFatrZscore=zeros(length(OFFatr),size(OFFatr(1).mean_flash,1),size(OFFatr(1).mean_flash,2));
OFFttxZscore=zeros(length(OFFttx),size(OFFttx(1).mean_flash,1),size(OFFttx(1).mean_flash,2));
for i=1:length(OFFcontrol)
    m=mean(OFFcontrol(i).mean_flash(1:flashParams3.framesBeforeFlash,:));
    s=std(OFFcontrol(i).mean_flash(1:flashParams3.framesBeforeFlash,:));
    OFFctrlZscore(i,:,:)=(OFFcontrol(i).mean_flash-m)./s;
end
for i=1:length(OFFatr)
    m=mean(OFFatr(i).mean_flash(1:flashParams3.framesBeforeFlash,:));
    s=std(OFFatr(i).mean_flash(1:flashParams3.framesBeforeFlash,:));
    OFFatrZscore(i,:,:)=(OFFatr(i).mean_flash-m)./s;
end
for i=1:length(OFFttx)
    m=mean(OFFttx(i).mean_flash(1:flashParamsTTX.framesBeforeFlash,:));
    s=std(OFFttx(i).mean_flash(1:flashParamsTTX.framesBeforeFlash,:));
    OFFttxZscore(i,:,:)=(OFFttx(i).mean_flash-m)./s;
end
% Areas during and after
areaCtrl=zeros(2,length(OFFcontrol),3);
areaAtr=zeros(2,length(OFFatr),3);
areaTTX=zeros(2,length(OFFttx),3);
meanCtrl=zeros(2,length(OFFcontrol),3);
meanAtr=zeros(2,length(OFFatr),3);
meanTTX=zeros(2,length(OFFttx),3);
for i =1:length(OFFcontrol)
    areaCtrl(1,i,:)=squeeze(trapz(abs(OFFctrlZscore(i,flashParams3.framesBeforeFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,:))));
    areaCtrl(2,i,:)=squeeze(trapz(abs(OFFctrlZscore(i,flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash+flashParams3.framesAfterFlash,:))));
    meanCtrl(1,i,:)=squeeze(mean(OFFctrlZscore(i,flashParams3.framesBeforeFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,:)));
    meanCtrl(2,i,:)=squeeze(mean(OFFctrlZscore(i,flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash+flashParams3.framesAfterFlash,:)));
end
for i =1:length(OFFatr)
    areaAtr(1,i,:)=squeeze(trapz(abs(OFFatrZscore(i,flashParams3.framesBeforeFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,:))));
    areaAtr(2,i,:)=squeeze(trapz(abs(OFFatrZscore(i,flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash+flashParams3.framesAfterFlash,:))));
    meanAtr(1,i,:)=squeeze(mean(OFFatrZscore(i,flashParams3.framesBeforeFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash,:)));
    meanAtr(2,i,:)=squeeze(mean(OFFatrZscore(i,flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash:flashParams3.framesBeforeFlash+flashParams3.framesDuringFlash+flashParams3.framesAfterFlash,:)));
end
for i =1:length(OFFttx)
    areaTTX(1,i,:)=squeeze(trapz(abs(OFFttxZscore(i,flashParamsTTX.framesBeforeFlash:flashParamsTTX.framesBeforeFlash+flashParamsTTX.framesDuringFlash,:))));
    areaTTX(2,i,:)=squeeze(trapz(abs(OFFttxZscore(i,flashParamsTTX.framesBeforeFlash+flashParamsTTX.framesDuringFlash:flashParamsTTX.framesBeforeFlash+flashParamsTTX.framesDuringFlash+flashParamsTTX.framesAfterFlash,:))));
    meanTTX(1,i,:)=squeeze(mean(OFFttxZscore(i,flashParamsTTX.framesBeforeFlash:flashParamsTTX.framesBeforeFlash+flashParamsTTX.framesDuringFlash,:)));
    meanTTX(2,i,:)=squeeze(mean(OFFttxZscore(i,flashParamsTTX.framesBeforeFlash+flashParamsTTX.framesDuringFlash:flashParamsTTX.framesBeforeFlash+flashParamsTTX.framesDuringFlash+flashParamsTTX.framesAfterFlash,:)));
end

%% Plot mean zscore all
figure("Color","w","Position",[100,100,400,600])
tiledlayout(2,2,"Padding","compact","TileSpacing","compact")
nexttile()
bar([1,2,3],[mean(meanCtrl(1,:,2)),mean(meanAtr(1,:,2)),mean(meanTTX(1,:,2))],'FaceColor',cmap(1,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(1,:,2)),mean(meanAtr(1,:,2)),mean(meanTTX(1,:,2))],[std(meanCtrl(1,:,2))./sqrt(849),std(meanAtr(1,:,2))./sqrt(848),mean(meanTTX(1,:,2))./sqrt(171)],'Color','k','LineStyle','none')
box off
nexttile
bar([1,2,3],[mean(meanCtrl(1,:,3)),mean(meanAtr(1,:,3)),mean(meanTTX(1,:,3))],'FaceColor',cmap(2,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(1,:,3)),mean(meanAtr(1,:,3)),mean(meanTTX(1,:,3))],[std(meanCtrl(1,:,3))./sqrt(849),std(meanAtr(1,:,3))./sqrt(848),mean(meanTTX(1,:,3))./sqrt(171)],'Color','k','LineStyle','none')
box off
nexttile()
bar([1,2,3],[mean(meanCtrl(2,:,2)),mean(meanAtr(2,:,2)),mean(meanTTX(2,:,2))],'FaceColor',cmap(1,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(2,:,2)),mean(meanAtr(2,:,2)),mean(meanTTX(2,:,2))],[std(meanCtrl(2,:,2))./sqrt(849),std(meanAtr(2,:,2))./sqrt(848),mean(meanTTX(2,:,2))./sqrt(171)],'Color','k','LineStyle','none')
box off
nexttile
bar([1,2,3],[mean(meanCtrl(2,:,3)),mean(meanAtr(2,:,3)),mean(meanTTX(2,:,3))],'FaceColor',cmap(2,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(2,:,3)),mean(meanAtr(2,:,3)),mean(meanTTX(2,:,3))],[std(meanCtrl(2,:,3))./sqrt(849),std(meanAtr(2,:,3))./sqrt(848),mean(meanTTX(2,:,3))./sqrt(171)],'Color','k','LineStyle','none')
box off
%% Plot mean zscore during
figure("Color","w","Position",[100,100,300,500])
tiledlayout(2,1,"Padding","compact","TileSpacing","compact")
nexttile()
bar([1,2,3],[mean(meanCtrl(1,:,2)),mean(meanAtr(1,:,2)),mean(meanTTX(1,:,2))],'FaceColor',cmap(1,:),'EdgeColor',cmap(1,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(1,:,2)),mean(meanAtr(1,:,2)),mean(meanTTX(1,:,2))],[std(meanCtrl(1,:,2))./sqrt(849),std(meanAtr(1,:,2))./sqrt(848),mean(meanTTX(1,:,2))./sqrt(171)],'Color','k','LineStyle','none')
ylim([-1,3])
yline(0,'k')
ylabel('mean z-score')
box off
xticks([])
title('contralateral stimulation')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile
bar([1,2,3],[mean(meanCtrl(1,:,3)),mean(meanAtr(1,:,3)),mean(meanTTX(1,:,3))],'FaceColor',cmap(2,:),'EdgeColor',cmap(2,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(1,:,3)),mean(meanAtr(1,:,3)),mean(meanTTX(1,:,3))],[std(meanCtrl(1,:,3))./sqrt(849),std(meanAtr(1,:,3))./sqrt(848),mean(meanTTX(1,:,3))./sqrt(171)],'Color','k','LineStyle','none')
ylim([-1,3])
yline(0,'k')
ylabel('mean z-score')
xticklabels({'Control','Atropine','TTX'})
title('ipsilateral stimulation')
box off
sgtitle('Response during onset')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
%% Plot mean zscore during
figure("Color","w","Position",[100,100,300,500])
tiledlayout(2,1,"Padding","compact","TileSpacing","compact")
nexttile()
bar([1,2,3],[mean(meanCtrl(2,:,2)),mean(meanAtr(2,:,2)),mean(meanTTX(2,:,2))],'FaceColor',cmap(1,:),'EdgeColor',cmap(1,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(2,:,2)),mean(meanAtr(2,:,2)),mean(meanTTX(2,:,2))],[std(meanCtrl(2,:,2))./sqrt(849),std(meanAtr(1,:,2))./sqrt(848),mean(meanTTX(1,:,2))./sqrt(171)],'Color','k','LineStyle','none')
ylim([-1,7])
yline(0,'k')
ylabel('mean z-score')
box off
xticks([])
title('contralateral stimulation')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile
bar([1,2,3],[mean(meanCtrl(2,:,3)),mean(meanAtr(2,:,3)),mean(meanTTX(2,:,3))],'FaceColor',cmap(2,:),'EdgeColor',cmap(2,:))
hold on
errorbar([1,2,3],[mean(meanCtrl(2,:,3)),mean(meanAtr(2,:,3)),mean(meanTTX(2,:,3))],[std(meanCtrl(1,:,3))./sqrt(849),std(meanAtr(1,:,3))./sqrt(848),mean(meanTTX(1,:,3))./sqrt(171)],'Color','k','LineStyle','none')
ylim([-1,3])
yline(0,'k')
ylabel('mean z-score')
xticklabels({'Control','Atropine','TTX'})
title('ipsilateral stimulation')
box off
sgtitle('Response during offset')
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
%% T-test
[h,pContraA]=ttest(meanCtrl(1,:,2),meanAtr(1,:,2));
[h,pContraT]=ttest(meanCtrl(1,:,2),meanTTX(1,:,2));
[h,pIpsiA]=ttest(meanCtrl(1,:,3),meanAtr(1,:,3));
[h,pIpsiT]=ttest(meanCtrl(1,:,3),meanTTX(1,:,3));