% Parameter Sweep - Random

M = 200;
N = 200;
pop_dens = [0.1; 0.2; 0.3; 0.4];         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = [0.025; 0.05; 0.075; 0.1];            % (0, 0.1)
p_ttl = [4; 8; 12; 15];              % [0,15]
new_food = [100; 200; 300; 400];         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video

% time to execute 1 run ~4.4s

z = 1;
tic;
% pop_dens
for i = 1:4
    % f_th
    for j = 1:4
        for k = 1:4
            for m = 1:4
                [pop_cnts(:, z:z+1), ~, ~, ~, ~] = ...
                para_simulation(M, N, pop_dens(i), food_growth, ...
                f_th(j), p_ttl(k), new_food(1), viz, vid);
                z = z+2;   
            end
        end
    end
end
t = toc;
%% Parameter Sweep - Localised

M = 200;
N = 200;
pop_dens = [0.1; 0.2; 0.3; 0.4];         %10, 20, 30, 40[%]
food_growth = true;    % false = random, true = localised
f_th = [0.025; 0.05; 0.075; 0.1];            % (0, 0.1)
p_ttl = [4; 8; 12; 15];              % [0,15]
new_food = [100; 200; 300; 400];         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video

% time to execute 1 run ~4.4s

z = 1;
tic;
% pop_dens
for i = 1:4
    % f_th
    for j = 1:4
        for k = 1:4
            for m = 1:4
                [pop_cnts(:, z:z+1), quad_cnts1(:, z:z+1),...
                quad_cnts2(:, z:z+1), quad_cnts3(:, z:z+1), quad_cnts4(:, z:z+1)] = ...
                para_simulation(M, N, pop_dens(i), food_growth, ...
                f_th(j), p_ttl(k), new_food(1), viz, vid);
                z = z+2;   
            end
        end
    end
end
tl = toc;

