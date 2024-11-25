%Get ipsi responding OFF
class=find(pca.clsKmeans==1);
classROI=allTogether(class,:);
[~,ipsiResponding]=findIpsiZscore(classROI,3,0.3);
ipsi=classROI(ipsiResponding);
% plot ratio
% peakTimes=zeros(length(classROI),3);
peakHeight=zeros(length(classROI),3);
len=31:160;
for roi=1:length(classROI)
    [peakHeight(roi,:)]=trapz(abs(classROI(roi).mean_flash(len,:)));
end
figure()
scatter(peakHeight(:,2),peakHeight(:,3),'.')
hold on
line([0,450],[0,450])
xlim([0,150])
ylim([0,150])