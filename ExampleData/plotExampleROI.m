%% Plot example
cmap=[255,198,30;175,88,186;0,205,108]./255;% yellow both, violet contra, green ipsi
cmap2=[252,141,98;102,194,165;141,160,203]./255;% orange both, green contra, violet ipsi
for roi=16%53;%OFF boutons 48,53  %455,423
    example=figure('Color','w','Position',[100,100,200,600]);
    tiledlayout(9,1,"TileSpacing","tight","Padding","compact")
    nexttile(1)
    plotSeq(flashParams)
    ax=gca;
    ax.Color='w';
    ax.YColor = 'w';
    ax.XColor ='w';
    nexttile(2,[4,1])
    lims=[-0.7,4];% OFF [-0.1,4.5],ON1=[-0.8,0.9],ON2=[0,6,0.9]
    plotOneSEM(allROI(roi),flashParams,cmap,lims,[2],0.05,1.5) %[2:3] or [1:3], SEM or SD
    ylabel('dF/F')
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    
    nexttile(6,[4,1])
    lims=[-0.7,4];% OFF [-0.1,4.5],ON1=[-0.8,0.9],ON2=[0,6,0.9]
    plotOneSEM(allROI(roi),flashParams,cmap,lims,[3],0.05,1.5) %[2:3] or [1:3], SEM or SD
    ylabel('dF/F')
%     ax=gca;
%     ax.Color='w';
%     ax.YColor = 'w';
%     ax.XColor ='w';
    saveas(example,['example.tif'])
end
