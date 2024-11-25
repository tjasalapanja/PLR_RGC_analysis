fs=15.49;
fs2=20;
fttPeak055Mouse=zeros(5,1);
fttPeak2Mouse=zeros(3,1);
fttPeak055Human=zeros(3,1);
fttPeak2Human=zeros(3,1);
for i=1:5
    % mouse055
    x = pupil055.mean_pupil(i,326:750,1);
    y = fft(x);
    f = (0:length(y)-1)*fs/length(y);
    fttPeak055Mouse(i,1)=max(abs(y(f>0.54&f<0.56)));
    if i<4
        % human055
        x = allPupil055Human.meanAll(i,101:500,1);
        y = fft(x);
        f = (0:length(y)-1)*fs2/length(y);
        fttPeak055Human(i,1)=max(abs(y(f>0.54&f<0.56)));
        % mouse2
        x = pupil2.mean_pupil(i,94:2*93,1);
        y = fft(x);
        f = (0:length(y)-1)*fs/length(y);
        fttPeak2Mouse(i,1)=max(abs(y(f>1.95&f<2.05)));
        % human2
        x = allPupil055Human.meanAll(i,101:183,1);
        y = fft(x);
        f = (0:length(y)-1)*fs2/length(y);
        fttPeak2Human(i,1)=max(abs(y(f>1.92&f<2.17)));
    end
end
figure('color','w','Position',[100,100,400,200])
scatter(1,fttPeak055Mouse,'k','filled')
hold on
scatter(2,fttPeak2Mouse,'k','filled')
scatter(3,fttPeak055Human,'k','filled')
scatter(4,fttPeak2Human,'k','filled')
xlim([0,5])
