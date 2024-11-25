colorRed=[255,31,91]./255;
colorBlue=[0,154,222]./255;
fs=15.49; % human data is originally at 20Hz, resampled at 15.49
fttArea055Mouse=zeros(5,2);
fttArea2Mouse=zeros(3,2);
fttArea055Human=zeros(3,2);
fttArea2Human=zeros(3,2);
fttAreaShuffle=zeros(5,2);
for i=1:5
    % shuffle mouse055
    x = pupil055.mean_pupil(i,326:750,1);
    y = fft(x);
    f = (0:length(y)-1)*fs/length(y);
    data=abs(y(f>0.25&f<10));
    f=f(f>0.25&f<10);
    sData=data(randperm(length(data)));
    rng(0);fttAreaShuffle(i,1)=trapz(sData(f>0.45&f<0.65));
    rng(0);fttAreaShuffle(i,2)=trapz(sData(f>0.2&f<7.745));
    % mouse055
    x = pupil055.mean_pupil(i,326:750,1);
    y = fft(x);
    f = (0:length(y)-1)*fs/length(y);
    fttArea055Mouse(i,1)=trapz(abs(y(f>0.45&f<0.65)));
    fttArea055Mouse(i,2)=trapz(abs(y(f>0.2&f<7.745)));
    if i<4
        % human055
        x = resample(allPupil055Human.meanAll(i,101:500,1),1549,2000);
        y = fft(x);
        f = (0:length(y)-1)*fs/length(y);
        fttArea055Human(i,1)=trapz(abs(y(f>0.45&f<0.65)));
        fttArea055Human(i,2)=trapz(abs(y(f>0.2&f<7.745)));
        % mouse2
        x = pupil2.mean_pupil(i,94:2*93,1);
        y = fft(x);
        f = (0:length(y)-1)*fs/length(y);
        fttArea2Mouse(i,1)=trapz(abs(y(f>1.9&f<2.1)));
        fttArea2Mouse(i,2)=trapz(abs(y(f>0.2&f<7.745)));
        % human2
        x = resample(allPupil055Human.meanAll(i,101:183,1),1549,1000);
        y = fft(x);
        f = (0:length(y)-1)*fs/length(y);
        fttArea2Human(i,1)=trapz(abs(y(f>1.9&f<2.1)));
        fttArea2Human(i,2)=trapz(abs(y(f>0.2&f<7.745)));
    end
end
ratioShuffle=fttAreaShuffle(:,1)./fttAreaShuffle(:,2)*100;
ratio055Mouse=fttArea055Mouse(:,1)./fttArea055Mouse(:,2)*100;
ratio2Mouse=fttArea2Mouse(:,1)./fttArea2Mouse(:,2)*100;
ratio055Human=fttArea055Human(:,1)./fttArea055Human(:,2)*100;
ratio2Human=fttArea2Human(:,1)./fttArea2Human(:,2)*100;

figure('Color','w','Position',[100,100,300,350])
scatter(1,ratioShuffle,'filled','MarkerFaceColor',[0.7,0.7,0.7])
hold on
scatter(1,mean(ratioShuffle),150,'Marker','_','MarkerEdgeColor','k','LineWidth',2)
scatter(2,ratio2Mouse,'filled','MarkerFaceColor',colorRed)
scatter(2,mean(ratio2Mouse),150,'Marker','_','MarkerEdgeColor','k','LineWidth',2)
scatter(3,ratio2Human,'filled','MarkerFaceColor',colorRed)
scatter(3,mean(ratio2Human),150,'Marker','_','MarkerEdgeColor','k','LineWidth',2)
scatter(4,ratio055Mouse,'filled','MarkerFaceColor',colorBlue)
scatter(4,mean(ratio055Mouse),150,'Marker','_','MarkerEdgeColor','k','LineWidth',2)
scatter(5,ratio055Human,'filled','MarkerFaceColor',colorBlue)
scatter(5,mean(ratio055Human),150,'Marker','_','MarkerEdgeColor','k','LineWidth',2)
xlim([0,6])
xticks([1:5])
xticklabels({'shuffled','2Hz mouse','2Hz human','0.55Hz mouse','0.55Hz human'})
yticks([25,50])
ylim([0,52])
ylabel(['% of power sp. density at stim freq +-0.1'])
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
%%
ratios=[ratioShuffle;ratio2Mouse;ratio2Human;ratio055Mouse;ratio055Human]';
labels={'shuffle','shuffle','shuffle','shuffle','shuffle','2m','2m','2m','2h','2h','2h','055m','055m','055m','055m','055m','055h','055h','055h'}
[p,tbl,stats]=anova1(ratios,labels)
[c,~,~,gnames]=multcompare(stats)
tbl = array2table(c,"VariableNames", ...
["Group A","Group B","Lower Limit","A-B","Upper Limit","P-value"]);
tbl.("Group A") = gnames(tbl.("Group A"));
tbl.("Group B") = gnames(tbl.("Group B"))
