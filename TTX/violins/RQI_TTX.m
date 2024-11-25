cmap=[255,198,30;175,88,186;0,205,108;255,198,30;175,88,186]./255;
cmapDark=0.5+(cmap*0.5);
%
[~,ipsiPre,RQIPre]=findIpsiZscore(allDataPre,3,0.3);
[~,ipsiPost,RQIPost]=findIpsiZscore(allDataPost,3,0.3);
[contraPre]=findRQI(allDataPre,2);
[contraPost]=findRQI(allDataPost,2);
rqis.a=RQIPre;
rqis.b=RQIPost;
rqisC.c=contraPre(contraPre>0.3);
rqisC.d=contraPost(contraPost>0.3);
figure('Color','w','Position',[100,100,200,300]);
tiledlayout(1,2,"TileSpacing","compact","Padding","compact")
nexttile
cmapIpsi=[cmap(3,:);cmapDark(3,:)];
xnames={'preTTX','postTTX'};
violinplot(rqis,xnames,'ViolinColor',cmapIpsi,'EdgeColor',[0.3,0.3,0.3],'BoxColor',[0.3,0.3,0.3])
ylim([0,0.7])
yline(0.3,'--')
xlim([0.2,2.8])
xticklabels({'pre TTX','Post TTX'})
yticks([0.3,0.6,0.9])
ylabel('RQI')
box off
title('Ipsi')
nexttile
cmapContra=[cmap(2,:);cmapDark(2,:)];
violinplot(rqisC,xnames,'ViolinColor',cmapContra,'EdgeColor',[0.3,0.3,0.3],'BoxColor',[0.3,0.3,0.3])
ylim([0,1])
yline(0.3,'--')
xlim([0.2,2.8])
title('Contra')
xticklabels({'pre TTX','Post TTX'})
yticks([])
box off
