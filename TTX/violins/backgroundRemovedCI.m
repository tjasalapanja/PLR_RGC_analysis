cmap=[0,205,108]./255;
cmapLight=0.5+(cmap*0.5);
cmapPlot=[cmap;cmapLight];
allDataPre=allDataPre(offPre);
allDataPost=allDataPost(offPost);
% mean during - mean background for each response
bacgr_removed=zeros(length(allDataPre),3);
for i =1:length(allDataPre)
    b=mean(allDataPre(i).mean_flash(1:flashParams.framesBeforeFlash));
    d=mean(allDataPre(i).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash));
    bacgr_removed(i)=d-b;
end
bacgr_removedPost=zeros(length(allDataPost),3);
for i =1:length(allDataPost)
    b=mean(allDataPost(i).mean_flash(1:flashParams.framesBeforeFlash));
    d=mean(allDataPost(i).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash));
    bacgr_removedPost(i)=d-b;
end
bcgr_removed_ctrl=zeros(length(allDataPost),3);
for i =1:length(allDataPost)
    b=mean(allDataPost(i).mean_flash(1:flashParams.framesBeforeFlash));
    d=mean(allDataPost(i).mean_flash(flashParams.framesBeforeFlash+1:flashParams.framesBeforeFlash+flashParams.framesDuringFlash));
    bacgr_removed_ctrl(i)=d-b;
end
test.a=bacgr_removed;
test.b=bacgr_removedPost;
xnames={'preTTX','postTTX'};
figure('Color','w','Position',[100,100,200,300])
violinplot(test,xnames,'ViolinColor',cmapPlot,'EdgeColor',cmap,'BoxColor',[0.3,0.3,0.3])
% ylim([0,0.7])
hold on
yline(0,'--')
xlim([0.2,2.8])
xticklabels({'pre TTX','Post TTX'})
yticks([-0.2,0,0.2,0.4,0.6])
ylabel('\Delta mean dF/F')
box off