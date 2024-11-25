fs=15.49;
fs2=20;
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

fttPeak055Mouse=zeros(5,1);
fttPeak2Mouse=zeros(3,1);
fttPeak055Human=zeros(3,1);
fttPeak2Human=zeros(3,1);
for i=1:5
    % mouse055
    x = pupil055.mean_pupil(i,326:750,1);
    y = fft(x);
    f = (0:length(y)-1)*fs/length(y);
    [~,p]=max(abs(y(f>0.2&f<7.75))); % maximal value after 0.2
    index=find(f > 0.2, 1); % which value is first included (first larger than 0.2)
    fttPeak055Mouse(i,1)=f(p+index);
    if i<4
        % human055
        x = allPupil055Human.meanAll(i,101:500,1);
        y = fft(x);
        f = (0:length(y)-1)*fs2/length(y);
        [~,p]=max(abs(y(f>0.2&f<20)));
        index=find(f > 0.2, 1); 
        fttPeak055Human(i,1)=f(p+index);
        % mouse2
        x = pupil2.mean_pupil(i,94:2*93,1);
        y = fft(x);
        f = (0:length(y)-1)*fs/length(y);
        [~,p]=max(abs(y(f>0.2&f<7.75))); % maximal value after 0.2
        index=find(f > 0.2, 1); % which value is first included (first larger than 0.2)
        fttPeak2Mouse(i,1)=f(p+index);
        % human2
        x = allPupil2Human.meanAll(i,101:183,1);
        y = fft(x);
        f = (0:length(y)-1)*fs2/length(y);
        [~,p]=max(abs(y(f>0.2&f<10))); % maximal value after 0.2
        index=find(f > 0.2, 1); % which value is first included (first larger than 0.2)
        fttPeak2Human(i,1)=f(p+index);
    end
y=fft(scaledIntensity055);
f = (0:length(y)-1)*fs/length(y);
[~,p]=max(abs(y(f>0.2&f<7.75))); % maximal value after 0.2
index=find(f > 0.2, 1); % which value is first included (first larger than 0.2)
fttStim055=f(p+index);
y=fft(scaledIntensity2);
f = (0:length(y)-1)*fs/length(y);
[~,p]=max(abs(y(f>0.2&f<7.75))); % maximal value after 0.2
index=find(f > 0.2, 1); % which value is first included (first larger than 0.2)
fttStim2=f(p+index);
end
figure('color','w','Position',[100,100,300,500])
scatter([0.9,1,1.1],fttPeak2Mouse,'k','filled')
hold on
line([0.7,1.3],[fttStim2,fttStim2])
scatter([0.9,1,1.1]+1,fttPeak2Human,'k','filled')
line([0.7,1.3]+1,[fttStim2,fttStim2])
scatter([0.8,0.9,1,1.1,1.2]+2,fttPeak055Mouse,'k','filled')
line([0.7,1.3]+2,[fttStim055,fttStim055])
scatter([0.9,1,1.1]+3,fttPeak055Human,'k','filled')
line([0.7,1.3]+3,[fttStim055,fttStim055])
xlim([0,5])
ylim([0,3])