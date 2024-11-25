% Assuming you have two vectors representing your populations: pop1 and pop2
pop1 = ipsiAna;
pop2 = ipsiAwa

% Calculate the mean and standard deviation of each population
mean_pop1 = mean(pop1);
std_dev_pop1 = std(pop1);

mean_pop2 = mean(pop2);
std_dev_pop2 = std(pop2);

% Calculate the variance of the difference between the means
variance_diff_means = (std_dev_pop1^2 / length(pop1)) + (std_dev_pop2^2 / length(pop2));

% Take the square root of the variance to get the standard deviation of the difference
std_dev_difference = sqrt(variance_diff_means);