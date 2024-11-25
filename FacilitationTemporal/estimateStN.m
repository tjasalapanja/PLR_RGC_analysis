%% Estimate Signal and Variance
function StN=estimateStN(allROI,cut)
    % Measure covariance between the two repetitions for all repetitions and
    % take the average
    % Measure the variance for each response
    % Remove covariance from each variance
    % Calculate StN:covariance/variance
    StN=zeros(length(allROI),3);
    for ROI=1:length(allROI)
        for type=1:3
            covariances=zeros(10,1);
            variances=zeros(5,1);
            count=1;
            for i=1:4
                for j=i+1:5
                    c=cov(movmean(allROI(ROI).allSlow(cut,i,type),8),movmean(allROI(ROI).allSlow(cut,j,type),8));
                    covariances(count)=c(1,2);
                    count=count+1;
                end
                variances(i)=var(movmean(allROI(ROI).allSlow(cut,i,type),8));
            end
            variances(5)=var(movmean(allROI(ROI).allSlow(cut,5,type),8));
            meanCov=mean(covariances);
            meanVar=mean(abs(variances-meanCov));
            StN(ROI,type)=meanCov/meanVar;
        end
    end
