for candidate=[82 152 154 165]% Awake055 82 152 154 165 Awake2 2 4 49 54 124 160 208 211
figure('Color','w','Position',[100,100,200,200])
tiledlayout(4,1,"TileSpacing","compact","Padding","compact")
nexttile(1,[3,1])
plotOne(allROI055Hz(candidate),slowParams055Hz,cmap,[-0.8,2.8],[1:2])
yticks([])
title('2 Hz')
axis off
nexttile(4,[1,1])
plotSlowPattern055(slowParams055Hz)
axis off
count=count+1;
end