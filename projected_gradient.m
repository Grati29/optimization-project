function [costs_projected, grad_projected, time_projected, cond_projected, iter, x] = projected_gradient (x, max_iter, tolerance, alpha)
    costs_projected = [];
    cond_projected = [];
    grad_projected = [];
    iter = 0; 
    tic;
    for iter = 1:max_iter
        land_distance = 5000 - x;
        water_distance = sqrt(x^2 + 1000^2);
        cost = 50 * land_distance + 130 * water_distance;
        grad = -50 + (130 * x) / sqrt(x^2 + 1000^2);
        new_x = x - alpha * grad;
        new_x = max(0, min(new_x, 5000));
        costs_projected = [costs_projected, cost];
        grad_projected = [grad_projected, grad];

        if norm(new_x - x) < tolerance
            break;
        end
        cond_projected = [cond_projected, norm(new_x - x)];
        x = new_x;
    end
     time_projected = toc;
end