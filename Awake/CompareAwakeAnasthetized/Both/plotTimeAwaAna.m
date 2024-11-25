ipsiAwa=awaTimes(:,3)./15.49;
ipsiAna=anaTimes(:,3)./15.49;
contraAna=anaTimes(:,2)./15.49-5;
contraAna(contraAna<0)=[];
contraAwa=awaTimes(:,2)./15.49-5;
contraAwa(contraAwa<0)=[];
%% Median and percentiles
ipsiAnaMed=mean(ipsiAna);
ipsiAna25=prctile(ipsiAna,25);
ipsiAna75=prctile(ipsiAna,75);

ipsiAwaMed=mean(ipsiAwa);
ipsiAwa25=prctile(ipsiAwa,25);
ipsiAwa75=prctile(ipsiAwa,75);

contraAnaMed=mean(contraAna);
contraAna25=prctile(contraAna,25);
contraAna75=prctile(contraAna,75);

contraAwaMed=mean(contraAwa);
contraAwa25=prctile(contraAwa,25);
contraAwa75=prctile(contraAwa,75);
%% 
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
figure('Color','w','Position',[100,100,300,500])
bar(1,mean(ipsiAna),'FaceColor',colorBlue)
hold on
errorbar(1,mean(ipsiAna),std(ipsiAna)./sqrt(192),'Color',[0.2,0.2,0.2])

bar(2,mean(ipsiAwa),'FaceColor',colorRed)
errorbar(2,mean(ipsiAwa),std(ipsiAwa)./sqrt(161),'Color',[0.2,0.2,0.2])
% scatter(2,ipsiAwa,10,'.k')
% scatter(1,ipsiAna,10,'.k')
bar(3,mean(contraAna),'FaceColor',colorBlue)
errorbar(3,mean(contraAna),std(contraAna)./sqrt(170),'Color',[0.2,0.2,0.2])
% scatter(3,contraAna,10,'.k')

bar(4,mean(contraAwa),'FaceColor',colorRed)
errorbar(4,mean(contraAwa),std(contraAwa)./sqrt(136),'Color',[0.2,0.2,0.2])
% scatter(4,contraAwa,10,'.k')
xticks([1.5,3.5])
xticklabels({'Ipsi','Contra'})
legend({'Anasthetized','','Awake'})
ylabel('Max peak latency [s]')
% ylim([0,7.5])
box off
legend box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
%%
figure('Color','w','Position',[100,100,300,500])
bar(1,ipsiAwaMed,'FaceColor',colorBlue)
hold on
errorbar(1,ipsiAwaMed,ipsiAwa25,ipsiAwa75,'Color',[0.2,0.2,0.2])

bar(2,ipsiAwaMed,'FaceColor',colorRed)
errorbar(2,ipsiAwaMed,ipsiAwa25,ipsiAwa75,'Color',[0.2,0.2,0.2])

bar(3,contraAnaMed,'FaceColor',colorBlue)
errorbar(3,contraAnaMed,contraAwa25,contraAna75,'Color',[0.2,0.2,0.2])


bar(4,contraAwaMed,'FaceColor',colorRed)
errorbar(4,contraAwaMed,contraAwa25,contraAwa75,'Color',[0.2,0.2,0.2])

xticks([1.5,3.5])
xticklabels({'Ipsi','Contra'})
legend({'Anasthetized','','Awake'})
ylabel('Max peak latency [s]')
% ylim([0,7.5])
box off
legend box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';