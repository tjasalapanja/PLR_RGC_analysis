% Assuming you have your data stored in a matrix where each column represents a repetition
% Data should be organized such that each row corresponds to a measurement at a particular position

% Example data (replace with your actual data)
data=squeeze(LL2.allMeans(:,48:141,1))';
% Number of repetitions
num_repetitions = size(data, 2);

% Initialize inflection point positions
inflection_pointsMouse = zeros(1, num_repetitions);

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
    inflection_pointsMouse(i) = x(max_index);
end

% Calculate mean and standard deviation of inflection point positions
mean_inflection_point = mean(inflection_pointsMouse);
std_inflection_point = std(inflection_pointsMouse);

% Display mean and standard deviation
disp(['Mean inflection point position: ', num2str(mean_inflection_point/15.49)]);
disp(['Standard deviation of inflection point position: ', num2str(std_inflection_point/15.49)]);

% Example data (replace with your actual data)
data = squeeze(LL2.allMeans(:,48:141,1))';

% Number of repetitions
num_repetitions = size(data, 2);

% Initialize start points of drop
start_pointsMouse = zeros(1, num_repetitions);

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
        start_pointsMouse(i) = x(drop_start_index);
    else
        start_pointsMouse(i) = NaN; % No drop detected
    end
end

% Calculate mean and standard deviation of drop start points
mean_drop_start = nanmean(start_pointsMouse);
std_drop_start = nanstd(start_pointsMouse);

% Display mean and standard deviation
disp(['Mean drop start point: ', num2str(mean_drop_start/15.49)]);
disp(['Standard deviation of drop start point: ', num2str(std_drop_start/15.49)]);

mouseSeconds=start_pointsMouse./15.49;
mousePeakSeconds=inflection_pointsMouse./15.49;
%% plot
figure('Color','w','Position',[100,100,300,450]);
scatter([0.95,0.9,1,1.1,1.05],mouseSeconds,'filled','MarkerFaceColor',[0.5,0.5,0.5])
hold on
line([0.9,1.1],[mean_drop_start/15.49,mean_drop_start/15.49],'color','k','linewidth',2)
errorbar(1,mean_drop_start/15.49,std_drop_start./15.49,'LineStyle','none','Color','k')
scatter([0.95,0.9,1,1.1,1.05]+1,mousePeakSeconds,'filled','MarkerFaceColor',[0.5,0.5,0.5])
hold on
line([0.9,1.1]+1,[mean_inflection_point/15.49,mean_inflection_point/15.49],'color','k','linewidth',2)
errorbar(2,mean_inflection_point/15.49,std_inflection_point./15.49,'LineStyle','none','color','k')
xlim([0.5,2.5])
xticks([1,2])
xticklabels({'start','peak'})
title('pupil constriction')
ylabel('seconds')