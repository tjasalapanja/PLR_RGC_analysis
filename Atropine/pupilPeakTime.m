cmap=ones(3)*0.4;
% RespondingDuring
[ipsiDuringResponding]=findDuring(offROI,0.3,3);
[contraDuringResponding]=findDuring(offROI,0.3,2);
peakTimes=zeros(length(offROI),3);
peakHeight=zeros(length(offROI),3);
len=31:92;
for roi=1:length(offROI)
    [peakHeight(roi,:),peakTimes(roi,:)]=max(abs(offROI(roi).mean_flash(len,:)));
end
figure('Color','w','Position',[100,100,300,500])
tiledlayout(7,1,"TileSpacing","compact","Padding","compact")
nexttile(1)
stim_before = zeros(1, flashParams3.framesBeforeFlash);
stim_during = ones(1, flashParams3.framesDuringFlash); 
stim_after = zeros(1, flashParams3.framesAfterFlash);
seq = [stim_before, stim_during, stim_after];
seconds = (([1:length(seq)]./flashParams3.FRAMERATE)-(flashParams3.framesBeforeFlash./flashParams3.FRAMERATE));  
plot(seconds,seq,'LineWidth',1.5,'Color',[0.2,0.2,0.2])
xlim([-1,4])
ax=gca;
ax.Color='w';
ax.XColor ='w';
ax.YColor ='w';
nexttile(2,[3,1])

yyaxis left
histogram(peakTimes(ipsiDuringResponding,3)./15.49-1,[-1:0.1:7],'FaceColor',[0,205,108]./255,'EdgeColor',[0,0.7,0.32])
hold on
yyaxis right
plotOnePupil(LL3,flashParams3,cmap,[-0.15,0.1],[3],0.05,1.5,0)
ylim([-0.15,0.1])
xlabel('')
xlim([-1,4])
box off
ax=gca;
ax.Color='w';
ax.YAxis(1).Color = 'w';
ax.YAxis(2).Color = 'w';
ax.XColor ='w';
nexttile(5,[3,1])
yyaxis left
histogram(peakTimes(contraDuringResponding,2)./15.49-1,[-1:0.1:7],'FaceColor',[175,88,186]./255,'EdgeColor',([175,88,186]./255)-0.1)
hold on
yyaxis right
plotOnePupil(LL3,flashParams3,cmap,[-0.45,0.1],[2],0.05,1.5,0)
xlim([-1,4])
box off
ax=gca;
ax.Color='w';
ax.YAxis(1).Color = 'w';
ax.YAxis(2).Color = 'w';
ax.XColor ='w';