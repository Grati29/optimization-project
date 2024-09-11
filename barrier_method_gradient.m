function [costs_barrier, grad_barrier, time_barrier, cond_barrier, iter, x] = barrier_method_gradient (x, tau, eps, max_iter, sigma, tolerance, alpha)
    costs_barrier = [];
    grad_barrier = [];
    cond_barrier = [];
    tic;
    while tau >= eps
        for iter = 1:max_iter
            land_distance = 5000 - x;
            water_distance = sqrt(x^2 + 1000^2);
            cost = 50 * land_distance + 130 * water_distance - (1/tau) * (log(x) + log(5000 - x));
            grad = -50 + (130 * x) / sqrt(x^2 + 1000^2) - (1/tau) * (1/x - 1/(5000 - x));
      
            new_x = x - alpha * grad;
            costs_barrier = [costs_barrier, cost];
            grad_barrier = [grad_barrier, grad];
            if norm(new_x - x) < tolerance
                break;
            end
            cond_barrier = [cond_barrier, norm(new_x - x)];
            x = new_x;
        end
        tau = tau * sigma;
    end
    time_barrier = toc;
end