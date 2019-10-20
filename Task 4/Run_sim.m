% Task 4 Simulation Runs

%% Random food: 10% Population density, Low food death, Low P_ttl, Low food growth
M = 200;
N = 200;
pop_dens = 0.1;         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = 0.01;            % (0, 0.1)
p_ttl = 3;              % [0,15]
new_food = 100;         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video

[pop_cnts, ~, ~, ~, ~] = ...
    para_simulation(M, N, pop_dens, food_growth, f_th, p_ttl, new_food, viz, vid);


% Plots
plot_counts(pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4, food_growth);

%% Random food: 20% Population density, Low food death, Low P_ttl, Low food growth
M = 200;
N = 200;
pop_dens = 0.2;         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = 0.01;            % (0, 0.1)
p_ttl = 3;              % [0,15]
new_food = 100;         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video

[pop_cnts, ~, ~, ~, ~] = ...
    para_simulation(M, N, pop_dens, food_growth, f_th, p_ttl, new_food, viz, vid);


% Plots
plot_counts(pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4, food_growth);
