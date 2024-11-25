%% classify using linkage method
chirpClass=classifyUMAP(allROI,chirpParams,30,0.2);
%% Plot heatmaps and populations for all found types
for c=2%:chirpClass.clsnumLinkage
    class=find(chirpClass.linkagecls==c);
    classROI=allROI(class,:);
    color=[[205,83,52]/255;[23,190,185]/255;[46,40,42]/255];
    %[10,21,87,109,103,101,104,105,106,108,115,122,129,132,162]
    for i=[104,115,129,132,162]
        figure(); plotOne(classROI(i),chirpParams,color,[-1,3],[1:3])
    end
    %plotClass(classROI,chirpParams)
    %plotOnepop(classROI,chirpParams)
end
%% 2 possible methods for finding ipsi responses. I will use RQI of 0.3
[zscoreIpsi,RQIipsi]=findIpsiResponding(allROI,chirpParams,4,0.3); 
ipsi=allROI(RQIipsi);
%% Classify based on ipsi responses 2 options: PCA or UMAP. use PCA
% chirpIpsi=chirpPCAipsi(ipsi,chirpParams);
% chirpIpsi=classifyUMAPipsi(ipsi,chirpParams,25,0.2);
%% Draw populations of ipsi
% ipsiPopulationsTsne(ipsi,chirpParams);
 linkagecls=ipsiPopulationsUMAP(ipsi,chirpParams,25);
%ipsiPopulationsPCA(ipsi,chirpParams);
%% Barplot separating ipsi in 2 types based on PCA separation of ipsi
findIpsiTypeNumbers(allROI,chirpClass,RQIipsi,linkagecls,1); % chirpIpsi: 1=PCA, 2=UMAP
% Note: For FOV take 2022_12_02_TL_OBO030701_8fRandomizedSet, FOV number 6
%% Mean responses for each bouton
plotAllOnOneDff(allROI,chirpParams,chirpClass)