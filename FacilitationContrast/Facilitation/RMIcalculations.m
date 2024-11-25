% For each contrast level calculate: RMI, RandomRMI, RMI and RandomRMI only
% during the stimulation and percentage facilitated boutons
LLs={OFF2_LL1,OFF2_LL2,OFF2_LL3,OFF2_LL4,OFF2_LL5};
% LLs={OFF1all,OFF2all,OFF3all,OFF4all,OFF5all};
fps={flashParams1,flashParams2,flashParams3,flashParams4,flashParams5};
RMIs=cell(1,5);
RMIfull=cell(1,5);
RMIrandom=cell(1,5);
RMIrandomFull=cell(1,5);
edge=zeros(1,5);
percentage=zeros(1,5);
edgeFull=zeros(1,5);
percentageFull=zeros(1,5);
for i=1:5
    RMI=zeros(length(LLs{i}),1);
    RMIf=zeros(length(LLs{i}),1);
    areaContra=zeros(length(LLs{i}),1); 
    areaBoth=zeros(length(LLs{i}),1); 
    for roi=1:length(LLs{i})
        areaBoth(roi)=trapz(abs(LLs{i}(roi).mean_flash(fps{i}.framesBeforeFlash:fps{i}.framesBeforeFlash+fps{i}.framesDuringFlash,1)));
        areaContra(roi)=trapz(abs(LLs{i}(roi).mean_flash(fps{i}.framesBeforeFlash:fps{i}.framesBeforeFlash+fps{i}.framesDuringFlash,2)));
        RMI(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
        areaBoth(roi)=trapz(abs(LLs{i}(roi).mean_flash(fps{i}.framesBeforeFlash:fps{i}.framesBeforeFlash+fps{i}.framesDuringFlash+fps{i}.framesAfterFlash,1)));
        areaContra(roi)=trapz(abs(LLs{i}(roi).mean_flash(fps{i}.framesBeforeFlash:fps{i}.framesBeforeFlash+fps{i}.framesDuringFlash+fps{i}.framesAfterFlash,2)));
        RMIf(roi)=(areaBoth(roi)-areaContra(roi))/(areaBoth(roi)+areaContra(roi));
    end
    [RMIrandomTemp, edgeTemp]=findRandomRMI(LLs{i},fps{i},0,2);
    RMIrandom{i}=RMIrandomTemp;
    edge(i)=edgeTemp;
    [RMIrandomTemp, edgeTemp]=findRandomRMI(LLs{i},fps{i},1,2);
    RMIrandomFull{i}=RMIrandomTemp;
    edgeFull(i)=edgeTemp;
    RMIs{i}=RMI;
    RMIfull{i}=RMIf;
end
%% Find percentage facilitated
threshold=0.17%mean(edge);
thresholdFull=mean(edgeFull);
percentage=zeros(1,5);
percentageFull=zeros(1,5);
for i=1:5
    f=length(RMIs{i}(RMIs{i}>threshold));
    percentage(i)=(f*100)/(length(RMIs{i}));
    f_full=length(RMIfull{i}(RMIfull{i}>thresholdFull));
    percentageFull(i)=(f_full*100)/(length(RMIfull{i}));
end
%% Percentage per animal
facPerNum=zeros(5,5);
numbers={LL1num,LL2num,LL3num,LL4num,LL5num};
for LL=1:5
    n=cumsum(numbers{LL});
    count=1;
    for animal=1:5
        RMI_temp=RMIs{LL}(count:n(animal));
        f=length(RMI_temp(RMI_temp > threshold));
        facPerNum(LL,animal)=(f*100)/length(RMI_temp);
        count=n(animal)+1;
    end
end
%% Plot
stdRMI=std(facPerNum,[],2);
SEM=stdRMI./sqrt(5);
figure('Color','w','Position',[100,100,400,250])
colorRed=[255,31,91]./255;
colorPaleRed=[0.5,0.5,0.5]+0.3*colorRed;
bar([1:5],percentage,'FaceColor',colorRed,'EdgeColor','none')
hold on
% errorbar([1:5],percentage,SEM,'LineStyle','none','Color',colorPaleRed)
% for i=1:5
%     scatter(i,facPerNum(i,:),25,'filled','o','MarkerFaceColor',colorPaleRed)
% end
xticklabels({'12','20','31','44','65'})
ylabel('% facilitated')
xlabel('LUX')
box off
ylim([0,70])
%% pupil Difference
difference={zeros(length(LL1),1),zeros(length(LL2),1),zeros(length(LL3),1),zeros(length(LL4),1),zeros(length(LL5),1)};
% pupil modulation index
PMI={zeros(length(LL1),1),zeros(length(LL2),1),zeros(length(LL3),1),zeros(length(LL4),1),zeros(length(LL5),1)};
minPupilSizeLL={zeros(length(LL1),3),...
    zeros(length(LL2),3),...
    zeros(length(LL3),3),...
    zeros(length(LL4),3),...
    zeros(length(LL5),3)};
goodPupils={LL1,LL2,LL3,LL4,LL5};
for light=1:5
    pupil=goodPupils{light};
    for animal=1:size(pupil.allMeans,1)
        [sizes,time]=min(pupil.allmeanZscores(animal,:,:));
        minPupilSizeLL{light}(animal,:)=sizes;
        difference{light}(animal)=sizes(:,2)-sizes(:,1);
        PMI{light}(animal)=(sizes(:,1)-sizes(:,2))./(sizes(:,1)+sizes(:,2));
    end
end
%% Scatter pupil difference modulation
PMIs=zeros(25,1);
RMIall=zeros(25,1);
differences=zeros(25,1);
figure('Color','w','Position',[100,100,350,300])
for i =1:5
    scatter(PMI{i},facPerNum(i,:),'filled','MarkerFaceColor',[0.6,0.6,0.6])
    PMIs((i-1)*5+1:i*5)=PMI{i}';
    RMIall((i-1)*5+1:i*5)=facPerNum(i,:);
    differences((i-1)*5+1:i*5)=difference{i}';
    hold on
end
xline(0,'k--')
xlabel ('Pupil Modulation Index')
ylabel('Facilitated Boutons [%]')
xlim([-0.1,0.7])
figure('Color','w','Position',[100,100,350,300])
for i =1:5
    scatter(difference{i},facPerNum(i,:),'filled','MarkerFaceColor',[0.6,0.6,0.6])
    hold on
end
xline(0,'k--')
xlabel ('Difference in pupil size')
ylabel('Facilitated Boutons [%]')
xlim([-0.07,0.15])
%% pupil Difference zscore
difference={zeros(length(LL1),1),zeros(length(LL2),1),zeros(length(LL3),1),zeros(length(LL4),1),zeros(length(LL5),1)};
% pupil modulation index
PMI={zeros(length(LL1),1),zeros(length(LL2),1),zeros(length(LL3),1),zeros(length(LL4),1),zeros(length(LL5),1)};
minPupilSizeLL={zeros(length(LL1),3),...
    zeros(length(LL2),3),...
    zeros(length(LL3),3),...
    zeros(length(LL4),3),...
    zeros(length(LL5),3)};
goodPupils={LL1,LL2,LL3,LL4,LL5};
for light=1:5
    pupil=goodPupils{light};
    for animal=1:size(pupil.allmeanZscores,1)
        [sizes,time]=min(pupil.allmeanZscores(animal,:,:));
        minPupilSizeLL{light}(animal,:)=sizes;
        difference{light}(animal)=sizes(:,2)-sizes(:,1);
        PMI{light}(animal)=(sizes(:,1)-sizes(:,2))./(sizes(:,1)+sizes(:,2));
    end
end
%% Scatter pupil difference modulation
PMIs=zeros(25,1);
RMIall=zeros(25,1);
differences=zeros(25,1);
figure('Color','w','Position',[100,100,350,300])
for i =1:5
    scatter(PMI{i},facPerNum(i,:),'filled','MarkerFaceColor',[0.6,0.6,0.6])
    PMIs((i-1)*5+1:i*5)=PMI{i}';
    RMIall((i-1)*5+1:i*5)=facPerNum(i,:);
    differences((i-1)*5+1:i*5)=difference{i}';
    hold on
end
xline(0,'k--')
xlabel ('Pupil Modulation Index')
ylabel('Facilitated Boutons [%]')
figure('Color','w','Position',[100,100,350,300])
for i =1:5
    scatter(difference{i},facPerNum(i,:),'filled','MarkerFaceColor',[0.6,0.6,0.6])
    hold on
end
xline(0,'k--')
xlabel ('Difference in pupil size')
ylabel('Facilitated Boutons [%]')
