function populationResponse(ROI_list,flashParams,cmap,type,patchRange,lines,lims)
    popTog=figure('Color','w','Position',[100,100,200,300]);
    if length(ROI_list(:,1))>1
        count=1;
        data=zeros(length(ROI_list),size(ROI_list(1).mean_flash,1),size(ROI_list(1).mean_flash,2));
        for roi=1: length(ROI_list)
            if sum(ROI_list(roi).respondingROI)>0
                data(roi,:,:)=ROI_list(roi).mean_flash;
                count=count+1;
            else
                data(roi,:,:)=nan;
            end
        end
        % create struct compatible with plotOne. called std_flash
        % because of this, but it is actually SEM
        pop.mean_flash=zeros(size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2)); 
        pop.std_flash=zeros(size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2));
        pop.mean_flash(:,1)=mean(data(:,:,1),'omitnan');
        pop.std_flash(:,1)=std(data(:,:,1),'omitnan')./sqrt(count);
        pop.mean_flash(:,2)=mean(data(:,:,2),'omitnan');
        pop.std_flash(:,2)=std(data(:,:,2),'omitnan')./sqrt(count);
        pop.mean_flash(:,3)=mean(data(:,:,3),'omitnan');
        pop.std_flash(:,3)=std(data(:,:,3),'omitnan')./sqrt(count);
        maxlim=max(max(pop.mean_flash+pop.std_flash));
        minlim=min(min(pop.mean_flash-pop.std_flash));
        maxlims=maxlim;
        minlims=minlim;
        limy=lims;
        plotOneSD(pop,flashParams,cmap,limy,type,patchRange,lines);
%         legend({'Contra','Ipsi'},'Location','southoutside','NumColumns',2,'FontSize',10)
%         legend box off
        
    end
end