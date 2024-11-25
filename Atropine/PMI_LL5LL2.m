cmap=[240,143,110;8,153,126]./255;
areaLL2=zeros(25,2);
areaLL5=zeros(25,2);
for i=1:25
    pupilLL5t=abs(squeeze(LL5.allTraces(47:end,i,1:2)));
    areaLL5(i,:)=max(pupilLL5t);
    pupil2t=abs(squeeze(LL2.allTraces(47:end,i,1:2)));
    areaLL2(i,:)=max(pupil2t);
end
PMILL5=(areaLL5(:,1)-areaLL5(:,2))./(areaLL5(:,1)+areaLL5(:,2));
PMILL2=(areaLL2(:,1)-areaLL2(:,2))./(areaLL2(:,1)+areaLL2(:,2));
mLL2=mean(PMILL2);
mLL5=mean(PMILL5);
semLL5=std(PMILL5)./sqrt(length(PMILL5));
semLL2=std(PMILL2)./sqrt(length(PMILL2));

figure('Color','w','Position',[100,100,300,450])
b=bar([1,2],[mLL2,mLL5],'EdgeColor','flat');
b.FaceColor = 'flat';
b.CData(1,:) = cmap(1,:);
b.CData(2,:) = cmap(2,:);
hold on
errorbar([1,2],[mLL2,mLL5],[semLL5,semLL5],'k','LineStyle','none','LineWidth',0.8)
xticks([])
% xticklabels({'2Hz','0.55Hz'})
yticks([-0.1,0,0.1,0.2,0.3])
ylim([-0.1,0.3])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';