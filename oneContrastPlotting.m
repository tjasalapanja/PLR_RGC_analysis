classdef oneContrastPlotting
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
            box off
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
            box off
        end
        function p=plotHigh(ROI,flashParams,color,i)
            overallTitle=['50% contrast ROI ',num2str(i)];
            maximum=0;
            minimum=0;
            maxLocal=max(max(ROI.mean_flash+ROI.std_flash));
            minLocal=min(min(ROI.mean_flash-ROI.std_flash));
            if maxLocal>maximum
                maximum=maxLocal;
            end
            if minLocal<minimum
                minimum=minLocal;
            end
            p=figure('Color','w','Position',[100,100,900,300]);
            lim_y=[minimum,maximum];
            titles={'BOTH','CONTRA','IPSI'};
                for type=1:3
                    subplot(1,3,type)
                    oneContrastPlotting.plotOnlyOne(ROI,flashParams,type,color,lim_y)
                    box off
                    title(titles(type),'FontSize',12)
                end
            sgtitle(overallTitle,'FontSize', 14)
        end
        function p=plotHighMerged(ROI,flashParams,color,i)
            overallTitle=['50% contrast ROI ',num2str(i)];
            maximum=0;
            minimum=0;
            maxLocal=max(max(ROI.mean_flash+ROI.std_flash));
            minLocal=min(min(ROI.mean_flash-ROI.std_flash));
            if maxLocal>maximum
                maximum=maxLocal;
            end
            if minLocal<minimum
                minimum=minLocal;
            end
            p=figure('Color','w','Position',[100,100,400,500]);
            lim_y=[minimum,maximum];
            legends={'BOTH','CONTRA','IPSI'};
            oneContrastPlotting.plotOne(ROI,flashParams,color,lim_y)
            box off
            legend(legends,'FontSize',10,'Location','southoutside','NumColumns',3)
            legend box off
            sgtitle(overallTitle,'FontSize', 14)
        end
        function hm=plotHeatmap(ROI_list,figureTitle)
            [~, ind] = sort([ROI_list(:,1).mean_area_contra],'descend');
            sortedResp=zeros(length(ROI_list),size(ROI_list(1).mean_flash,1),3);
            c=1;
            for a=ind
                sortedResp(c,:,:)=ROI_list(a).mean_flash(:,:);
                c=c+1;
                sortedResp(sortedResp<-0.5)=-0.5;
                sortedResp(sortedResp>2.5)=2;
            end
            hm=figure('Color','white','Position',[100,100,1000,500]);
            mini=min(min(min(min(sortedResp))));
            maxi=max(max(max(max(sortedResp))));           
            tiledlayout(1,3)
            names={'BOTH', 'CONTRA', 'IPSI'};
            for subp=1:3
                nexttile
                h=heatmap(sortedResp(:,:,subp),'grid','off','Colorlimits', [mini,maxi]);
                h.Colormap = turbo;
                h.ColorbarVisible = 'on';
                Ax = gca;
                Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
                Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
                t=[names{subp},' n= ',num2str(length(ROI_list))];
                ylabel(t)
                S = struct(h); % Undocumented
                ax = S.Axes;    % Undocumented
                col = [38, 39+77];  
                %xline(ax, [col, col], 'k-','LineWidth',1);
            end
            sgtitle(figureTitle,'FontSize',14)
        end
        function hm=plotHeatmapSpks(ROI_list,figureTitle)
            [~, ind] = sort([ROI_list(:,1).mean_area_contra],'descend');
            sortedSpks=zeros(length(ROI_list),size(ROI_list(1).mean_spks,1),3);
            c=1;
            for a=ind
                sortedSpks(c,:,:)=ROI_list(a).mean_spks(:,:);
                c=c+1;
            end
            hm=figure('Color','white','Position',[100,100,1000,500]);
            mini=min(min(min(min(sortedSpks))));
            maxi=max(max(max(max(sortedSpks))));           
            tiledlayout(1,3)
            names={'BOTH', 'CONTRA', 'IPSI'};
            for subp=1:3
                nexttile
                h=heatmap(sortedSpks(:,:,subp),'grid','off','Colorlimits', [mini,maxi]);
                h.Colormap = turbo;
                h.ColorbarVisible = 'off';
                Ax = gca;
                Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
                Ax.YDisplayLabels = nan(size(Ax.YDisplayData));
                t=[names{subp},' n= ',num2str(length(ROI_list))];
                ylabel(t)
                S = struct(h); % Undocumented
                ax = S.Axes;    % Undocumented
                col = [38, 39+77];  
                %xline(ax, [col, col], 'w-','LineWidth',1);
            end
            sgtitle(figureTitle,'FontSize',14)
        end
        function [GMplot,kmeansplot]=PCA(oneContrastPCA)
            color={[0 0.4470 0.7410],[0.8500 0.3250 0.0980],[0.9290 0.6940 0.1250],[0.4940 0.1840 0.5560],[0.4660 0.6740 0.1880],[0.3010 0.7450 0.9330],[0.6350 0.0780 0.1840],[0 1 1],[1 1 0],[1 0 1],[0.6350 0.0780 0.50],[0.6350 0.0480 0.840],[0.8350 0.0280 0.1],[0.9350 0.0780 0.1840],[0.3350 0.0780 0.2840]};
            GMplot=figure('Color','w','Position',[100,100,600,600]);
            kmeansplot=figure('Color','w','Position',[100,100,600,600]);
            figure(kmeansplot)
            plot(oneContrastPCA.Ckmeans(:,1),oneContrastPCA.Ckmeans(:,2),'ko')
            for i=1:size(oneContrastPCA.D_PCA,1)
                c=oneContrastPCA.clsKmeans(i);
                scatter(oneContrastPCA.D_PCA(i,1),oneContrastPCA.D_PCA(i,2),25,'MarkerEdgeColor',color{c},'MarkerFaceColor',color{c},'MarkerFaceAlpha',0.5)
                axis equal
                hold on
            end
            p1=round(oneContrastPCA.percentage(1),1);
            p2=round(oneContrastPCA.percentage(2)-oneContrastPCA.percentage(1),1);
            xTitle=['PC1: ',num2str(p1),'%'];
            yTitle=['PC2: ',num2str(p2),'%'];
            xlabel(xTitle,'FontSize',12)
            ylabel(yTitle,'FontSize',12)
            xticklabels([])
            yticklabels([])
            grid off
            Title=['k-means clusters=',num2str(oneContrastPCA.clusterNumber)];
            title(Title,'FontSize',12)
            hold off
            figure(GMplot)
            for i=1:size(oneContrastPCA.D_PCA,1)
                c=oneContrastPCA.clsGM(i);
                scatter(oneContrastPCA.D_PCA(i,1),oneContrastPCA.D_PCA(i,2),25,'MarkerEdgeColor',color{c},'MarkerFaceColor',color{c},'MarkerFaceAlpha',0.5)
                axis equal
                hold on
            end
            p1=round(oneContrastPCA.percentage(1),1);
            p2=round(oneContrastPCA.percentage(2)-oneContrastPCA.percentage(1),1);
            xTitle=['PC1: ',num2str(p1),'%'];
            yTitle=['PC2: ',num2str(p2),'%'];
            xlabel(xTitle,'FontSize',12)
            ylabel(yTitle,'FontSize',12)
            xticklabels([])
            yticklabels([])
            grid off
            Title=['GM clusters=',num2str(oneContrastPCA.clusterNumber)];
            title(Title,'FontSize',12)
            hold off
        end
        function popSep=classPopResponseSeparated(ROI_list,flashParams,color)
            popSep=figure('Color','w','Position',[100,100,300,800]);
            if length(ROI_list(:,1))>1
                data=zeros(length(ROI_list),size(ROI_list(1).mean_flash,1),size(ROI_list(1).mean_flash,2));
                count=0;
                for roi=1: length(ROI_list(:,1))
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
                lim=[min(minlims)-0.1,max(maxlims+0.1)];
                    for type=1:3
                        subplot(3,1,type);
                        oneContrastPlotting.plotOnlyOne(pop,flashParams,type,color,lim)
                    end
                sgtitle('50% contrast population response')
            end
        end
        function popTog=classPopResponseTogether(ROI_list,flashParams,color)
            popTog=figure('Color','w','Position',[100,100,400,300]);
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
                lim=[min(minlims)-0.1,max(maxlims+0.1)];
                oneContrastPlotting.plotOne(pop,flashParams,color,lim)
                sgtitle('50% contrast population response')
            end
        end
    end
end