% Test functions
N = 100;
pop_dens = 0.3;
food_growth = false;
p_ttl = 15;


[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Test para step
[map, para_array, food_array] = para_step(map, para_array, food_array, p_ttl);
col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');

%% Test food map update

[map, food_array] = food_update(map, food_array);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Test food death
f_th = 0.05;

[map, food_array] = food_dies(map, food_array, f_th);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Full loop test

M = 100;
N = 100;
pop_dens = 0.2;
food_growth = false;
f_th = 0.01;
p_ttl = 2;
new_food = 1000;

for i = 1:M
    
    % Parasite step
    [map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
    
    % Map food update
    [map, food_array] = food_update(map, food_array);
    
    % Food random death
    [map, food_array] = food_dies(map, food_array, f_th);
    
    % Visualize map
    col_map = mapcolour(map);
    imshow(col_map, 'InitialMagnification', 'Fit');
    pause(0.3);
    
end

