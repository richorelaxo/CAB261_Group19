% Task 4 Simulation Runs

%% Test setup for parameter investigation
M = 200;
N = 200;
pop_dens = 0.3;         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = 0.01;            % (0, 0.1)
p_ttl = 15;              % [0,15]
new_food = 300;         % 100, 200, 300, 400
viz = true;        % show map 
vid = true;        % make video

[pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens, food_growth, f_th, p_ttl, new_food, viz, vid);

% Plots
plot_counts(pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4, food_growth);



%% Randomised food placement
M = 200;
N = 200;
pop_dens = [0.1, 0.2, 0.3, 0.4];         %10, 20, 30, 40[%]
food_growth = false;    % false = random, true = localised
f_th = [0.03, 0.02, 0.01];            % (0, 0.1)
p_ttl = [8, 10, 15];              % [0,15]
new_food = [400, 300];         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video


txt1_1 = (['f-th = ', num2str(f_th(1))]);
txt1_2 = ([' p-ttl = ', num2str(p_ttl(1))]);
txt1_3 = (['new-food = ', num2str(new_food(1))]);
txt2_1 = (['f-th = ', num2str(f_th(1))]);
txt2_2 = ([' p-ttl = ', num2str(p_ttl(1))]);
txt2_3 = (['new-food = ', num2str(new_food(1))]);
txt3_1 = (['f-th = ', num2str(f_th(1))]);
txt3_2 = ([' p-ttl = ', num2str(p_ttl(1))]);
txt3_3 = (['new-food = ', num2str(new_food(1))]);

for i = 1:4
    [pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens(1,i), food_growth, f_th(1,1), p_ttl(1,1), new_food(1,1), viz, vid);

    subplot(3,4,i)
    plot(1:1:size(pop_cnts, 1), pop_cnts(:,1), 'b')
    hold on
    plot(1:1:size(pop_cnts, 1), pop_cnts(:,2), 'g')
    legend('Parasites', 'Food', 'Location', 'NorthEast')    
    title(['Population density = ', num2str(pop_dens(1,i))])
    ylabel('Population, Parameter set A')
    xlabel('Step')
end

for i = 1:4
    [pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens(1,i), food_growth, f_th(1,2), p_ttl(1,2), new_food(1,1), viz, vid);

    subplot(3,4,i+4)
    plot(1:1:size(pop_cnts, 1), pop_cnts(:,1), 'b')
    hold on
    plot(1:1:size(pop_cnts, 1), pop_cnts(:,2), 'g')
    legend('Parasites', 'Food', 'Location', 'NorthEast')    
    title(['Population density = ', num2str(pop_dens(1,i))])
    ylabel('Population, Parameter set B')
    xlabel('Step')
end

for i = 1:4
    [pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens(1,i), food_growth, f_th(1,3), p_ttl(1,3), new_food(1,2), viz, vid);

    subplot(3,4,i+8)
    plot(1:1:size(pop_cnts, 1), pop_cnts(:,1), 'b')
    hold on
    plot(1:1:size(pop_cnts, 1), pop_cnts(:,2), 'g')
    legend('Parasites', 'Food', 'Location', 'NorthEast')    
    title(['Population density = ', num2str(pop_dens(1,i))])
    ylabel('Population, Parameter set C')
    xlabel('Step')
end


%% Localised food: 
M = 200;
N = 200;
pop_dens = 0.3;         %10, 20, 30, 40[%]
food_growth = true;    % false = random, true = localised
f_th = 0.01;            % (0, 0.1)
p_ttl = 15;              % [0,15]
new_food = 300;         % 100, 200, 300, 400
viz = false;        % show map 
vid = false;        % make video

[pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens, food_growth, f_th, p_ttl, new_food, viz, vid);

% Plots
plot_counts(pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4, food_growth);
