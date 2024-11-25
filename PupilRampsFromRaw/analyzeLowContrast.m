%% load data and find responding ROI
clear
% Enter recording, sync and saving data
folder='0_55Hz_vs_2Hz_pupil\PM_050424_OBO042581';
file='contra_pupil_003.npy';
suite2pName='suite2p';
nameFile=['Y:\Group_folder\To Tjasa\pietro_experiments\',folder,'\',file];%nameFile=['Y:\Tjasa\Suite2p\',folder,'\',file];
pupilFull=readNPY(nameFile);
DATASET_PATH=['Y:\Group_folder\To Tjasa\pietro_experiments\',folder,'\'];
DATASET_NAME='\fall';
SYNC_NAME='\rec_000_003';
title='pupilSizezscore2hz';
animalName='OBO042444';
SAVE_PATH = ['Y:\Tjasa\Data_analysis\new\',folder,'\',title];
SAVE_NAME=[SAVE_PATH,'\',animalName];
mkdir(SAVE_PATH)   
syncDataset= strcat(DATASET_PATH, SYNC_NAME);
ipsi=1;
randomized=1;
%order=[4,1,3,2,5];
b=[3,6,9,11,14,17];
c=[1,4,8,12,15,18];
i=[2,5,7,10,13,16];
% Calculate mean and std for all ROI, keep only responding ROI
flashParams055=loadFlashParameters(length(pupilFull),syncDataset,ipsi,[1,36],6); 
pupil055=getFlashData(pupilFull,flashParams055,ipsi,randomized,b,c,i);
b=[2,6,8,12,15,18];
c=[1,4,9,11,14,17];
i=[3,5,7,10,13,16];
% Calculate mean and std for all ROI, keep only responding ROI
flashParams2=loadFlashParameters(length(pupilFull),syncDataset,ipsi,[37,72],6); 
pupil2=getFlashData(pupilFull,flashParams2,ipsi,randomized,b,c,i);
save(SAVE_NAME)