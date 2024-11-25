%% Peak Times
cmap=[255,198,30;175,88,186;0,205,108;255,198,30;175,88,186]./255;
cmapDark=cmap*0.8;
class=find(pca.clsKmeans==1);
classROI=allTogether(class,:);
[~,ipsiResponding]=findIpsiZscore(classROI,3,0.3);
[contraDuringResponding]=findDuring(classROI,0.3,2);
[bothDuringResponding]=findDuring(classROI,0.3,1);
peakTimesDuring=zeros(length(classROI),3);
peakHeightDuring=zeros(length(classROI),3);
peakTimesAfter=zeros(length(classROI),3);
peakHeightAfter=zeros(length(classROI),3);
len1=39:115;
len2=116:192;
for roi=1:length(classROI)
    [peakHeightDuring(roi,:),peakTimesDuring(roi,:)]=max(abs(classROI(roi).mean_flash(len1,:)));
    [peakHeightAfter(roi,:),peakTimesAfter(roi,:)]=max(abs(classROI(roi).mean_flash(len2,:)));
end
figure('Color','w','Position',[100,100,250,250])
p.a=peakTimesDuring(contraDuringResponding,1)./15.49;
p.b=peakTimesDuring(contraDuringResponding,2)./15.49;
p.c=peakTimesDuring(ipsiResponding,3)./15.49;
p.d=peakTimesAfter(:,1)./15.49;
p.e=peakTimesAfter(:,2)./15.49;
xnames={'Both','Contra','Ipsi','Both','Contra'};
violinplot(p,xnames,'ViolinColor',cmap,'EdgeColor',[0.3,0.3,0.3],'BoxColor',[0.3,0.3,0.3])
xticklabels({'Both','Contra','Ipsi','Both','Contra'})
ylabel('Latency [s]')
xline(3.5,'--','LineWidth',1)
yticks([0,1,2,3,4,5])
ylim([0,6])
text(1.2,5.5,'Onset')
text(4.2,5.5,'Offset')