%% Summation
colorOrange=[240,143,110]./255;
colorLightOrange=[255,82,4]./255;
colorViolet=[8,153,126]./255;
colorLightViolet=[158,250,233]./255;
[peakHeightLow,peakHeightHigh]=findPeakTimes(responsesLL2(OFFcontrol{2}),responsesLL5(OFFcontrol{5}),flashParams2);
[peakHeightLowAtr,peakHeightHighAtr]=findPeakTimes(atropineLL2(OFFatropine{2}),atropineLL5(OFFatropine{5}),flashParams2);
peakBothLow=peakHeightLow(:,1);
peakSumLow=peakHeightLow(:,2)+peakHeightLow(:,3);
peakBothHigh=peakHeightHigh(:,1);
peakSumHigh=peakHeightHigh(:,2)+peakHeightHigh(:,3);
peakBothLowAtr=peakHeightLowAtr(:,1);
peakSumLowAtr=peakHeightLowAtr(:,2)+peakHeightLowAtr(:,3);
peakBothHighAtr=peakHeightHighAtr(:,1);
peakSumHighAtr=peakHeightHighAtr(:,2)+peakHeightHighAtr(:,3);
% figure('Color','w','Position',[100,100,300,300]);
% scatter(peakSumHigh,peakBothHigh,8,'filled','MarkerFaceColor',colorViolet)
% hold on
% scatter(peakSumLow,peakBothLow,8,'filled','MarkerFaceColor',colorOrange)
% xlim([0,6])
% xlabel('max dF/F Contra + max dF/F Ipsi')
% ylim([0,6])
% ylabel('max dF/F Both')
% line([0,6],[0,6],'Color','k','LineStyle','--')
% 
figure('Color','w','Position',[100,100,800,400]);
tiledlayout(1,3,"TileSpacing","compact","Padding","compact")

nexttile
scatter(peakSumLow,peakBothLow,12,'filled','MarkerFaceColor',colorOrange)
hold on
xlim([0,4])
xlabel('max dF/F Contra + max dF/F Ipsi')
ylim([0,4])
ylabel('max dF/F Both')
line([0,4],[0,4],'Color','k','LineStyle','--')
% xticklabels('')
% yticklabels('')
% ylabel('')
% xlabel('')

nexttile
scatter(peakSumHigh,peakBothHigh,12,'filled','MarkerFaceColor',colorViolet)
hold on
xlim([0,6])
xlabel('max dF/F Contra + max dF/F Ipsi')
ylim([0,6])
line([0,6],[0,6],'Color','k','LineStyle','--')
% xticklabels('')
% yticklabels('')
ylabel('')
xlabel('')

nexttile
scatter(peakSumLowAtr,peakBothLowAtr,12,'filled','MarkerFaceColor',[0.4,0.4,0.4])
hold on
xlim([0,4])
xlabel('max dF/F Contra + max dF/F Ipsi')
ylim([0,4])
ylabel('max dF/F Both')
line([0,4],[0,4],'Color','k','LineStyle','--')
% xticklabels('')
% yticklabels('')
% ylabel('')
% xlabel('')