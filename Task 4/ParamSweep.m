% Parameter Sweep

M = 200;
N = 200;
pop_dens = [0.1; 0.2; 0.3; 0.4];         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = [0.025; 0.05; 0.075; 0.1];            % (0, 0.1)
p_ttl = [4; 8; 12; 15];              % [0,15]
new_food = [100; 200; 300; 400];         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video

j = 1;

for i = 1:4
    [pop_cnts(:, j:j+1), ~, ~, ~, ~] = ...
    para_simulation(M, N, pop_dens(i), food_growth(1), f_th(1), p_ttl(1), new_food(1), viz, vid);
    j = j+1;
end
