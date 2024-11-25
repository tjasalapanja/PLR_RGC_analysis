%% load data and find responding ROI
clear
% Enter recording, sync and saving data
folder='TL_2023_08_25_OBO038136_GCaMP6s';
suite2pName='suite2p1';
DATASET_PATH=['X:\Tjasa\Suite2p\',folder,'\',suite2pName,'\plane0\'];
DATASET_NAME='Fall.mat';
SYNC_NAME='test_000_001.mat';
title='testForSubmission';
animalName='OBO038136\';
% SAVE_PATH = ['X:\Tjasa\Data_analysis\new\',folder,'\',title];
% SAVE_NAME=[SAVE_PATH,'\',animalName];
% mkdir(SAVE_PATH)
suite2pDataset= strcat(DATASET_PATH, DATASET_NAME);    
syncDataset= strcat(DATASET_PATH, SYNC_NAME);
ipsi=1;
randomized=1;
% Calculate mean and std for all ROI, keep only responding ROI
Suite2p=loadData(suite2pDataset,0.95); %0.7= how much background to remove (value suggested in suite2p). use .95 to remove all noise
flashParams=loadFlashParameters(size(Suite2p.dffNotNorm,2),syncDataset,ipsi,[1,36],6); 
allROI=[];
respondingROI=[];
for ROI=1:size(Suite2p.dffNotNorm,1)
    roi=getFlashData(Suite2p,flashParams,ipsi,ROI,randomized);
    allROI=[allROI;roi];
    if sum(roi.respondingROI)>0
        respondingROI=[respondingROI;roi];
    end
end
clear allROITemp roi SYNC_NAME suite2pName ROI 
% save(SAVE_NAME)