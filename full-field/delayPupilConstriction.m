% Example data (replace with your actual data)
data = squeeze(LL3.allMeans(:,:,2))';

% Number of repetitions
num_repetitions = size(data, 2);

% Initialize start points of drop
start_points = zeros(1, num_repetitions);

% Threshold for detecting drop
threshold =0.015;

for i = 1:num_repetitions
    % Fit a smoothing spline to the data
    x = 1:length(data(:, i));
    y = data(:, i);
    fitresult = fit(x', y, 'smoothingspline');
    
    % Calculate the first derivative of the fitted curve
    dy = gradient(fitresult(x), x);
    
    % Find the time when the rate of change exceeds the threshold
    drop_start_index = find(dy < -threshold, 1);
    
    if ~isempty(drop_start_index)
        start_points(i) = x(drop_start_index);
    else
        start_points(i) = NaN; % No drop detected
    end
end

% Calculate mean and standard deviation of drop start points
mean_drop_start = nanmean(start_points);
std_drop_start = nanstd(start_points);

% Display mean and standard deviation
disp(['Mean drop start point: ', num2str(mean_drop_start)]);
disp(['Standard deviation of drop start point: ', num2str(std_drop_start)]);