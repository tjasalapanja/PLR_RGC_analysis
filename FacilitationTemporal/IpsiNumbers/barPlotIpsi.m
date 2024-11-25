cmap=[255,198,30;175,88,186;0,205,108]./255;
RQI055=RQIcalculation(allROI055);
RQI2=RQIcalculation(allROI2);
ipsi055=length(find(RQI055(:,3)>0.3));
ipsi2=length(find(RQI2(:,3)>0.3));
percentage(1)=(100*ipsi055)./length(allROI055);
percentage(2)=(100*ipsi2)./length(allROI2);
count=1;
ipsiPercentage055=zeros(10,1);
cumsum055=cumsum(Num055);
for i=1:10
    it=length(find(RQI055(count:cumsum055(i),3)>0.3));
    ipsiPercentage055(i)=100*it./size(RQI055(count:cumsum055(i),:),1);
    count=cumsum055(i)+1;
end
count=1;
ipsiPercentage2=zeros(6,1);
cumsum2=cumsum(Num2);
for i=1:6
    it=length(find(RQI2(count:cumsum2(i),3)>0.3));
    ipsiPercentage2(i)=100*it./size(RQI2(count:cumsum2(i),:),1);
    count=cumsum2(i)+1;
end
figure('Color','w','Position',[100,100,200,250])
bar(percentage)
hold on
scatter(1,ipsiPercentage055)
scatter(2,ipsiPercentage2)
xticklabels({'0.55Hz','2Hz'})
ylabel('ipsi responding [%]')
box off