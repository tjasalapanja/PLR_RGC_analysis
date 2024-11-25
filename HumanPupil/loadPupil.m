pupil3.allTraces=zeros(5,264);
pupil3.allTraces(1,:)=step20lux3157Rst.Average_cleaned(1:264);
pupil3.allTraces(2,:)=step20lux3157Rst.Average_cleaned1(1:264);
pupil3.allTraces(3,:)=step20lux3157Rst.Average_cleaned2(1:264);
pupil3.allTraces(4,:)=step20lux3157Rst.Average_cleaned3(1:264);
pupil3.allTraces(5,:)=step20lux3157Rst.Average_cleaned4(1:264);
pupil3.meanTrace=mean(pupil3.allTraces);
pupil3.stdTrace=std(pupil3.allTraces);
pupil3.semTrace=mean(pupil3.allTraces)./sqrt(5);
pupil3.zscoreAll=zeros(7,264);
for i=1:5
    m=mean(pupil3.allTraces(i,:),2);
    s=std(pupil3.allTraces(i,:),0,2);
    pupil3.zscoreAll(i,:)=(pupil3.allTraces(i,:)-m)./s;
end
pupil3.meanZscore=mean(pupil3.zscoreAll);
pupil3.stdZscore=std(pupil3.zscoreAll);
pupil3.semZscore=std(pupil3.zscoreAll)./sqrt(5);