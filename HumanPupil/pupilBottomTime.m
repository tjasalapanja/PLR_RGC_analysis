% Assuming you have your data stored in a matrix where each column represents a repetition
% Data should be organized such that each row corresponds to a measurement at a particular position

% Example data (replace with your actual data)
data=squeeze(LL2.allMeans(:,:,2))';
% Number of repetitions
num_repetitions = size(data, 2);

% Initialize inflection point positions
inflection_points = zeros(1, num_repetitions);

for i = 1:num_repetitions
    % Fit a sigmoidal curve (logistic function) to the data
    x = 1:length(data(:, i));
    y = data(:, i);
    fitresult = fit(x', y, 'smoothingspline');
    
    % Calculate the second derivative using numerical differentiation
    dy = gradient(fitresult(x), x);
    d2y = gradient(dy, x);
    
    % Determine the inflection point
    [~, max_index] = max(d2y);
    inflection_points(i) = x(max_index);
end

% Calculate mean and standard deviation of inflection point positions
mean_inflection_point = mean(inflection_points);
std_inflection_point = std(inflection_points);

% Display mean and standard deviation
disp(['Mean inflection point position: ', num2str(mean_inflection_point)]);
disp(['Standard deviation of inflection point position: ', num2str(std_inflection_point)]);