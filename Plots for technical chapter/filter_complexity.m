clear all
close all

% Parameters
M = 1:100; % Filter lengths
LMS_complexity = 4 * M + 1; % LMS: 4M + 1 operations
NLMS_complexity = 6 * M + 2; % NLMS: 6M + 2 operations
RLS_complexity = 5 * M.^2 + 6 * M; % RLS: 5M^2 + 6M operations

% Plotting
figure;
hold on;
grid on;
set(gca, 'YScale', 'log'); % Set y-axis to logarithmic scale
set(gca, 'FontSize', 12); % Font size for readability

% Plot each algorithm's complexity with different colors
plot(M, LMS_complexity, 'b-', 'LineWidth', 2, 'DisplayName', 'LMS'); % Blue line for LMS
plot(M, NLMS_complexity, 'r-', 'LineWidth', 2, 'DisplayName', 'NLMS'); % Red line for NLMS
plot(M, RLS_complexity, 'k-', 'LineWidth', 2, 'DisplayName', 'RLS'); % Black line for RLS

% Labels and title
%title('Computational Complexity of the Adaptive Algorithms', 'FontSize', 14, 'FontWeight', 'bold');
xlabel('Filter length (M)', 'FontSize', 12);
ylabel('Number of Operations', 'FontSize', 12);

% Legend
legend('Location', 'northwest', 'FontSize', 10);

% Adjust axes limits
xlim([0 100]); % x-axis limit
ylim([10^0 10^5]); % y-axis limit

hold off;

% Crop the figure and save as PDF
tightfig();
saveas(gcf, 'filter_complexity.pdf');

%%

clear all
close all

% Parameters
M = 1:100; % Filter lengths
N = 500;   % Number of observations
m = 2;    % Number of components
K = 5;     % Average iterations per component

% Computational complexity
LMS_complexity = 4 * M + 1;                         % LMS: 4M + 1 operations
NLMS_complexity = 6 * M + 2;                        % NLMS: 6M + 2 operations
RLS_complexity = 5 * M.^2 + 6 * M;                  % RLS: 5M^2 + 6M operations

% FastICA complexity: O(M^3 + M^2N + KmM^2 + KmMN)
FastICA_complexity = M.^3 + M.^2 * N + K * m * M.^2 + K * m * M * N;

% Plotting
figure;
hold on;
grid on;
set(gca, 'YScale', 'log'); % Set y-axis to logarithmic scale
set(gca, 'FontSize', 12);  % Font size for readability

% Plot each algorithm's complexity
plot(M, LMS_complexity, 'b-', 'LineWidth', 2, 'DisplayName', 'LMS');
plot(M, NLMS_complexity, 'r-', 'LineWidth', 2, 'DisplayName', 'NLMS');
plot(M, RLS_complexity, 'k-', 'LineWidth', 2, 'DisplayName', 'RLS');
plot(M, FastICA_complexity, '--', 'Color', [0 0.4 0.5], 'LineWidth', 2, 'DisplayName', 'FastICA'); % Dark teal for FastICA

% Labels and title
xlabel('Filter length / Input dimension (M)', 'FontSize', 12);
ylabel('Number of Operations', 'FontSize', 12);

% Legend
legend('Location', 'northwest', 'FontSize', 10);

% Adjust axes limits
xlim([0 100]);
ylim([10^0 10^9]); % Adjusted to accommodate FastICA’s higher complexity

hold off;

% Crop the figure and save as PDF
tightfig();
saveas(gcf, 'filter_complexity_with_fastica.pdf');

%%

function tightfig()
    % Tighten the figure by removing excess whitespace
    set(gcf, 'Units', 'Inches');
    pos = get(gcf, 'Position');
    set(gcf, 'PaperUnits', 'Inches');
    set(gcf, 'PaperSize', [pos(3) pos(4)]);
    set(gcf, 'PaperPosition', [0 0 pos(3) pos(4)]);
end