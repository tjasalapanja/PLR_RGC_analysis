%% Plot Signal to noise ratio at 2Hz and 0.55Hz
%load('\\brutus.embl.it\rompani\Tjasa\Data_analysis\Paper\Figure3\TemporalFacilitation\atropine0052.mat')
pca055=lowContrastPCA(allROI055); % class 1
pca055atropine=lowContrastPCA(atropine055,3); % class 4
pca2=lowContrastPCA(allROI2); %class 1
allROI055=allROI055(pca055.clsKmeans==1);
atropine055=atropine055(pca055atropine.clsKmeans==1);
allROI2=allROI2(pca2.clsKmeans==1);
cutPart=2; % Taking Largest third of data 
% Class of all 055Hz (Pietro and Me)
%Class of all2Hz
RMI055=zeros(length(allROI055),1);
for roi=1:length(RMI055)
    areaBoth(roi)=trapz(abs(allROI055(roi).meanSlow(slowParams055.framesBeforeSlow:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow,1)));
    areaContra(roi)=trapz(abs(allROI055(roi).meanSlow(slowParams055.framesBeforeSlow:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow,2)));
    RMI055(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
end
[~,sorted055]=sort(RMI055,'descend');
topPart055=sorted055(1:round(length(allROI055)/cutPart));

RMI055atropine=zeros(length(atropine055),1);
for roi=1:length(RMI055atropine)
    areaBoth(roi)=trapz(abs(atropine055(roi).meanSlow(slowParams055.framesBeforeSlow:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow,1)));
    areaContra(roi)=trapz(abs(atropine055(roi).meanSlow(slowParams055.framesBeforeSlow:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow,2)));
    RMI055atropine(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
end
[~,sorted055atropine]=sort(RMI055atropine,'descend');
topPart055atropine=sorted055atropine(1:round(length(atropine055)/cutPart));

RMI2=zeros(length(allROI2),1);
for roi=1:length(RMI2)
    areaBoth(roi)=trapz(abs(allROI2(roi).meanSlow(slowParams2.framesBeforeSlow:slowParams2.framesBeforeSlow+slowParams2.framesDuringSlow,1)));
    areaContra(roi)=trapz(abs(allROI2(roi).meanSlow(slowParams2.framesBeforeSlow:slowParams2.framesBeforeSlow+slowParams2.framesDuringSlow,2)));
    RMI2(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
end
[~,sorted2]=sort(RMI2,'descend');
topPart2=find(sorted2(1:round(length(allROI2)/cutPart)));
%% Colors
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
colorGray=[0.6,0.6,0.6];
%% Find RMIs for early and late
cuts055=slowParams055.framesBeforeSlow+14:28:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow;
% early: Peaks 2,3,4
earlyFrames055=[cuts055(2):cuts055(5)];
% late: Peaks 6:12
lateFrames055=[cuts055(7):cuts055(end)];
cuts2=slowParams2.framesBeforeSlow+4:8:slowParams2.framesBeforeSlow+slowParams2.framesDuringSlow;
% early: Peaks 2,3,4
earlyFrames2=[cuts2(2):cuts2(5)];
% late: Peaks 6:12
lateFrames2=[cuts2(7):cuts2(end)];
% PartialRMIs
EarlyRMI055=calculateRMIpartial(allROI055(topPart055),earlyFrames055);
LateRMI055=calculateRMIpartial(allROI055(topPart055),lateFrames055);

EarlyRMIAtr=calculateRMIpartial(atropine055(topPart055atropine),earlyFrames055);
LateRMIAtr=calculateRMIpartial(atropine055(topPart055atropine),lateFrames055);

EarlyRMI2=calculateRMIpartial(allROI2(topPart2),earlyFrames2);
LateRMI2=calculateRMIpartial(allROI2(topPart2),lateFrames2);
%% Plot
figure('Color','w','Position',[100,100,800,600])
tiledlayout(1,3,'TileSpacing','compact','Padding','compact')
nexttile(1)
n=rand(length(EarlyRMI2),1)*0.3;
for i=1:length(EarlyRMI2)
    line([n(i)+0.9,n(i)+1.9],[EarlyRMI2(i),LateRMI2(i)],'Color',[0.8,0.8,0.8],'LineWidth',0.3)
    hold on
end
scatter(0.9+n,EarlyRMI2,'.','MarkerEdgeColor',[0.5,0.5,0.5])
scatter(1.9+n,LateRMI2,'.','MarkerEdgeColor',[0.5,0.5,0.5])
xlim([0.5,2.5])
line([1,2],[mean(EarlyRMI2),mean(LateRMI2)],'Color',colorRed,'LineWidth',2.5,'Marker','.','MarkerFaceColor',colorRed)
ylim([-1,1])
xticks([1,2])
yline(0,'k--')
xticklabels({'Low','High'})
yticks([-1:0.5:1])
ylabel('RMI')
title('2 Hz', 'Color',colorRed)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(3)
n=rand(length(EarlyRMI055),1)*0.3;
for i=1:length(EarlyRMI055)
    line([n(i)+0.9,n(i)+1.9],[EarlyRMI055(i),LateRMI055(i)],'Color',[0.8,0.8,0.8],'LineWidth',0.3)
    hold on
end
scatter(0.9+n,EarlyRMI055,'.','MarkerEdgeColor',[0.5,0.5,0.5])
scatter(1.9+n,LateRMI055,'.','MarkerEdgeColor',[0.5,0.5,0.5])
xlim([0.5,2.5])
line([1,2],[mean(EarlyRMI055),mean(LateRMI055)],'Color',colorBlue,'LineWidth',2.5,'Marker','.','MarkerFaceColor',colorBlue)
yline(0,'k--')
ylim([-1,1])
xticklabels({'Low','High'})
yticks([])
title('055 Hz', 'Color',colorBlue)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';

nexttile(2)
n=rand(length(EarlyRMIAtr),1)*0.3;
for i=1:length(EarlyRMIAtr)
    line([n(i)+0.9,n(i)+1.9],[EarlyRMIAtr(i),LateRMIAtr(i)],'Color',[0.8,0.8,0.8],'LineWidth',0.3)
    hold on
end
scatter(0.9+n,EarlyRMIAtr,'.','MarkerEdgeColor',[0.5,0.5,0.5])
scatter(1.9+n,LateRMIAtr,'.','MarkerEdgeColor',[0.5,0.5,0.5])
xlim([0.5,2.5])
line([1,2],[mean(EarlyRMIAtr),mean(LateRMIAtr)],'Color',[0.3,0.3,0.3],'LineWidth',2.5,'Marker','.','MarkerFaceColor',[0.3,0.3,0.3])
yline(0,'k--')
ylim([-1,1])
yticks([])
xticklabels({'Low','High'})
xlabel('Contrast')
title('055 Hz Atropine', 'Color',colorGray)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
%% Plot bar
diff2=LateRMI2-EarlyRMI2;
diff055=LateRMI055-EarlyRMI055;
diffAtr=LateRMIAtr-EarlyRMIAtr;
figure('Color','w','Position',[100,100,500,580])
bar(1,mean(diff2),'FaceColor',colorRed,'EdgeColor','none')
hold on
errorbar(1,mean(diff2),std(diff2)./sqrt(length(diff2)),'Color',[0.2,0.2,0.2],'LineWidth',0.8)
bar(2,mean(diffAtr),'FaceColor',colorGray,'EdgeColor','none')
errorbar(2,mean(diffAtr),std(diffAtr)./sqrt(length(diffAtr)),'Color',[0.2,0.2,0.2],'LineWidth',0.8)
bar(3,mean(diff055),'FaceColor',colorBlue,'EdgeColor','none')
errorbar(3,mean(diff055),std(diff055)./sqrt(length(diff055)),'Color',[0.2,0.2,0.2],'LineWidth',0.8)
xticks([1,2,3])
xticklabels({'2Hz','Atr','0.55Hz'})
yticks([-0.25,-0.2,-0.15,-0.1,-0.05,0,0.05,0.1,0.15])
ylabel('\Delta RMI')
yline(0)
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';