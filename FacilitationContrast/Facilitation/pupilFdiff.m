function pupilFrameDifference=pupilFdiff(pupil)
    pupilFrameDifference=zeros(size(pupil.allMeans,1),size(pupil.allMeans,2));
    for i=1:size(pupil.allMeans,1)
        pupilFrameDifference(i,:)=smoothdata(pupil.allMeans(i,:,1))-smoothdata(pupil.allMeans(i,:,2));
    end