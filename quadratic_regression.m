data = load('octave_data.csv');

cross_sec_abs_dev = data(:,1);
market_equity = data(:,2);
market_equity_squared = data(:,4);

m = length(cross_sec_abs_dev);
plot(market_equity, cross_sec_abs_dev, 'ro');

fprintf('Program paused. Press enter to continue.\n');
pause;

X = [ones(m, 1), data(:,3), data(:,4)];

theta = zeros(3, 1);

iterations = 3000;
alpha = 0.01;

fprintf('All values Initialized. Program paused.\n');
pause;

fprintf('\nRunning Gradient Descent ...\n')

theta = gradientDescent(X, cross_sec_abs_dev, theta, alpha, iterations);

hold on; % keep previous plot visible
test = [-1.4:0.1:1.5];
size(test)
test_squared = test .^2;
testx = [ones(30, 1), test', test_squared'];
plot(test, testx*theta, '-');
grid on;
theta

hold off;