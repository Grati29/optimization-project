% initializations
alpha = 0.01;
tolerance = 1e-6;
max_iter = 1000;
x_initial = 380;
tau = 1;
sigma = 0.2;
eps = 0.0001;

% barrier method with gradient
[costs_barrier, grad_barrier, time_barrier, cond_barrier, iter_barrier, x_barrier] = barrier_method_gradient (x_initial, tau, eps, max_iter, sigma, tolerance, alpha);
final_cost_barrier = 50 * (5000 - x_barrier) + 130 * sqrt(x_barrier^2 + 1000^2);

% projected gradient method
[costs_projected, grad_projected, time_projected, cond_projected , iter_projected, x_projected] = projected_gradient (x_initial, max_iter, tolerance, alpha);
final_cost_projected = 50 * (5000 - x_projected) + 130 * sqrt(x_projected^2 + 1000^2);

% fmincon
objective = @(x) 50 * (5000 - x) + 130 * sqrt(x^2 + 1000^2);
lb = 0;
ub = 5000;
x0 = x_initial;
options = optimoptions('fmincon', 'Display', 'iter');
[x_fmincon, cost_fmincon] = fmincon(objective, x0, [], [], [], [], lb, ub, [], options);

% CVX
cvx_begin
    variables x y
    minimize( 50 * (5000 - x) + 130 * y )
    subject to
        0 <= x <= 5000
        norm([x, 1000]) <= y
cvx_end
x_cvx = x;
final_cost_cvx = cvx_optval;

% table
methods = {'barrier method with gradient', 'fmincon', 'projected gradient method', 'CVX'};
x_var_decision = [x_barrier, x_fmincon, x_projected, x_cvx];
x_land = [5000 - x_barrier, 5000 - x_fmincon, 5000 - x_projected, 5000 - x_cvx];
x_water = [sqrt(x_barrier^2 + 1000^2), sqrt(x_fmincon^2 + 1000^2), sqrt(x_projected^2 + 1000^2), sqrt(x_cvx^2 + 1000^2)];
cost_min = [final_cost_barrier, cost_fmincon, final_cost_projected, final_cost_cvx];

T = table(methods', x_var_decision', x_land', x_water', cost_min', ...
          'VariableNames', {'Method', 'Optim_value_x', 'Optim_distance_land', 'Optim_distance_water', 'Minimal_cost'});
disp(T);

figure (1);
plot(1:iter_barrier, costs_barrier(1:iter_barrier), 'r'); 
hold on;
plot(1:iter_projected, costs_projected(1:iter_projected), 'b'); 
xlabel('Iterations');
ylabel('Objective_function');
title('Objective Function- Barrier method with gradient vs Projected gradient method');
legend( 'Projected gradient method', 'Barrier method with gradient', 'Location', 'northeast'); 
hold off;

figure (2);
plot(1:iter_barrier, cond_barrier(1:iter_barrier), 'r'); 
hold on;
plot(1:iter_projected, cond_projected(1:iter_projected), 'b'); 
xlabel('Iterations');
ylabel('Error');
title('Error- Barrier method with gradient vs Projected gradient method');
legend('Barrier method with gradient', 'Projected gradient method', 'Location', 'northeast'); 
hold off;

fprintf('Execution time- Barrier method with gradient vs Projected gradient method:\n');
fprintf('  Execution time- Barrier method with gradient: %.4f secunde\n', time_barrier);
fprintf('  Execution time- Projected gradient method: %.4f secunde\n', time_projected);