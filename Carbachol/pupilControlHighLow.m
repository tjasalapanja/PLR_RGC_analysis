cmap=[255,198,30;175,88,186;0,205,108]./255;
figure('Color','w','Position',[100,100,400,500])
tiledlayout(9,2,'TileSpacing','tight','Padding','compact')
% Pattern
nexttile(1)
plotSeq(flashParams)
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';
nexttile(2)
plotSeq(flashParams)
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% popLowPre
nexttile(3,[4,1])
% pcaLow=lowContrastPCA(lowPost,2);
% classROI=lowPost(pcaLow.clsKmeans==2,:);
populationResponse(OFFlowPre,flashParams,cmap,[1:2],0.05,2,[-0.5,1.2]);
xticks([0,5])
yticks([-0.5,0,0.5]) 
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
% popLowPost
nexttile(4,[4,1])
% pcaHigh=lowContrastPCA(highPost,2);
% classROI=highPost(pcaHigh.clsKmeans==2,:);
populationResponse(OFFhighPre,flashParams,cmap,[1:2],0.05,2,[-0.5,1.2]);
xticks([0,5])
yticks([-0.5,0,0.5]) 
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
xlabel('')
ylabel('')
% popLowPost
nexttile(11,[4,1])
populationResponse(OFFlowPost,flashParams,cmap,[1:2],0.05,2,[-0.5,1.2]);
xticks([0,5])
yticks([-0.5,0,0.5]) 
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
xlabel('')
ylabel('')
% popLowPost
nexttile(12,[4,1])
populationResponse(OFFhighPost,flashParams,cmap,[1:2],0.05,2,[-0.5,1.2]);
xticks([0,5])
yticks([-0.5,0,0.5]) 
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
xlabel('')
ylabel('')


