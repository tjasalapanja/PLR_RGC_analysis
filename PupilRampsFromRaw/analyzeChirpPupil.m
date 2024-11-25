%% load data and find responding ROI
clear
% Enter recording, sync and saving data
folder='TL_2024_09_09_Chirp\OBO044996';
file='OBO044996chirp2_prediction_pupil_size.npy';
nameFile=['X:\Tjasa\MousePupil\',folder,'\',file];%nameFile=['Y:\Tjasa\Suite2p\',folder,'\',file];
pupilFull=readNPY(nameFile);
DATASET_PATH=['X:\Tjasa\MousePupil\',folder,'\'];
DATASET_NAME='\fall';
SYNC_NAME='\test_000_001';
title='pupilSizezscoreChirp';
animalName='OBO044996';
SAVE_PATH = ['X:\Tjasa\Data_analysis\new\',folder,'\',title];
SAVE_NAME=[SAVE_PATH,'\',animalName];
mkdir(SAVE_PATH)   
syncDataset= strcat(DATASET_PATH, SYNC_NAME);
ipsi=1;
randomized=1;
%order=[4,1,3,2,5];
b=[1,5,8,12,15];
c=[3,6,9,11,14];
i=[2,4,7,10,13];
% Calculate mean and std for all ROI, keep only responding ROI
flashParamsChirp=loadFlashParameters(length(pupilFull),syncDataset,ipsi); 
pupilChirp=getFlashData(pupilFull,flashParamsChirp,ipsi,randomized,b,c,i);
% b=[2,6,8,12,15,18];
% c=[1,4,9,11,14,17];
% i=[3,5,7,10,13,16];
% Calculate mean and std for all ROI, keep only responding ROI
% flashParams2=loadFlashParameters(length(pupilFull),syncDataset,ipsi,[37,72],6); 
% pupil2=getFlashData(pupilFull,flashParams2,ipsi,randomized,b,c,i);
save(SAVE_NAME)