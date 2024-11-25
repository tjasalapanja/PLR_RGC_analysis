run={[1:6],[7:11],[12:17]};
pupil2new.mean_pupil=zeros(3,279,3);
pupil2new.std_pupil=zeros(3,279,3);
pupil2new.all_pupil=zeros(17,279,3);
pupil2new.mean_zscore=zeros(3,279,3);
pupil2new.std_zscore=zeros(3,279,3);
pupil2new.all_zscore=zeros(17,279,3);
for i=1:3
    pupil2new.mean_pupil(i,:,:)=allPupil2(i).mean_pupil;
    pupil2new.std_pupil(i,:,:)=allPupil2(i).std_pupil;
    pupil2new.all_pupil(run{i},:,:)=permute(allPupil2(i).all_pupil,[2,1,3]);
    pupil2new.mean_zscore(i,:,:)=allPupil2(i).mean_zscore;
    pupil2new.std_zscore(i,:,:)=allPupil2(i).std_zscore;
    pupil2new.all_zscore(run{i},:,:)=permute(allPupil2(i).all_zscore,[2,1,3]);
end
pupil2new.mean=squeeze(mean(pupil2new.all_pupil));
pupil2new.sem=squeeze(std(pupil2new.all_pupil)./sqrt(17));