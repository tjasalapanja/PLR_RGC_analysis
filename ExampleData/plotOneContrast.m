%folder=['TL_2023_08_25_OBO038136_GCaMP6s'];
title='testForSubmission';
color=[[205,83,52]/255;[23,190,185]/255;[46,40,42]/255];
%SAVE_PATH = ['X:\Tjasa\Data_analysis\new\',folder,'\',title];
listFail=[];
for i=1:length(respondingROI)
    if max(max(respondingROI(i).mean_flash))>50 || min(min(respondingROI(i).mean_flash))<-50
        listFail=[listFail,i];
    end
end
respondingROI(listFail)=[];
for i=25
%     SAVE_EXAMPLES=[SAVE_PATH,'\','examples'];
%     mkdir(SAVE_EXAMPLES)
    ROI=allROI(i,:);
    p=oneContrastPlotting.plotHigh(ROI,flashParams,color,i);
    name=['ROI ', num2str(i)];
%     SAVE_NAME=[SAVE_EXAMPLES,'\',name];
     saveas(p,['exampleROI.tif']);
end
% %%
for i=25
    ROI=allROI(i,:);
    p=oneContrastPlotting.plotHighMerged(ROI,flashParams,color,i);
    name=['ROImerged ', num2str(i)];
%     SAVE_NAME=[SAVE_EXAMPLES,'\',name];
     saveas(p,['exampleMerged.tif']);
end
%%
classifiedResponses=lowContrastPCA(respondingROI);
pca=PCA(classifiedResponses);
saveas(classifiedResponses.classPlot,['pca.tif'])
%%
for cluster =1:classifiedResponses.clsnumLinkage
    cls=find(classifiedResponses.linkagecls==cluster);
    figureTitle=['Mean response heatmap cls ',num2str(cluster),'n= ',num2str(length(cls))];
    h=oneContrastPlotting.plotHeatmap(respondingROI(cls),figureTitle);
    SAVE_NAME=['heatmapMeanResponse',num2str(cluster)];
    saveas(h,[SAVE_NAME,'.tif'])
    figureTitle=['Deconvolved spikes heatmap cls ',num2str(cluster),'n= ',num2str(length(cls))];
    SAVE_NAME=['heatmapSpksResponse',num2str(cluster)];
    hs=oneContrastPlotting.plotHeatmapSpks(respondingROI(cls),figureTitle);
    saveas(hs,[SAVE_NAME,'.tif'])
    SAVE_NAME=['PopulationResponse',num2str(cluster)];
    popSep=oneContrastPlotting.classPopResponseSeparated(respondingROI(cls),flashParams,color);
    saveas(popSep,[SAVE_NAME,'.tif'])
    SAVE_NAME=['PopulationResponseTogether',num2str(cluster)];
    pop=oneContrastPlotting.classPopResponseTogether(respondingROI(cls),flashParams,color);
    saveas(pop,[SAVE_NAME,'.tif'])
end