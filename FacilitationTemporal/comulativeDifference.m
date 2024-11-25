colorOrange=[242,133,34]./255;
a=rmiEarly2-rmiLate2;
a_r=randomEarly2-randomLate2;
b=rmiEarly055-rmiLate055;
b_r=randomEarly055-randomLate055;
figure('Color','w','Position',[100,100,250,300])
steps2=linspace(1,100,length(allROI2((pca2.clsKmeans==1))));
steps055=linspace(1,100,length(allROI055(pca055.clsKmeans==1)));
tiledlayout(2,1)
nexttile
plot(sort(a),steps2,'LineWidth',1.5,'Color',colorOrange)
hold on
plot(sort(a_r),steps2,'LineWidth',1.5,'Color',[0.4,0.4,0.4])
xlim([-1,1])
xticks([])
ylabel('2 Hz')
box off
title('\Delta RMI')
nexttile
plot(sort(b),steps055,'LineWidth',1.5,'Color',colorOrange)
hold on
plot(sort(b_r),steps055,'LineWidth',1.5,'Color',[0.4,0.4,0.4])
xlim([-1,1])
ylabel('0.55 Hz')
box off