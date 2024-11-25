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
figure('Color','w','Position',[100,100,600,400]);
tiledlayout(5,2,"TileSpacing","compact","Padding","compact")
nexttile(1)
y = fft(scaledIntensity055);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(0.55,'k--')
xlim([0,5])
xticks([])
box off

nexttile(3,[2,1])
peakHeight055=zeros(1,30);
peakLoc055=zeros(1,30);
for i=1:30
    x = pupil055.all_pupil(310:311+355+46,i,1);
    y = fft(x);
    fs = 1/Ts;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',[0.7,0.7,0.7])
    hold on
    xlim([0,5])
    ylim([0,50])
    [peakHeight055(i),peakLoc055(i)]=findpeaks(abs(y(2:201)),'Npeaks',1);
end
y = fft(mean(pupil055.mean_pupil(:,310:311+355+46,1)));
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(0.55,'k--')
box off


nexttile(7,[2,1])
peakHeight055=zeros(1,14);
peakLoc055=zeros(1,14);
f_all=zeros(30,400);

for i=1:14
    x = allPupil055Human.allData(i,101:500,1);
    y = fft(x);
    fs = 1/Ts2;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',[0.7,0.7,0.7])
    hold on
    xlim([0,5])
    ylim([0,1000])
    [peakHeight055(i),peakLoc055(i)]=findpeaks(abs(y(2:201)),'Npeaks',1);
end
y = fft(allPupil055Human.mean(101:500));
fs = 1/Ts2;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1);
xline(0.55,'k--')
box off

peakHeight2=zeros(1,17);
peakLoc2=zeros(1,17);
nexttile(2)
y = fft(scaledIntensity2);
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xlim([0,10])
xline(2,'k--')
xticks([])
box off
nexttile(4,[2,1])
for i=1:17
    x = pupil2.all_pupil(78:79+93+46,i,1);
    y = fft(x);
    fs = 1/Ts;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',[0.7,0.7,0.7])
    hold on
    xlim([0,10])
    ylim([0,50])
    [peakHeight2(i),peakLoc2(i)]=findpeaks(abs(y(2:71)),'Npeaks',1);
end
y = fft(mean(pupil2.mean_pupil(:,78:79+93+46,1)));
fs = 1/Ts;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1)
xline(2,'k--')
box off

nexttile(8,[2,1])
peakHeight2=zeros(1,15);
peakLoc2=zeros(1,15);
f_all=zeros(30,183);

for i=1:15
    x = allPupil2Human.allData(i,1:183);
    y = fft(x);
    fs = 1/Ts2;
    f = (0:length(y)-1)*fs/length(y);
    plot(f,abs(y),'Color',[0.7,0.7,0.7])
    hold on
    xlim([0,10])
    ylim([0,1000])
%     [peakHeight2(i),peakLoc2(i)]=findpeaks(abs(y(2:183)),'Npeaks',1);
end
y = fft(allPupil2Human.mean(1:183));
fs = 1/Ts2;
f = (0:length(y)-1)*fs/length(y);
plot(f,abs(y),'Color','k','LineWidth',1);
xline(2,'k--')
box off

