[~,ipsiPre]=findIpsiZscore(allDataPre,3,0.3);
[~,ipsiPost]=findIpsiZscore(allDataPost,3,0.3);
location=1:3;
NumIpsi=zeros(2,3);
OFFloc=zeros(2,3);
count=0;
before=0;
OFF=1:length(allDataPre);
for i=1:3
roi=before+1:before+NumPre(i);
off_temp=intersect(roi,OFF);
OFFloc(1,i)=length(off_temp);
offIpsi=intersect(off_temp,ipsiPre);
    if ~isempty(offIpsi)
        NumIpsi(1,i)=length(offIpsi);
    end
before=before+length(roi);
end
OFF=1:length(allDataPost);
count=0;
before=0;
for i=1:3
roi=before+1:before+NumPost(i);
off_temp=intersect(roi,OFF);
OFFloc(2,i)=length(off_temp);
offIpsi=intersect(off_temp,ipsiPost);
    if ~isempty(offIpsi)
        NumIpsi(2,i)=length(offIpsi);
    end
before=before+length(roi);
end
offIpsi_percentage=NumIpsi*100./OFFloc;
stdev=std(offIpsi_percentage,[],2)./sqrt(3); %SEM
percentageAll=[length(ipsiPre),length(ipsiPost)]*100./[length(allDataPre),length(allDataPost)];
colorBlue=[0,154,222]./255;
colorBlueFace=colorBlue+0.1*colorBlue;
colorBlueEdge=colorBlue-0.4*colorBlue;
figure('Color','w','Position',[100,100,200,250]);
bar([1,2],percentageAll,'Facecolor',colorBlueFace,'EdgeColor',colorBlueEdge)
hold on
errorbar([1,2],percentageAll,stdev,'Color',colorBlueEdge,'LineStyle','none')
xticklabels({'preTTX','postTTX'})
box off
for i=1:3
    scatter(1,offIpsi_percentage(1,i),15,'filled','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.3,0.3,0.3])
    if ~(isnan(offIpsi_percentage(2,i)))
        scatter(2,offIpsi_percentage(2,i),15,'filled','MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor',[0.3,0.3,0.3])
        line([1,2],[offIpsi_percentage(1,i),offIpsi_percentage(2,i)],'color',[0.5,0.5,0.5])
    end
end
xlim([0.3,2.8])
ylabel('Ipsi percentage [%]')