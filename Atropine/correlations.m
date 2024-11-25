%% Spearman correlation
% For each bouton find the pupil size and correlate pupil size in each
% condition with the response in each condition
colormap=[255,198,30;175,88,186;0,205,108]./255;
cmapLight=0.4+(cmap*0.01);
OFFroi=responsesLL3(allOFFcontrol{3});
atropineOFF=atropineLL3(OFFatropine{3});
animal={[1:203],[204:531],[532:866],[867:927],[928:994]};%cumsum(animalControl);
corrsControl=zeros(length(responsesLL3),3);
currentAnimal=1;
for i=1:length(responsesLL3)
    if ~ismember(i,animal{currentAnimal})
        currentAnimal=currentAnimal+1;
    end
    corrsControl(i,1)=corr(responsesLL3(i).mean_flash(48:48+47,1),LL3.allMeans(currentAnimal,48:48+47,1)','type','Spearman');
    corrsControl(i,2)=corr(responsesLL3(i).mean_flash(48:48+47,2),LL3.allMeans(currentAnimal,48:48+47,2)','type','Spearman');
    corrsControl(i,3)=corr(responsesLL3(i).mean_flash(48:48+47,3),LL3.allMeans(currentAnimal,48:48+47,3)','type','Spearman');
end
animal={[1:292],[293:610],[611:876],[877:954]};%cumsum(animalControl);
corrsAtropine=zeros(length(atropineLL3),3);
currentAnimal=1;
for i=1:length(atropineLL3)
    if ~ismember(i,animal{currentAnimal})
        currentAnimal=currentAnimal+1;
    end
    corrsAtropine(i,1)=corr(atropineLL3(i).mean_flash(48:48+47,1),LL3atropine.allMeans(currentAnimal,48:48+47,1)','type','Spearman');
    corrsAtropine(i,2)=corr(atropineLL3(i).mean_flash(48:48+47,2),LL3atropine.allMeans(currentAnimal,48:48+47,2)','type','Spearman');
    corrsAtropine(i,3)=corr(atropineLL3(i).mean_flash(48:48+47,3),LL3atropine.allMeans(currentAnimal,48:48+47,3)','type','Spearman');
end
% figure()
% % histogram(corrsControl(OFFcontrol,1),[-1:0.05:1])
% hold on
% histogram(corrsControl(OFFcontrol,2),[-1:0.05:1])
% histogram(corrsControl(OFFcontrol,3),[-1:0.05:1])
% figure()
% % histogram(corrsAtropine(OFFatropine,1),[-1:0.05:1])
% hold on
% histogram(corrsAtropine(OFFatropine,2),[-1:0.05:1])
% histogram(corrsAtropine(OFFatropine,3),[-1:0.05:1])
%% Plot Correlation Coefficient
figure('color','w','Position',[100,100,300,600]);
tiledlayout(2,1,"TileSpacing","compact","Padding","compact")
nexttile
histogram(corrsControl(allOFFcontrol{3},2),[-1:0.05:1],'FaceColor',colormap(2,:),'Normalization','probability')
hold on
histogram(corrsAtropine(OFFatropine{3},2),[-1:0.05:1],'FaceColor',cmapLight(2,:),'Normalization','probability')
xline(0,'--k','LineWidth',1)
xticks([])
% yticks([0,40,80])
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
ylim([0,0.15])
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100)
nexttile
histogram(corrsControl(allOFFcontrol{3},3),[-1:0.05:1],'FaceColor',colormap(3,:),'Normalization','probability')
hold on
histogram(corrsAtropine(OFFatropine{3},3),[-1:0.05:1],'FaceColor',cmapLight(3,:),'Normalization','probability')
xline(0,'--k','LineWidth',1)
xlabel('Spearman correlation coefficient')
% yticks([0,40,80])
box off
ylim([0,0.15])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100)
