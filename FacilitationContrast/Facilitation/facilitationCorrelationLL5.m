%animal={[1:203],[204:531],[532:866],[867:927],[928:994]};%cumsum(animalControl);
% animal={[1:191],[192:457],[458:721],[722:733],[734:736]};
animal={[1:235],[236:557],[558:897],[898:978],[979:1058]};
corrsModulation=zeros(length(responsesLL5),1);
pupilDiff=pupilFdiff(LL5);
respFdiff=responseFdiff(responsesLL5);
currentAnimal=1;
for i=1:length(responsesLL5)
    if ~ismember(i,animal{currentAnimal})
        currentAnimal=currentAnimal+1;
    end
    corrsModulation(i)=corr(respFdiff(i,48:48+47)',pupilDiff(currentAnimal,48:48+47)','type','Spearman');
end
%animal={[1:292],[293:610],[611:876],[877:954]};%cumsum(animalControl);
%animal={[1:159],[160:328],[329:535],[536:596]};
animal={[1:220],[221:542],[543:819],[820:901]};%num5
corrsModulationAtropine=zeros(length(atropineLL5),1);
pupilDiff=pupilFdiff(LL5atropine);
respFdiff=responseFdiff(atropineLL5);
currentAnimal=1;
for i=1:length(atropineLL5)
    if ~ismember(i,animal{currentAnimal})
        currentAnimal=currentAnimal+1;
    end
    corrsModulationAtropine(i)=corr(respFdiff(i,48:48+47)',pupilDiff(currentAnimal,48:48+47)','type','Spearman');
end
%% Plot Correlation Coefficient
figure('color','w','Position',[100,100,600,500]);
colorViolet=[8,153,126]./255;
colorLightViolet=[158,250,233]./255;
histogram(corrsModulation(OFFcontrol{5}),[-1:0.05:1],'FaceColor',colorViolet,'EdgeColor',colorLightViolet,'FaceAlpha',0.9,'Normalization','probability')
hold on
histogram(corrsModulationAtropine(OFFatropine{5}),[-1:0.05:1],'FaceColor',[0.4,0.4,0.4],'EdgeColor',[0.6,0.6,0.6],'Normalization','probability')
xline(0,'--k','LineWidth',1)
xticks([])
xlabel('Spearman correlation')
ylabel('# boutons')
yticks([0,0.05,0.1,0.15])
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
ytix = get(gca, 'YTick')
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100)
ylim([0,0.15])