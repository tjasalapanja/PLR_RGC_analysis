function findAllPeaks(respondingROI,slowParams)
cuts=([slowParams.framesBeforeSlow+14:28:slowParams.framesBeforeSlow+slowParams.framesDuringSlow]./15.49)-(77./15.49);

ipsiPeaks=[];
contraPeaks=[];
bothPeaks=[];
ipsiPeaksHeight=[];
contraPeaksHeight=[];
bothPeaksHeight=[];
for i=1:length(respondingROI)
    [bph,bp]=findpeaks(respondingROI(i).meanSlow(77:77+325,1),'minPeakDistance',50,'Npeaks',12,'MinPeakHeight',0.1);
    [cph,cp]=findpeaks(respondingROI(i).meanSlow(77:77+325,2),'minPeakDistance',50,'Npeaks',12,'MinPeakHeight',0.1);
    [iph,ip]=findpeaks(respondingROI(i).meanSlow(77:77+325,3),'minPeakDistance',50,'Npeaks',12,'MinPeakHeight',0.1);
    bothPeaksHeight=[bothPeaksHeight;bph];
    bothPeaks=[bothPeaks;bp];
    contraPeaksHeight=[contraPeaksHeight;cph];
    contraPeaks=[contraPeaks;cp];
    ipsiPeaksHeight=[ipsiPeaksHeight;iph];
    ipsiPeaks=[ipsiPeaks;ip];
end
figure('Color','w','Position',[100,100,750,300])
% subplot(7,1,1)
% plotSlowPattern(slowParams)
tiledlayout(3,1,"TileSpacing","tight","Padding","compact")
%subplot(3,1,1)
nexttile
histogram(bothPeaks./15.49,[-77:3:480-77]./15.49)
xticklabels({''})
yticklabels({''})
yticks([])
xline(cuts,'LineWidth',1)
ylabel('Both','FontSize',12)
xlim([0,22])
title('0.55 Hz','FontSize',12)
box off
% subplot(3,1,2)
nexttile
histogram(contraPeaks./15.49,[-77:3:480-77]./15.49)
xticklabels({''})
yticklabels({''})
yticks([])
xline(cuts,'LineWidth',1)
ylabel('Contra','FontSize',12)
xlim([0,22])
box off
% subplot(3,1,3)
nexttile
histogram(ipsiPeaks./15.49,[-77:3:480-77]./15.49)
xlabel('time [s]','FontSize',12)
yticklabels({''})
yticks([])
xline(cuts,'LineWidth',1)
box off
ylabel('Ipsi','FontSize',12)
xlim([0,22])
end