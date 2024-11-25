%animal={[1:203],[204:531],[532:866],[867:927],[928:994]};%cumsum(animalControl);
animal={[1:191],[192:457],[458:721],[722:733],[734:736]};
corrsModulation=zeros(length(responsesLL2),1);
pupilDiff=pupilFdiff(LL2);
respFdiff=responseFdiff(responsesLL2);
currentAnimal=1;
for i=1:length(responsesLL2)
    if ~ismember(i,animal{currentAnimal})
        currentAnimal=currentAnimal+1;
    end
    corrsModulation(i)=corr(respFdiff(i,48:48+47)',pupilDiff(currentAnimal,48:48+47)','type','Spearman');
end
%animal={[1:292],[293:610],[611:876],[877:954]};%cumsum(animalControl);
animal={[1:159],[160:328],[329:535],[536:596]};
corrsModulationAtropine=zeros(length(atropineLL2),1);
pupilDiff=pupilFdiff(LL2atropine);
respFdiff=responseFdiff(atropineLL2);
currentAnimal=1;
for i=1:length(atropineLL2)
    if ~ismember(i,animal{currentAnimal})
        currentAnimal=currentAnimal+1;
    end
    corrsModulationAtropine(i)=corr(respFdiff(i,48:48+47)',pupilDiff(currentAnimal,48:48+47)','type','Spearman');
end
%% Plot Correlation Coefficient
figure('color','w','Position',[100,100,600,500]);
colorBlue=[0,154,222]./255;
colorPaleBlue=[0.5,0.5,0.5]+0.3*colorBlue;
colorOrange=[240,143,110]./255;
colorLightOrange=[255,82,4]./255;
% histogram(corrsModulation(OFFcontrol{2}),[-1:0.05:1],'FaceColor',colorOrange,'EdgeColor',colorLightOrange,'FaceAlpha',0.9,'Normalization','probability')
% hold on
histogram(corrsModulationAtropine(OFFatropine{2}),[-1:0.05:1],'FaceColor',[0.4,0.4,0.4],'EdgeColor',[0.6,0.6,0.6],'Normalization','probability','FaceAlpha',0.9)
% percentageTicks=[0,2.5,5,7.5,10];
% numberTicks=percentageTicks*length(OFFatropine{2})./100;
xline(0,'--k','LineWidth',1)
% yticks(numberTicks)
% yticklabels({num2str(percentageTicks(1)),num2str(percentageTicks(2)),num2str(percentageTicks(3)),num2str(percentageTicks(4)),num2str(percentageTicks(5))})
xlabel('Spearman correlation')
ylabel('% boutons')
% yticks([0,20,40])
% ylim([0,42])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
yticks([0.05,0.10,0.15])
ytix = get(gca, 'YTick')
ylim([0,0.16])
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100,'FontSize',14)