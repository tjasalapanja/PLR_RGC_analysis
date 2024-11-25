figure('Color','w','Position',[100,100,200,500])
tiledlayout(7,1,"TileSpacing","compact","Padding","compact")
nexttile
b=zeros(1,60);
d=ones(1,60);
a=zeros(1,60);
pattern=[b,d,a];
plot(pattern,'k','LineWidth',2)
xlim([1,180])
axis off
nexttile(5,[3,1])
seconds=[1:180]./20-3;
for i=1:18
    plot(seconds,pupilHuman.allZscores(i,1:180),"Color",[0.5,0.5,0.5],'LineWidth',0.8)
    hold on
end
plot(seconds,(mean(pupilHuman.allZscores(:,1:180))),'k','LineWidth',2)
xlim([-3,6])
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2,[3,1])
seconds=[1:141]./15.5-3;
for i=1:25
    plot(seconds,LL2.allZscores(:,i,2),"Color",[0.5,0.5,0.5],'LineWidth',0.8)
    hold on
end
plot(seconds,(mean(LL2.allZscores(:,:,2),2)),'k','LineWidth',2)
xlim([-3,6])
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';