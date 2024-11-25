pcaLow=lowContrastPCA(lowContrast);
pcaHigh=lowContrastPCA(highContrast);
%% Separate ON and OFF
lowON=lowContrast(pcaLow.clsKmeans==1);
lowOFF=lowContrast(pcaLow.clsKmeans==2);
highON=highContrast(pcaHigh.clsKmeans==1);
highOFF=highContrast(pcaHigh.clsKmeans==2);
type1=lowOFF;
type2=highOFF;
%% Summation
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
[peakHeightLow,peakHeightHigh]=findPeakTimes(type1,type2,highParams);
peakBothLow=peakHeightLow(:,1);
peakSumLow=peakHeightLow(:,2)+peakHeightLow(:,3);
peakBothHigh=peakHeightHigh(:,1);
peakSumHigh=peakHeightHigh(:,2)+peakHeightHigh(:,3);
figure('Color','w','Position',[100,100,300,300]);
scatter(peakSumHigh,peakBothHigh,8,'filled','MarkerFaceColor',colorRed)
hold on
scatter(peakSumLow,peakBothLow,8,'filled','MarkerFaceColor',colorBlue)
xlim([0,4])
xlabel('max dF/F Contra + max dF/F Ipsi')
ylim([0,4])
ylabel('max dF/F Both')
line([0,4],[0,4],'Color','k','LineStyle','--')