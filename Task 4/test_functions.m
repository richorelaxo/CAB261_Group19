% Test functions
N = 100;
pop_dens = 0.3;
food_growth = false;
p_ttl = 15;
new_food = 100;


[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Test steps
[map, para_array, food_array] = para_step(map, para_array, food_array, p_ttl);
[map, food_array] = food_step(map, food_array, 0.01, 300, food_growth);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');

