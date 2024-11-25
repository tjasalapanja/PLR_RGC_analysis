%% Violin plot
% calculate areas anew, I don't trust the precalculated ones
function vio=violinPlotting(respondingROI,flashParams)
    area=zeros(length(respondingROI),3);
    for roi=1:length(respondingROI)
        area(roi,1)=abs(trapz(respondingROI(roi).mean_flash(flashParams.framesBeforeFlash:end-1,2)));
        area(roi,2)=abs(trapz(respondingROI(roi).mean_flash(flashParams.framesBeforeFlash:end-1,3)));
        area(roi,3)=abs(trapz(respondingROI(roi).mean_flash(1:flashParams.framesBeforeFlash,2)))+trapz(abs(respondingROI(roi).mean_flash(1:flashParams.framesBeforeFlash,3)));
    end
    figure('Color','w','Position',[100,100,300,400])
    cmap=crameri('bukavu',4);
    colors=[cmap(2,:);cmap(3,:);0.5,0.5,0.5];
    x_names={'Contra','Ipsi','Background'};
    violinplot(area,x_names,'ViolinColor',colors)
    xlim([0,4])
    ylim([-20,205])
    xticks([1,2,3])
    xticklabels({'Contra','Ipsi','Background'})
    xtickangle(45)
    set(gca,'FontSize',11);
    ylabel('Response [a.u.]')
end
