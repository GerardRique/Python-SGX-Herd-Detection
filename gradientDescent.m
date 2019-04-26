function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iterations)

m = length(y);
J_history = zeros(num_iterations, 1);

for i = 1:num_iterations
    grad = (1/m) .* X' * ((X * theta) - y);
    theta = theta - (alpha .* grad);

    J_history(i) = computeCost(X, y, theta);

end

end