[~,ipsiResponding]=findIpsiZscore(allTogether,3,0.3);
NumIpsi=zeros(2,10);
typeloc=zeros(2,10);
NumAnimal=zeros(2,5);
NumIpsiAnimal=zeros(2,5);
location=1:10;
animal=[1,1,1,2,2,3,3,4,5,5];
for c=1:2
    type=find(pca.clsKmeans==c);
    % Per location
    count=0;
    before=0;
    for i=1:10
    roi=before+1:before+Num(i);
    off_temp=intersect(roi,type);
    typeloc(c,i)=length(off_temp);
    typeIpsi=intersect(off_temp,ipsiResponding);
        if ~isempty(typeIpsi)
            NumIpsi(c,i)=length(typeIpsi);
        end
    before=before+length(roi);
    end
    % Per animal
    for i=1:5
       a=find(animal==i);
       NumIpsiAnimal(c,i)=sum(NumIpsi(c,a));
       NumAnimal(c,i)=sum(typeloc(c,a));
    end
end
typeIpsi_percentage=NumIpsi*100./typeloc;
PercentIpsiAnimal=NumIpsiAnimal*100./NumAnimal;
PercentageAll=sum(NumIpsi,2)*100./sum(typeloc,2);
stdev=std(typeIpsi_percentage,[],2,['omitnan']);
stdevAnimal=std(PercentIpsiAnimal,[],2,'omitnan');
colorBlue=[0,154,222]./255;
colorBlueFace=colorBlue+0.1*colorBlue;
colorBlueEdge=colorBlue-0.4*colorBlue;
figure('Color','w','Position',[100,100,150,200]);
bar([1,2],PercentageAll,'Facecolor',colorBlueFace,'EdgeColor',colorBlueEdge)
hold on
errorbar([1,2],PercentageAll,stdevAnimal,'Color',colorBlueEdge,'LineStyle','none')
xticklabels({'OFF','ON'})
box off
% for i=1:10
%     scatter(1,typeIpsi_percentage(1,i),15,'filled','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.3,0.3,0.3])
%     if ~(isnan(typeIpsi_percentage(2,i)))
%         scatter(2,typeIpsi_percentage(2,i),15,'filled','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.3,0.3,0.3])
%         line([1,2],[typeIpsi_percentage(1,i),typeIpsi_percentage(2,i)],'color',[0.5,0.5,0.5])
%     end
% end
for i=1:5
    scatter(1,PercentIpsiAnimal(1,i),15,'filled','MarkerFaceColor',[0.1,0.1,0.1],'MarkerEdgeColor',[0.1,0.1,0.1])
    if ~(isnan(PercentIpsiAnimal(2,i)))
        scatter(2,PercentIpsiAnimal(2,i),15,'filled','MarkerFaceColor',[0.1,0.1,0.1],'MarkerEdgeColor',[0.1,0.1,0.1])
        line([1,2],[PercentIpsiAnimal(1,i),PercentIpsiAnimal(2,i)],'color',[0.1,0.1,0.1])
    end
end