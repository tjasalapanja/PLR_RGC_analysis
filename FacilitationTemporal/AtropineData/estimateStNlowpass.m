%% Estimate Signal and Variance
function StN=estimateStNlowpass(allROI,cut)
    % Measure covariance between the two repetitions for all repetitions and
    % take the average
    % Measure the variance for each response
    % Remove covariance from each variance
    % Calculate StN:covariance/variance
    d1 = designfilt("lowpassiir",FilterOrder=6, ...
    HalfPowerFrequency=0.3,DesignMethod="butter");% 2*cutoff(2.35)./sample(15.49)
    StN=zeros(length(allROI),3);
    for ROI=1:length(allROI)
        data=zeros(size(allROI(ROI).allSlow,1),size(allROI(ROI).allSlow,2),size(allROI(ROI).allSlow,3));
        for i=1:5
            dtemp=zeros(size(allROI(ROI).allSlow,1),3);
            dt=[];
            for type=1:3
                d=filtfilt(d1,allROI(ROI).allSlow(:,i,type));
                dtemp(:,type)=d;
                dt=[dt,d'];
            end
            minimal=min(dt);
            maximal=max(dt);
            data(:,i,:)=(dtemp-minimal)./(maximal-minimal);
        end
        for type=1:3
            covariances=zeros(10,1);
            variances=zeros(5,1);
            count=1;
            for i=1:4
                for j=i+1:5
                    c=cov(data(cut,i,type),data(cut,j,type));
                    covariances(count)=c(1,2);
                    count=count+1;
                end
                variances(i)=var(data(cut,i,type));
            end
            variances(5)=var(data(cut,5,type));
            meanCov=mean(covariances);
            meanVar=mean((variances-meanCov));
            StN(ROI,type)=meanCov/meanVar;
        end
    end
