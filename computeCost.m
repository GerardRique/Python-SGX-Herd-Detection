function J = computeCost(X, y, theta)

m = length(y);
J = 0;

hyp = X * theta;
J = 0.5 * 1/m * (hyp - y)' * (hyp - y);

end