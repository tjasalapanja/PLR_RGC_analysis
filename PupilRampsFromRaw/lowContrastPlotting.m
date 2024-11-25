classdef lowContrastPlotting
    % plotOne: plots both contra ipsi for one ROI/light level
    % plotOnlyOne: plots only one type (both,contra or ipsi)
    methods (Static)
        function plotOne(ROI_list,flashParams,color,lim_y)
            stim_before = zeros(1, flashParams.framesBeforeFlash);
            stim_during = ones(1, flashParams.framesDuringFlash); 
            stim_after = zeros(1, flashParams.framesAfterFlash);
            seq = [stim_before, stim_during, stim_after];
            seconds = (([1:length(seq)]./flashParams.FRAMERATE)-(flashParams.framesBeforeFlash./flashParams.FRAMERATE));  
            hold on
            for type=1:3
                plot(seconds, ROI_list.mean_flash(:,type), 'color',color(type,:));
                seconds2 = [seconds, fliplr(seconds)];
                areaStd= [ROI_list.mean_flash(:,type)'+ROI_list.std_flash(:,type)', fliplr(ROI_list.mean_flash(:,type)'-ROI_list.std_flash(:,type)')];
                f_c=fill(seconds2, areaStd,color(type,:),'HandleVisibility','off');
                set(f_c,'facealpha', .3, 'EdgeColor', 'none')
                hold on
            end
            xlabel('time [s]','FontSize',14)
            ylabel('df/f','FontSize',14)
            xlim([seconds(1),seconds(end)])
            patchx=[flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE, (flashParams.framesDuringFlash/flashParams.FRAMERATE), (flashParams.framesDuringFlash/flashParams.FRAMERATE),flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE];
            patchy = [lim_y(1) lim_y(1) lim_y(2) lim_y(2)];
            patch(patchx,patchy,'k','FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off')
            ylim(lim_y)
        end
        function plotOnlyOne(ROI_list,flashParams,type,color,lim_y)
            stim_before = zeros(1, flashParams.framesBeforeFlash);
            stim_during = ones(1, flashParams.framesDuringFlash); 
            stim_after = zeros(1, flashParams.framesAfterFlash);
            seq = [stim_before, stim_during, stim_after];
            seconds = (([1:length(seq)]./flashParams.FRAMERATE)-(flashParams.framesBeforeFlash./flashParams.FRAMERATE));  
            plot(seconds, ROI_list.mean_flash(:,type), 'color',color(type,:));
            hold on
            seconds2 = [seconds, fliplr(seconds)];
            areaStd= [ROI_list.mean_flash(:,type)'+ROI_list.std_flash(:,type)', fliplr(ROI_list.mean_flash(:,type)'-ROI_list.std_flash(:,type)')];
            f_c=fill(seconds2, areaStd,color(type,:),'HandleVisibility','off');
            set(f_c,'facealpha', .5, 'EdgeColor', 'none')
            hold on
            xlabel('time [s]','FontSize',12)
            ylabel('df/f','FontSize',12)
            xlim([seconds(1),seconds(end)])
            %patchx=[flashParams.framesBeforeFlash/flashParams.FRAMERATE, (flashParams.framesBeforeFlash/flashParams.FRAMERATE)*2, (flashParams.framesBeforeFlash/flashParams.FRAMERATE)*2,flashParams.framesBeforeFlash/flashParams.FRAMERATE];
            patchx=[flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE, (flashParams.framesDuringFlash/flashParams.FRAMERATE), (flashParams.framesDuringFlash/flashParams.FRAMERATE),flashParams.framesBeforeFlash/flashParams.FRAMERATE-flashParams.framesBeforeFlash./flashParams.FRAMERATE];
            patchy = [lim_y(1) lim_y(1) lim_y(2) lim_y(2)];
            patch(patchx,patchy,'k','FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off')
            ylim(lim_y)
        end
        function p=plotLuminances(ROI,flashParams1,flashParams2,flashParams3,flashParams4,flashParams5,color,i)
            overallTitle=['Low contrast ROI ',num2str(i)];
            maximum=0;
            minimum=0;
            params=[flashParams1,flashParams2,flashParams3,flashParams4,flashParams5];
            for luminance=1:5
                maxLocal=max(max(ROI(luminance).mean_flash+ROI(luminance).std_flash));
                minLocal=min(min(ROI(luminance).mean_flash-ROI(luminance).std_flash));
                if maxLocal>maximum
                    maximum=maxLocal;
                end
                if minLocal<minimum
                    minimum=minLocal;
                end
            end
            p=figure('Color','w','Position',[100,100,1000,800]);
            lim_y=[minimum,maximum];
            titles={'low luminance','high luminance'};
            legends={'BOTH','CONTRA','IPSI'};
            for luminance=1:5
                flashParams=params(luminance);
                for type=1:3
                    subplot(3,5,(type-1)*5+luminance)
                    lowContrastPlotting.plotOnlyOne(ROI(luminance),flashParams,type,color,lim_y)
                    box off
                    if luminance==5
                        legend(legends{type},'FontSize',10)
                        legend box off
                    end
                    if type<3 || luminance~=3
                        xlabel('')
                    end
                    if luminance>1
                        ylabel('')
                    end
                    if luminance==1 && type==1
                        title(titles{1},'FontSize',12)
                    elseif luminance==5 && type==1
                        title(titles{2},'FontSize',12)
                    end
                end
            end
            sgtitle(overallTitle,'FontSize', 14)
        end
        function p=plotLuminancesMerged(ROI,flashParams1,flashParams2,flashParams3,flashParams4,flashParams5,color,i)
            overallTitle=['Low contrast ROI ',num2str(i)];
            maximum=0;
            minimum=0;
            params=[flashParams1,flashParams2,flashParams3,flashParams4,flashParams5];
            for luminance=1:5
                maxLocal=max(max(ROI(luminance).mean_flash+ROI(luminance).std_flash));
                minLocal=min(min(ROI(luminance).mean_flash-ROI(luminance).std_flash));
                if maxLocal>maximum
                    maximum=maxLocal;
                end
                if minLocal<minimum
                    minimum=minLocal;
                end
            end
            p=figure('Color','w','Position',[100,100,1500,400]);
            lim_y=[minimum,maximum];
            titles={'low luminance','high luminance'};
            legends={'BOTH','CONTRA','IPSI'};
            for luminance=1:5
                flashParams=params(luminance);
                subplot(1,5,luminance)
                lowContrastPlotting.plotOne(ROI(luminance),flashParams,color,lim_y)
                box off
                if luminance==5
                    legend(legends,'FontSize',10)
                    legend box off
                end
                if luminance==1
                    title(titles{1},'FontSize',12)
                elseif luminance==5 
                    title(titles{2},'FontSize',12)
                end
            end
            sgtitle(overallTitle,'FontSize', 14)
        end
        function hm=plotHeatmap(ROI_list,figureTitle)
            [~, ind] = sort([ROI_list(:,1).mean_area_contra],'descend');
            sortedResp=zeros(length(ROI_list),size(ROI_list(1).mean_flash,1),3,5);
            c=1;
            for a=ind
                for luminance=1:5
                    sortedResp(c,:,:,luminance)=ROI_list(a,luminance).mean_flash(:,:);
                end
                c=c+1;
            end
            sortedResp(sortedResp<-0.5)=-0.5;
            sortedResp(sortedResp>3.5)=3.5;
            hm=figure('Color','white','Position',[100,100,1500,1200]);
            mini=min(min(min(min(sortedResp))));
            maxi=max(max(max(max(sortedResp))));           
            tiledlayout(3,5)
            names={'BOTH', 'CONTRA', 'IPSI'};
            luminances={'low luminance','high luminance'};
            for subp=1:3
                for luminance=1:5
                    nexttile
                    h=heatmap(sortedResp(:,:,subp,luminance),'grid','off','Colorlimits', [mini,maxi]);
                    h.Colormap = turbo;
                    h.ColorbarVisible = 'on';
                    Ax = gca;
                    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
                    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
                    if luminance==1 & subp==1
                        title(luminances{1})
                    elseif luminance==5 & subp==1
                        title(luminances{2})
                    end
                    t=[names{subp},' n= ',num2str(length(ROI_list))];
                    ylabel(t)
                    S = struct(h); % Undocumented
                    ax = S.Axes;    % Undocumented
                    col = [26, 26+77];  
                    xline(ax, [col, col], 'k-','LineWidth',1); % see footnotes [1,2]
                end
                sgtitle(figureTitle,'FontSize',14)
            end
        end
        function hm=plotHeatmapSpks(ROI_list,figureTitle)
            [~, ind] = sort([ROI_list(:,1).mean_area_contra],'descend');
            sortedSpks=zeros(length(ROI_list),size(ROI_list(1).mean_spks,1),3,5);
            c=1;
            for a=ind
                for luminance=1:5
                    sortedSpks(c,:,:,luminance)=ROI_list(a,luminance).mean_spks(:,:);
                end
                c=c+1;
            end
            hm=figure('Color','white','Position',[100,100,1500,900]);
            mini=min(min(min(min(sortedSpks))));
            maxi=max(max(max(max(sortedSpks))));           
            tiledlayout(3,5)
            names={'BOTH', 'CONTRA', 'IPSI'};
            luminances={'low luminance','high luminance'};
            for subp=1:3
                for luminance=1:5
                    nexttile
                    h=heatmap(sortedSpks(:,:,subp,luminance),'grid','off','Colorlimits', [mini,maxi]);
                    h.Colormap = turbo;
                    h.ColorbarVisible = 'off';
                    Ax = gca;
                    Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
                    Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
                    if luminance==1 & subp==1
                        title(luminances{1})
                    elseif luminance==5 & subp==1
                        title(luminances{2})
                    end
                    t=[names{subp},' n= ',num2str(length(ROI_list))];
                    ylabel(t)
                    S = struct(h); % Undocumented
                    ax = S.Axes;    % Undocumented
                    col = [25, 26+77];  
                    xline(ax, [col, col], 'w-','LineWidth',1); % see footnotes [1,2]
                end
            end
            sgtitle(figureTitle,'FontSize',14)
        end
        function [GMplot,kmeansplot]=PCA(lowContrastPCA)
            color={[0 0.4470 0.7410],[0.8500 0.3250 0.0980],[0.9290 0.6940 0.1250],[0.4940 0.1840 0.5560],[0.4660 0.6740 0.1880],[0.3010 0.7450 0.9330],[0.6350 0.0780 0.1840],[0 1 1],[1 1 0],[1 0 1],[0.6350 0.0780 0.50],[0.6350 0.0480 0.840],[0.8350 0.0280 0.1],[0.9350 0.0780 0.1840],[0.3350 0.0780 0.2840]};
            GMplot=figure('Color','w','Position',[100,100,600,600]);
            kmeansplot=figure('Color','w','Position',[100,100,600,600]);
            figure(kmeansplot)
            plot(lowContrastPCA.Ckmeans(:,1),lowContrastPCA.Ckmeans(:,2),'ko')
            for i=1:size(lowContrastPCA.D_PCA,1)
                c=lowContrastPCA.clsKmeans(i);
                scatter(lowContrastPCA.D_PCA(i,1),lowContrastPCA.D_PCA(i,2),25,'MarkerEdgeColor',color{c},'MarkerFaceColor',color{c},'MarkerFaceAlpha',0.5)
                axis equal
                hold on
            end
            p1=round(lowContrastPCA.percentage(1),1);
            p2=round(lowContrastPCA.percentage(2)-lowContrastPCA.percentage(1),1);
            xTitle=['PC1: ',num2str(p1),'%'];
            yTitle=['PC2: ',num2str(p2),'%'];
            xlabel(xTitle,'FontSize',12)
            ylabel(yTitle,'FontSize',12)
            xticklabels([])
            yticklabels([])
            grid off
            Title=['k-means clusters=',num2str(lowContrastPCA.clusterNumber)];
            title(Title,'FontSize',12)
            hold off
            figure(GMplot)
            for i=1:size(lowContrastPCA.D_PCA,1)
                c=lowContrastPCA.clsGM(i);
                scatter(lowContrastPCA.D_PCA(i,1),lowContrastPCA.D_PCA(i,2),25,'MarkerEdgeColor',color{c},'MarkerFaceColor',color{c},'MarkerFaceAlpha',0.5)
                axis equal
                hold on
            end
            p1=round(lowContrastPCA.percentage(1),1);
            p2=round(lowContrastPCA.percentage(2)-lowContrastPCA.percentage(1),1);
            xTitle=['PC1: ',num2str(p1),'%'];
            yTitle=['PC2: ',num2str(p2),'%'];
            xlabel(xTitle,'FontSize',12)
            ylabel(yTitle,'FontSize',12)
            xticklabels([])
            yticklabels([])
            grid off
            Title=['GM clusters=',num2str(lowContrastPCA.clusterNumber)];
            title(Title,'FontSize',12)
            hold off
        end
        function popSep=classPopResponseSeparated(ROI_list,flashParams1,flashParams2,flashParams3,flashParams4,flashParams5,color)
            params=[flashParams1,flashParams2,flashParams3,flashParams4,flashParams5];
            titles={'Low luminance', 'High luminance'};
            maxlims=zeros(1,5);
            minlims=zeros(1,5);
            popSep=figure('Color','w','Position',[100,100,1200,800]);
            if length(ROI_list(:,1))>1
                for luminance=1:5
                    count=0;
                    data=zeros(length(ROI_list(:,luminance)),size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2));
                    for roi=1: length(ROI_list(:,1))
                        if sum(ROI_list(roi,luminance).respondingROI)>0
                            data(roi,:,:)=ROI_list(roi,luminance).mean_flash;
                            count=count+1;
                        else
                            data(roi,:,:)=nan;
                        end
                    end
                    % create struct compatible with plotOne. called std_flash
                    % because of this, but it is actually SEM
                    pop(luminance).mean_flash=zeros(size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2)); 
                    pop(luminance).std_flash=zeros(size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2));
                    pop(luminance).mean_flash(:,1)=mean(data(:,:,1),'omitnan');
                    pop(luminance).std_flash(:,1)=std(data(:,:,1),'omitnan')./sqrt(count);
                    pop(luminance).mean_flash(:,2)=mean(data(:,:,2),'omitnan');
                    pop(luminance).std_flash(:,2)=std(data(:,:,2),'omitnan')./sqrt(count);
                    pop(luminance).mean_flash(:,3)=mean(data(:,:,3),'omitnan');
                    pop(luminance).std_flash(:,3)=std(data(:,:,3),'omitnan')./sqrt(count); 
                    maxlim=max(max(pop(luminance).mean_flash+pop(luminance).std_flash));
                    minlim=min(min(pop(luminance).mean_flash-pop(luminance).std_flash));
                    maxlims(luminance)=maxlim;
                    minlims(luminance)=minlim;
                end
                lim=[min(minlims)-0.1,max(maxlims+0.1)];
                for luminance=1:5 
                    for type=1:3
                        subplot(3,5,(type-1)*5+luminance);
                        lowContrastPlotting.plotOnlyOne(pop(luminance),params(luminance),type,color,lim)
                        if type==1
                            if luminance ==1
                                title(titles{1})
                            end
                            if luminance==5
                                title(titles{2})
                            end
                        end
                        if type==1 ||type==2
                            xlabel('')
                        end
                        if luminance>1
                            ylabel('')
                        end
                    end
                end
                sgtitle('Low contrast population response')
            end
        end
        function popTog=classPopResponseTogether(ROI_list,flashParams1,flashParams2,flashParams3,flashParams4,flashParams5,color)
            params=[flashParams1,flashParams2,flashParams3,flashParams4,flashParams5];
            titles={'Low luminance', 'High luminance'};
            maxlims=zeros(1,5);
            minlims=zeros(1,5);
            popTog=figure('Color','w','Position',[100,100,1200,300]);
            if length(ROI_list(:,1))>1
                for luminance=1:5
                    count=0;
                    data=zeros(length(ROI_list(:,luminance)),size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2));
                    for roi=1: length(ROI_list(:,1))
                        if sum(ROI_list(roi,luminance).respondingROI)>0
                            data(roi,:,:)=ROI_list(roi,luminance).mean_flash;
                            count=count+1;
                        else
                            data(roi,:,:)=nan;
                        end
                    end
                    % create struct compatible with plotOne. called std_flash
                    % because of this, but it is actually SEM
                    pop(luminance).mean_flash=zeros(size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2)); 
                    pop(luminance).std_flash=zeros(size(ROI_list(1,1).mean_flash,1),size(ROI_list(1,1).mean_flash,2));
                    pop(luminance).mean_flash(:,1)=mean(data(:,:,1),'omitnan');
                    pop(luminance).std_flash(:,1)=std(data(:,:,1),'omitnan')./sqrt(count);
                    pop(luminance).mean_flash(:,2)=mean(data(:,:,2),'omitnan');
                    pop(luminance).std_flash(:,2)=std(data(:,:,2),'omitnan')./sqrt(count);
                    pop(luminance).mean_flash(:,3)=mean(data(:,:,3),'omitnan');
                    pop(luminance).std_flash(:,3)=std(data(:,:,3),'omitnan')./sqrt(count); 
                    maxlim=max(max(pop(luminance).mean_flash+pop(luminance).std_flash));
                    minlim=min(min(pop(luminance).mean_flash-pop(luminance).std_flash));
                    maxlims(luminance)=maxlim;
                    minlims(luminance)=minlim;
                end
                lim=[min(minlims)-0.1,max(maxlims+0.1)];
                for luminance=1:5 
                    subplot(1,5,luminance);
                    lowContrastPlotting.plotOne(pop(luminance),params(luminance),color,lim)
                    if luminance ==1
                        title(titles{1})
                    end
                    if luminance==5
                        title(titles{2})
                    end
                end
                sgtitle('Low contrast population response')
            end
        end
    end
end