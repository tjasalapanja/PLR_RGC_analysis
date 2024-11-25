%% subpopulation of OFF RMI only
% get animal label to each RMI
labeledRMIs=cell(2,5);
labeledRMIs(1,:)=RMIs;
labeledRMIs(2,:)=[];
% nums={num1,num2,num3,num4,num5};
for LL=1:5
    labeledRMIs{2,LL}=zeros(length(labeledRMIs{1,LL}),1);
    count=1;
    num=nums{LL};
    c=cumsum(num);
    for animal=1:5     
        labeledRMIs{2,LL}(count:c(animal))=animal;
        count=c(animal)+1;
    end
end
%% get OFF only data
OFF_RMIs=cell(2,5);
for i=1:5
    OFF_RMIs{1,i}=labeledRMIs{1,i}(OFFcontrol{i});
    OFF_RMIs{2,i}=labeledRMIs{2,i}(OFFcontrol{i});
end
%% Percentage Facilitated
threshold=mean(edgeFull);
percentage=zeros(1,5);
percentagePerAnimal=zeros(5,5);
facOFF=cell(2,5);
for i=1:5
    f=find(OFF_RMIs{1,i}>threshold);
    facOFF{1,i}=OFF_RMIs{1,i}(f);
    facOFF{2,i}=OFF_RMIs{2,i}(f);
    for j=1:5
        an_f=length(find(facOFF{2,i}==j));
        an_off=length(find(OFF_RMIs{2,i}==j));
        percentagePerAnimal(j,i)=(an_f*100)./an_off;
    end
    percentage(i)=(length(f)*100)./length(OFF_RMIs{1,i});
end
%% Plot percentage
figure('Color','w','Position',[100,100,400,250])
colorRed=[255,31,91]./255;
colorPaleRed=[0.5,0.5,0.5]+0.3*colorRed;
bar([1:5],percentage,'FaceColor',colorRed,'EdgeColor','none')
xticklabels({'LL1','LL2','LL3','LL4','LL5',''})
ylabel('% facilitated')
box off
%% Scatter pupil difference modulation
PMIs=zeros(25,1);
RMIall=zeros(25,1);
differences=zeros(25,1);
figure('Color','w','Position',[100,100,350,300])
for i =1:5
    scatter(PMI{i},percentagePerAnimal(i,:),'filled','MarkerFaceColor',[0.6,0.6,0.6])
    PMIs((i-1)*5+1:i*5)=PMI{i}';
    RMIall((i-1)*5+1:i*5)=facPerNum(i,:);
    differences((i-1)*5+1:i*5)=difference{i}';
    hold on
end
xline(0,'k--')
xlabel ('Pupil Modulation Index')
ylabel('Facilitated Boutons [%]')
% xlim([-0.1,0.7])
figure('Color','w','Position',[100,100,350,300])
for i =1:5
    scatter(difference{i},percentagePerAnimal(i,:),'filled','MarkerFaceColor',[0.6,0.6,0.6])
    hold on
end
xline(0,'k--')
xlabel ('Difference in pupil size')
ylabel('Facilitated Boutons [%]')
% xlim([-0.07,0.15])
%% Comulative
figure('color','w','Position',[100,100,350,250])
for i=[1:5]
    a=sort(OFF_RMIs{1,i});
    a_x=linspace(1,100,length(OFF_RMIs{1,i}));
    xlabel('RMI')
    scatter(a,a_x,35,'.')
    hold on
end
xline(0,'--k')
legend({'1','2','3','4','5',''},'Location','best')
legend box off
