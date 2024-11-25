% pca055=lowContrastPCA(allROI055);
% allROI055=allROI055(pca055.clsKmeans==1);
% pcaAtropine=lowContrastPCA(atropine055);
% atropine055=atropine055(pcaAtropine.clsKmeans==4);
%% Plot Signal to noise ratio at 2Hz and 0.55Hz
% Calculate which are top 1/3 of boutons
cutPart=2; % Taking Largest third of data 
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
topPart2=sorted2(1:round(length(allROI2)/cutPart));
%% Get StN
% Cut signal to peak by peak pieces
cuts055=slowParams055.framesBeforeSlow+14:28:slowParams055.framesBeforeSlow+slowParams055.framesDuringSlow;
% Calculate Signal to Noise and Contra Both Ratio
StNPieces055=zeros(11,length(allROI055(topPart055)),3);
StNPiecesatropine=zeros(11,length(atropine055(topPart055atropine)),3);
for i=1:11
    StNPieces055(i,:,:)=signalToNoise(allROI055(topPart055),slowParams055,cuts055(i):cuts055(i+1));
    StNPiecesatropine(i,:,:)=signalToNoise(atropine055(topPart055atropine),slowParams055,cuts055(i):cuts055(i+1));
end
ratioStN055=StNPieces055(:,:,1)./StNPieces055(:,:,2);
m055=median(ratioStN055,2);
ratioStNatropine=StNPiecesatropine(:,:,1)./StNPiecesatropine(:,:,2);
matropine=median(ratioStNatropine,2);
%% Plot
figure('Color','w','Position',[100,100,400,400])
tiledlayout(1,2,"TileSpacing","compact","Padding","compact")
nexttile
for i =1:11
    scatter(i,ratioStNatropine(i,:),'.k')
    hold on
    scatter([1:11],matropine,'or','filled')
    yline(sqrt(2))
    yline(1,'--k')
    %yticks([1,1.4])
    ylabel('Signal/noise ratio')
ylim([-3,5])
    xticks([1:11])
    xlabel('peak')
end
nexttile
for i =1:11
    scatter(i,ratioStN055(i,:),'.k')
    hold on
    scatter([1:11],m055,'or','filled')
    yline(sqrt(2))
    yline(1,'--k')
    yticks([])
    ylim([-3,5])
    xticks([1:11])
    xlabel('peak')
end
