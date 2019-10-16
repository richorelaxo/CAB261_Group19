function  [pop_cnts] = para_sim(M, N, pop_dens, food_growth, f_th, p_ttl, new_food)


pop_cnts = zeros(1,2);

% Init
[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
[pop_cnts(1, 1), pop_cnts(1,2)] = pop_cnt(map);

% Loop
for i = 1:M
    
    % Parasite step
    [map, para_array, food_array] = para_step(map, para_array, food_array, p_ttl);
    
    % Map food update
    [map, food_array] = food_update(map, food_array);
    
    % Food random death
    [map, food_array] = food_dies(map, food_array, f_th);
    
    % Food growth
    [map, food_array] = food_grows(map, food_array, new_food, food_growth);
    
    % population counts
    [pop_cnts(1+i, 1), pop_cnts(1+i,2)] = pop_cnt(map);
        
end