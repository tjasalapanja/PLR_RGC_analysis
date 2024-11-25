cmap=[0,205,108]./255;
cmapLight=0.5+(cmap*0.5);
cmapPlot=[cmap;cmapLight;0.4,0.4,0.4];
allDataPre=preTTX(classPre)%allDataPre(offPre);
allDataPost=postTTX(classPost)%allDataPost(offPost);
% mean during - mean background for each response
bacgr_removed=zeros(1,length(allDataPre));
for i =1:length(allDataPre)
    b=max(allDataPre(i).mean_flash(1:flashParams.framesBeforeFlash,3));
    d=max(allDataPre(i).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3));
    bacgr_removed(i)=d-b;
end
bacgr_removedPost=zeros(1,length(allDataPost));
for i =1:length(allDataPost)
    b=max(allDataPost(i).mean_flash(1:flashParams.framesBeforeFlash,3));
    d=max(allDataPost(i).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash,3));
    bacgr_removedPost(i)=d-b;
end
bacgr_removedCtrl=zeros(1,length(allDataPre));
for i =1:length(allDataPre)
    b=max(allDataPre(i).mean_flash(1:flashParams.framesBeforeFlash,3));
    d=max(allDataPre(i).mean_flash(flashParams.framesBeforeFlash+flashParams.framesDuringFlash+20:flashParams.framesBeforeFlash+flashParams.framesDuringFlash+flashParams.framesAfterFlash,3));
    bacgr_removedCtrl(i)=d-b;
end


test.a=bacgr_removed;
test.b=bacgr_removedPost;
test.c=bacgr_removedCtrl;
xnames={'preTTX','postTTX','bcgr.'};
figure('Color','w','Position',[100,100,400,600])
violinplot(test,xnames,'ViolinColor',cmapPlot,'EdgeColor',[0.3,0.3,0.3],'BoxColor',[0.3,0.3,0.3])
% ylim([0,0.7])
hold on
yline(0,'--','Linewidth',1)
xlim([0.2,3.8])
xticklabels({'pre TTX','Post TTX','Bckg.'})
% yticks([-0.2,0,0.2,0.4,0.6])
ylabel('\Delta max Ipsi dF/F')
box off
ax=gca;
ax.Color='w';
ax.YColor = 'w';
ax.XColor ='w';