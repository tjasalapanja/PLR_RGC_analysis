function [cutMean,areaPeaks,maxPeaks,meanAreaRMI,sem]=cutPiecesPlotRMI(classSlow,slowParams)
colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
colorGray=[0.4,0.4,0.4];
cuts=slowParams.framesBeforeSlow+14:28:slowParams.framesBeforeSlow+slowParams.framesDuringSlow;%14 28
cutMean=zeros(length(classSlow),11,28,3);
for roi=1:length(classSlow)
    for c=1:length(cuts)-1
        cutMean(roi,c,:,:)=classSlow(roi).meanSlow(cuts(c)+1:cuts(c+1),:);
    end
end
maxPeaks=squeeze(max(cutMean,[],3));
peakRMI=squeeze((maxPeaks(:,:,1)-maxPeaks(:,:,2))./(maxPeaks(:,:,1)+maxPeaks(:,:,2)));
meanPeakRMI=mean(peakRMI);
stdPeakRMI=std(peakRMI);
areaPeaks=squeeze(abs(trapz(cutMean,3)));
areaRMI=squeeze((areaPeaks(:,:,1)-areaPeaks(:,:,2))./(areaPeaks(:,:,1)+areaPeaks(:,:,2)));
meanAreaRMI=mean(areaRMI);
stdAreaRMI=std(areaRMI);
sem=stdAreaRMI./sqrt(length(classSlow));
% % plot RMI map based on peak
% figure('Color','w','Position',[100,100,650,350])
% for i=2:11
%     r=rand(1,size(peakRMI,1))+1.5*i;
%     scatter(r',peakRMI(:,i)','k','filled','o','MarkerFaceAlpha',0.2)
%     hold on
%     xticks([2:11]*2)
%     xticklabels({'2','3','4','5','6','7','8','9','10','11'})
%     xlabel('PeakNumber')
%     ylabel('RMI peak')
%     ylim([-1,1])
%     line([1.5*i,i*1.5+1],[meanPeakRMI(i),meanPeakRMI(i)], 'color',[136,34,85]./255,'LineWidth',3)
%     box off
% end
%Plot RMI map based on peak
percentageRatios=zeros(10,1);
for p=2:11
    percentageRatios(p-1)=((length(find(areaRMI(:,p)>0.167)))./size(areaRMI,1))*100;
end
% figure('Color','w','Position',[100,100,500,550])
% for i=2:11
%     r=rand(1,size(areaRMI,1))+2*i;
%     scatter(r',areaRMI(:,i)','k','filled','o','MarkerFaceAlpha',0.1)
%     hold on
%     xticks([1:11]*2)
%     xticklabels({'','2','3','4','5','6','7','8','9','10','11'})
%     xlabel('PeakNumber')
%     ylabel('RMI area')
%     ylim([-1,1])
%     line([2*i,i*2+1],[meanAreaRMI(i),meanAreaRMI(i)], 'color','k','LineWidth',3)
%     errorbar(2*i+0.5,meanAreaRMI(i),stdAreaRMI(i),'color','k','LineWidth',1.5)
%     yline(0,'--k','LineWidth',1.5)
%     box off
%     title('SD')
% end
figure('Color','w','Position',[100,100,400,700])
cmap=0.3+0.7*crameri('-lapaz',14);
% cmap=crameri('-lapaz',14);
for i=1:11
    r=rand(1,size(areaRMI,1))+2*i;
    scatter(r',areaRMI(:,i)',10,'k','.','MarkerFaceAlpha',0.4,'MarkerEdgeColor',cmap(i+1,:))
    hold on
    xticks([1:11]*2)
    xticklabels({'1','2','3','4','5','6','7','8','9','10','11'})
    xlabel('PeakNumber')
    ylabel('RMI area')
    ylim([-1,1])
    yline(0,'k','LineWidth',1.5)
%     yline(0.4./2.4,'k--','LineWidth',1.5)
%     yline(1./3,'k','LineWidth',2)
    line([2*i,i*2+1],[meanAreaRMI(i),meanAreaRMI(i)], 'color',colorGray,'LineWidth',3.5)
    errorbar(2*i+0.5,meanAreaRMI(i),sem(i),'color',colorGray,'LineWidth',1.5)
    box off
    title('055 Hz Atropine','Color',colorGray)
    xlim([0,24])
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
end
%     hax = axes('Position',  [.65, 0.2, .25, .2]);
%     bar(hax,percentageRatios,'FaceColor',[0.5,0.5,0.5])
%     xticklabels({'2','3','4','5','6','7','8','9','10','11'})
%     xlabel('Peak number')
%     ylabel('% higher than sqrt(2)')
%     ylim([0,60])
%     box off
