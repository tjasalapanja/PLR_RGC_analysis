cmap=[240,143,110;8,153,126]./255;
areaLL1=zeros(25,2);
areaLL2=zeros(25,2);
areaLL3=zeros(25,2);
areaLL4=zeros(25,2);
areaLL5=zeros(25,2);
for i=1:25
    pupilLL1t=abs(squeeze(LL1.allTraces(47:end,i,1:2)));
    areaLL1(i,:)=max(pupilLL1t);
    pupilLL2t=abs(squeeze(LL2.allTraces(47:end,i,1:2)));
    areaLL2(i,:)=max(pupilLL2t);
    pupil3t=abs(squeeze(LL3.allTraces(47:end,i,1:2)));
    areaLL3(i,:)=max(pupil3t);
    pupilLL4t=abs(squeeze(LL4.allTraces(47:end,i,1:2)));
    areaLL4(i,:)=max(pupilLL4t);
    pupil5t=abs(squeeze(LL5.allTraces(47:end,i,1:2)));
    areaLL5(i,:)=max(pupil5t);
end
PMILL1=(areaLL1(:,1)-areaLL1(:,2))./(areaLL1(:,1)+areaLL1(:,2));
PMILL2=(areaLL2(:,1)-areaLL2(:,2))./(areaLL2(:,1)+areaLL2(:,2));
PMILL3=(areaLL3(:,1)-areaLL3(:,2))./(areaLL3(:,1)+areaLL3(:,2));
PMILL4=(areaLL4(:,1)-areaLL4(:,2))./(areaLL4(:,1)+areaLL4(:,2));
PMILL5=(areaLL5(:,1)-areaLL5(:,2))./(areaLL5(:,1)+areaLL5(:,2));

mLL1=mean(PMILL1);
mLL2=mean(PMILL2);
mLL3=mean(PMILL3);
mLL4=mean(PMILL4);
mLL5=mean(PMILL5);

semLL1=std(PMILL1)./sqrt(length(PMILL1));
semLL2=std(PMILL2)./sqrt(length(PMILL2));
semLL3=std(PMILL3)./sqrt(length(PMILL3));
semLL4=std(PMILL4)./sqrt(length(PMILL4));
semLL5=std(PMILL5)./sqrt(length(PMILL5));


figure('Color','w','Position',[100,100,300,450])
b=bar([1:5],[mLL1,mLL2,mLL3,mLL4,mLL5],'EdgeColor','flat');
% b.FaceColor = 'flat';
% b.CData(1,:) = cmap(1,:);
% b.CData(2,:) = cmap(2,:);
hold on
errorbar([1:5],[mLL1,mLL2,mLL3,mLL4,mLL5],[semLL1,semLL2,semLL3,semLL4,semLL5],'k','LineStyle','none','LineWidth',0.8)
xticks([1:5])
ylabel('LUX')
scatter([1:5],[PMILL1,PMILL2,PMILL3,PMILL4,PMILL5],30,'.k')
xticklabels({'12.3','20','30','44','65'})
yticks([-0.1,0,0.1,0.2,0.3])
ylim([-0.1,0.3])
box off
title('AreaBased PMI')
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';