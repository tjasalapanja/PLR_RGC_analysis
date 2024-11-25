PMI=zeros(5,5);
a=squeeze(abs(min(LL1.allMeans,[],2)));
PMI(1,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL2.allMeans,[],2)));
PMI(2,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL3.allMeans,[],2)));
PMI(3,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL4.allMeans,[],2)));
PMI(4,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL5.allMeans,[],2)));
PMI(5,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';

m=mean(PMI,2);
s=std(PMI,[],2)./sqrt(5);
figure()
for a=1:5
    scatter([1:5],m,50,'k','filled')
    errorbar([1:5],m,s,'k','LineStyle','none')
    hold on
end
xlim([0,6])
yline(0)

%% All data (all repeats)
PMI2=zeros(5,25);
a=squeeze(abs(min(LL1.allTraces,[],1)));
PMI2(1,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL2.allTraces,[],1)));
PMI2(2,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL3.allTraces,[],1)));
PMI2(3,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL4.allTraces,[],1)));
PMI2(4,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
a=squeeze(abs(min(LL5.allTraces,[],1)));
PMI2(5,:)=((a(:,1)-a(:,2))./(a(:,1)+a(:,2)))';
cmap=crameri('roma',6);
cmap(1,:)=[];
m2=mean(PMI2,2);
s2=std(PMI2,[],2)./5;

figure('Color','w','Position',[100,100,300,400])
for a=1:5
    bar([1:5],m2)
    hold on
    errorbar([1:5],m2,s2,'k','LineStyle','none')  
    scatter([1:5],PMI2(:,a*5-4:a*5),30,'k.')
end
xlim([0,6])
yline(0)
xticks([0:5])
xticklabels({'','12.3','20','31','44','65'})
ylabel('PMI')
xlabel('LUX')
title('Binocular pupil modulation maxPeak')
box off
p=zeros(5,1);
for a=1:5
    [~,p(a)]=ttest(PMI2(a,:))
end
