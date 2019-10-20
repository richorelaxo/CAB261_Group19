% Task 4 Simulation Runs

M = 100;
N = 200;
pop_dens = 0.2;         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = 0.02;            % (0, 0.1)
p_ttl = 10;              % [0,15]
new_food = 400;         % 100, 200, 300, 400

[pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens, food_growth, f_th, p_ttl, new_food);


%% Plots
plot_counts(pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4, food_growth);
