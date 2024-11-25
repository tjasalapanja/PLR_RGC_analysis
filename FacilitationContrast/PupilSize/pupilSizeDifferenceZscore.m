figure('Color','w','Position',[100,100,300,200])
%map=[255,198,30;175,88,186;0,205,108]./255;
colorBlue=[0,154,222]./255;
lightBlue=0.6+(0.3*colorBlue);
darkBlue=0.3-(0.3*colorBlue);
means=zeros(5,3);
stds=zeros(5,3);
sems=zeros(5,3);
count=1;
animalLine=zeros(5,5);
for ll=[1:5]%[2,4,3,1,5]
    data=minPupilSizeLLzscore{ll};
    difference=data(:,2)-data(:,1);
    meanDifference=mean(difference);
    stdDifference=std(difference);
    bar(count,meanDifference,'FaceColor',lightBlue,'EdgeColor','none')
    hold on
    errorbar(count,meanDifference,stdDifference,'Color',darkBlue)
    scatter(count,difference,15,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',darkBlue,'MarkerFaceAlpha',0.8)
    box off
    count=count+2;
    animalLine(:,ll)=difference;
end
% for i=1:5
%     line([1:2:10],animalLine(i,:),'Color',[0.3,0.3,0.3])
% end
xticks([1,3,5,7,9])
xticklabels({'1','2','3','4','5'})
xlabel('Contrast steps')
% yticks([-0.05,0,0.05,0.1])
ylabel('\Delta min pupil size [norm]')