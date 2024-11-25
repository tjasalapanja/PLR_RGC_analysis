colorRed=[255,31,91]./270;
colorBlue=[0,154,222]./270;
Ts = 1/15.49;
Ts2=1/20;
times = linspace(0, 6, 325);  
scale=times/2;
scaledIntensity055=[];
for i =1:length(times)
    intensities=sin(12*times(i));
    scaledIntensity055=[scaledIntensity055,intensities*scale(i)];
end
times = linspace(0, 6, 93);  
scale=times/2;
scaledIntensity2=[];
for i =1:length(times)
    intensities=sin(12*times(i));
    scaledIntensity2=[scaledIntensity2,intensities*scale(i)];
end
figure('Color','w','Position',[100,100,600,600]);
% profile of stimulus 055Hz
subplot(5,2,1)
y = fft(scaledIntensity055);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(0.55,'k--')
xlim([0,5])
xticks([])
ylabel('|fft(stimulus)|')
ylim([0,200])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% profile of stimulus 2Hz
subplot(5,2,2)
y = fft(scaledIntensity2);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(2,'k--')
xlim([0,10])
ylim([0,200])
xticks([])
yticks([])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% mouse 0.55Hz
subplot(5,2,[3,5])
for i=1:30
    x = pupil055.all_pupil(326:750,i,1);
    y = fft(x);
    fs = 1/Ts;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',colorBlue)
    hold on
    xlim([0,5])
    ylim([0,50])
end
y = fft(mean(pupil055.mean_pupil(:,326:750,1)));
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(0.55,'k--')
xticks([])
ylim([0,100])
yticks([0.2,10,100])
set(gca, 'YScale', 'log')
ylabel('log|psd(mouse pupil size)|')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% mouse 055 zoom in 
hax = axes('Position', [.28, .60, .15, .15]);
for i=1:30
    x = pupil055.all_pupil(326:750,i,1);
    y = fft(x);
    fs = 1/Ts;
    f = (0:length(y)-1)*fs/length(y);
    plot(hax,f,abs(y),'Color',colorBlue)
    hold on
    xlim([0,5])
end
y = fft(mean(pupil055.mean_pupil(:,326:750,1)));
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(hax,f,abs(y),'Color','k','LineWidth',1)
xline(0.55,'k--')
xlim([0.2,1])
ylim([-1,15])
xticks([0.25,0.55,0.85])
%set(gca, 'YScale', 'log')
yticks([0,15])
ylabel('|psd(mouse)|')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% human 055
subplot(5,2,[7,9])
for i=1:14
    x = allPupil055Human.allData(i,101:500,1);
    y = fft(x);
    fs = 1/Ts2;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',colorBlue)
    hold on
    xlim([0,5])
end
y = fft(allPupil055Human.mean(101:500));
fs = 1/Ts2;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1);
xline(0.55,'k--')
set(gca, 'YScale', 'log')
ylabel('log|psd(human pupil size)|')
xlabel('frequency [Hz]')
yticks([1,50,1000])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% human 055 zoom in
hax = axes('Position', [.28, .25, .15, .15]);
for i=1:14
    x = allPupil055Human.allData(i,101:500,1);
    y = fft(x);
    fs = 1/Ts2;
    f = (0:length(y)-1)*fs/length(y);
    plot(hax,f,abs(y),'Color',colorBlue)
    hold on
    xlim([0,5])
end
y = fft(allPupil055Human.mean(101:500));
fs = 1/Ts2;
f = (0:length(y)-1)*fs/length(y);
plot(hax,f,abs(y),'Color','k','LineWidth',1);
xline(0.55,'k--')
xlim([0.2,1])
xticks([0.25,0.55,0.85])
%set(gca, 'YScale', 'log')
yticks([0,45])
ylim([-3,45])
ylabel('|psd(human)|')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% mouse 2
subplot(5,2,[4,6])
for i=1:17
    x = pupil2.all_pupil(94:2*93,i,1);
    y = fft(x);
    fs = 1/Ts;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',colorRed)
    hold on
    xlim([0,10])
    yticks([])
    xticks([])
end
y = fft(mean(pupil2.mean_pupil(:,94:2*93,1)));
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(2,'k--')
set(gca, 'YScale', 'log')
ylim([0,100])
yticks([0.2,10,100])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% mouse 2 zoom in
hax = axes('Position', [.75, .60, .15, .15]);
for i=1:17
    x = pupil2.all_pupil(94:2*93,i,1);
    y = fft(x);
    fs = 1/Ts;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',colorRed)
    hold on
    xlim([0,10])
end
y = fft(mean(pupil2.mean_pupil(:,94:2*93,1)));
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(2,'k--')
xlim([1.7,2.3])
%set(gca, 'YScale', 'log')
ylim([-1,15])
yticks([0,15])
ylabel('|psd(mouse)|')
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% human 2
subplot(5,2,[8,10])
for i=1:15
    x = allPupil2Human.allData(i,101:183);
    y = fft(x);
    fs = 1/Ts2;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',colorRed)
    hold on
    xlim([0,10])
    yticks([])
end
y = fft(allPupil2Human.mean(101:183));
fs = 1/Ts2;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1);
xline(2,'k--')
xlabel ('frequency [Hz]')
set(gca, 'YScale', 'log')
ylim([0,1000])
yticks([1,50,1000])
box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';

% human2 zoom in
hax = axes('Position', [.75, .25, .15, .15]);
for i=1:15
    x = allPupil2Human.allData(i,101:183);
    y = fft(x);
    fs = 1/Ts2;
    f = (0:length(y)-1)*fs/length(y);
    plot(hax,f,abs(y),'Color',colorRed)
    hold on
    xlim([0,10])
end
y = fft(allPupil2Human.mean(101:183));
fs = 1/Ts2;
f = (0:length(y)-1)*fs/length(y);
plot(hax,f,abs(y),'Color','k','LineWidth',1);
xline(2,'k--')
xlim([1.7,2.3])
yticks([0,45])
ylim([-3,45])
ylabel('|psd(human)|')
% set(gca, 'YScale', 'log')

box off
% ax=gca;
% ax.Color='w';
% ax.YColor = 'w';
% ax.XColor ='w';
