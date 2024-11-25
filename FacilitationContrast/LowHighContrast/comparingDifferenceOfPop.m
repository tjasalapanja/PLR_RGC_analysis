onsetPeakHeightsLow=zeros(length(responsesLL2(OFFcontrol{2})),3);
onsetPeakHeightsHigh=zeros(length(responsesLL5(OFFcontrol{5})),3);
lR=responsesLL2(OFFcontrol{2});
hR=responsesLL5(OFFcontrol{5});
for i=1:size(onsetPeakHeightsLow,1)
    onsetPeakHeightsLow(i,:)=max(lR(i).mean_flash(48:2*47,:));
end
for i=1:size(onsetPeakHeightsHigh,1)
    onsetPeakHeightsHigh(i,:)=max(hR(i).mean_flash(48:2*47,:));
end

% Assuming you have two vectors representing your populations: pop1 and pop2
pop1 = onsetPeakHeightsLow(:,1);
pop2 = onsetPeakHeightsHigh(:,1);

% Calculate the mean and standard deviation of each population
mean_pop1 = mean(pop1);
std_dev_pop1 = std(pop1);

mean_pop2 = mean(pop2);
std_dev_pop2 = std(pop2);

% Calculate the variance of the difference between the means
variance_diff_means = (std_dev_pop1^2 / length(pop1)) + (std_dev_pop2^2 / length(pop2));

% Take the square root of the variance to get the standard deviation of the difference
std_dev_difference = sqrt(variance_diff_means);