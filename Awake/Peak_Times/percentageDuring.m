cmap=[255,198,30;175,88,186;0,205,108;255,198,30;175,88,186]./255;
cmapDark=cmap*0.8;
class=find(pca.clsKmeans==1);
classROI=allTogether(class,:);
respondingDuring=zeros(1,3);
[~,ipsiResponding]=findIpsiZscore(classROI,3,0.3);
respondingDuring(:,3)=length(ipsiResponding);
[contraDuringResponding]=findDuring(classROI,0.3,2);
respondingDuring(:,2)=length(contraDuringResponding);
[bothDuringResponding]=findDuring(classROI,0.3,1);
respondingDuring(:,1)=length(bothDuringResponding);
respondingPercentage=(respondingDuring.*100)./length(classROI);
figure('Color','w','Position',[100,100,200,250])
b=bar(respondingPercentage);
b.FaceColor = 'flat';
for i=1:3
    b.CData(i,:) = cmap(i,:);
    b.EdgeColor='none';
end
xticklabels({'Both','Contra','Ipsi'})
ylabel('Percentage [%]')
yticks([25,50,75,100])
ylim([0,50])
box off