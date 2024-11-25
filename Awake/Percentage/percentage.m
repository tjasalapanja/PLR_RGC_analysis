[~,ipsiResponding]=findIpsiZscore(allTogether,3,0.3);
location=1:10;
animal=[1,1,1,2,2,3,3,4,5,5];
NumIpsi=zeros(1,10);
count=0;
before=0;
for i=1:10
    count=count+Num(i);
    ipsiNums=length(find(ipsiResponding<=count));
    ipsiLoc=ipsiNums-before;
    before=before+ipsiLoc;
    NumIpsi(i)=ipsiLoc;
end
PercentIpsi=NumIpsi*100./Num;
NumAnimal=zeros(1,5);
NumIpsiAnimal=zeros(1,5);
for i=1:5
   a=find(animal==i);
   NumIpsiAnimal(i)=sum(NumIpsi(a));
   NumAnimal(i)=sum(Num(a));
end
PercentIpsiAnimal=NumIpsiAnimal*100./NumAnimal;
PercentageAll=length(ipsiResponding)*100./length(allTogether);
stdev=std(PercentIpsi);
stdevAnimal=std(PercentIpsiAnimal); % if you plot animal per animal
colorBlue=[0,154,222]./255;
colorBlueFace=colorBlue+0.1*colorBlue;
colorBlueEdge=colorBlue-0.4*colorBlue;
figure('Color','w','Position',[100,100,150,200]);
bar(1,PercentageAll,'Facecolor',colorBlueFace,'EdgeColor',colorBlueEdge)
hold on
errorbar(1,PercentageAll,stdevAnimal,'Color',colorBlueEdge)
hold on
% scatter(1,PercentIpsi,10,'filled','MarkerFaceColor',[0.6,0.6,0.6],'MarkerEdgeColor',[0.4,0.4,0.4])
scatter(1,PercentIpsiAnimal,5,'filled','MarkerFaceColor',[0.2,0.2,0.2],'MarkerEdgeColor',[0,0,0])
ylim([0,100])
yticks([0,25,75,100])
ylabel('ipsi percentage [%]')
xticks([])
box off
