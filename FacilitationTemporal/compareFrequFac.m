%% 0.55Hz
load('Y:\Tjasa\Data_analysis\Thesis\Figure8_ContrastRamps\all0.25Hz.mat')
%load('Y:\Tjasa\Data_analysis\Paper\Figure3\TemporalFacilitation\together055.mat')
allROI055=allROI;
slowParams055=slowParams;
pca055=lowContrastPCA(allROI055);
% Populations
for i=1:3 % Pop1=OFF
    plotOnepop(allROI055(pca055.clsKmeans==i),slowParams055,1)
end
% Partial RMI
[rmiEarly055,rmiLate055,randomEarly055,randomLate055]=partialRMI(allROI055((pca055.clsKmeans==1)),slowParams055,14,2);% span = 1/2 time 14 for 0.55Hz 4 for 2Hz
diffByAnimal055=cell(5,1);
meanDiff055=zeros(1,5);
nAnimal=cumsum(Num);
count=0;
% for i=1:10
%     diffByAnimal055{i}=rmiEarly055(count+1:nAnimal(i))-rmiLate055(count+1:nAnimal(i));
%     meanDiff055(i)=mean(diffByAnimal055{i});
%     count=nAnimal(i);
% end
load('Y:\Tjasa\Data_analysis\Thesis\Figure8_ContrastRamps\all2Hz.mat')
allROI2=allROI;
slowParams2=slowParams;
pca2=lowContrastPCA(allROI2);
% Populations
for i=1 % Pop1=OFF
    plotOnepop(allROI2(pca2.clsKmeans==i),slowParams2,1)
end
% Partial RMI
[rmiEarly2,rmiLate2,randomEarly2,randomLate2]=partialRMI(allROI2(pca2.clsKmeans==1),slowParams2,4,3);% span = 1/2 time 14 for 0.55Hz 4 for 2Hz
diffByAnimal2=cell(5,1);
meanDiff2=zeros(1,5);
nAnimal=cumsum(Num);
count=0;
for i=1:5
    diffByAnimal2{i}=rmiEarly2(count+1:nAnimal(i))-rmiLate2(count+1:nAnimal(i));
    meanDiff2(i)=mean(diffByAnimal2{i});
    count=nAnimal(i);
end
%% Plot difference
% colorOrange=[242,133,34]./255;
% colorDarkOrange=[0.3,0.3,0.3]+0.3*colorOrange;
% diff055=mean(rmiEarly055-rmiLate055);
% diff2=mean(rmiEarly2-rmiLate2);
% figure('Color','w','Position',[100,100,200,250])
% bar([1,2],[diff2,diff055],'FaceColor',colorOrange,'EdgeColor','none')
% hold on
% scatter(1,meanDiff2,20,'MarkerFaceColor',colorDarkOrange,'MarkerEdgeColor','none')
% scatter(2,meanDiff055,20,'MarkerFaceColor',colorDarkOrange,'MarkerEdgeColor','none')
% for i=1:5
%     line([1,2],[meanDiff2(i),meanDiff055(i)],'Color',colorDarkOrange)
% end
% xticklabels({'2Hz','0.55Hz'})
% xlim([0.2,2.8])
% yticks([-0.1,0,0.1,0.2])
% ylabel('\Delta RMI')
% box off