[~,ipsiResponding]=findIpsiZscore(allTogether,3,0.3);
OFF=find(pca.clsKmeans==1);
% Per location
location=1:10;
animal=[1,1,1,2,2,3,3,4,5,5];
NumIpsi=zeros(1,10);
OFFloc=zeros(1,10);
count=0;
before=0;
for i=1:10
roi=before+1:before+Num(i);
off_temp=intersect(roi,OFF);
OFFloc(i)=length(off_temp);
offIpsi=intersect(off_temp,ipsiResponding);
    if ~isempty(offIpsi)
        NumIpsi(i)=length(offIpsi);
    end
before=before+length(roi);
end
offIpsi_percentage=NumIpsi*100./OFFloc;
% Per animal
NumAnimal=zeros(1,5);
NumIpsiAnimal=zeros(1,5);
for i=1:5
   a=find(animal==i);
   NumIpsiAnimal(i)=sum(NumIpsi(a));
   NumAnimal(i)=sum(OFFloc(a));
end
PercentIpsiAnimal=NumIpsiAnimal*100./NumAnimal;
PercentageAll=sum(NumIpsi)*100./sum(OFFloc);
% stdev chose which
stdev=std(offIpsi_percentage);
stdevAnimal=std(PercentIpsiAnimal);
% Plot
colorBlue=[0,154,222]./255;
colorBlueFace=colorBlue+0.1*colorBlue;
colorBlueEdge=colorBlue-0.4*colorBlue;
figure('Color','w','Position',[100,100,150,200]);
bar(1,PercentageAll,'Facecolor',colorBlueFace,'EdgeColor',colorBlueEdge)
hold on
errorbar(1,PercentageAll,stdev,'Color',colorBlueEdge)
hold on
scatter(1,offIpsi_percentage,10,'filled','MarkerFaceColor',[0.6,0.6,0.6],'MarkerEdgeColor',[0.4,0.4,0.4])
scatter(1,PercentIpsiAnimal,5,'filled','MarkerFaceColor',[0.2,0.2,0.2],'MarkerEdgeColor',[0,0,0])
ylim([0,100])
yticks([0,25,75,100])
ylabel('OFF ipsi percentage [%]')
xticks([])
box off