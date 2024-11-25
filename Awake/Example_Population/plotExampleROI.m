%% Plot example
cmap=[255,198,30;175,88,186;0,205,108]./255;% yellow both, violet contra, green ipsi
cmap2=[252,141,98;102,194,165;141,160,203]./255;% orange both, green contra, violet ipsi
for roi=[22]%OFF boutons 22   %455,423 717
    example=figure('Color','w','Position',[100,100,200,300]);
    lims=[-0.8,1];% OFF [-0.1,4.5],ON1=[-0.8,0.9],ON2=[0,6,0.9]
    plotOneSEM(respondingROI(roi),flashParams,cmap,lims,[2:3],0.05,1) %[2:3] or [1:3], SEM or SD
    ylabel('dF/F')
    xticks([0,5])
    yticks([0,0.5,1])

end