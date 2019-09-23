% Test functions

N = 10;
pop_dens = 0.3;
food_growth = false;
p_ttl = 5;

[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Check densities

food = 0;
para = 0;

for i = 1:N
    for j = 1:N
        
        [occ, cell] = cell_occupied(map, i, j);
        
        if cell < 0
            food = food + 1;
        elseif cell > 0 
            para = para + 1;
        end
        
    end
end
% food = para = N^2 * para_dens, works!

%% para_step test

rand_order = randperm(size(para_array, 1));

for i = rand_order
   
    [map, para_array, food_array] = para_step(map, para_array, food_array, p_ttl, i);
          
end

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');
title(['Step number N = ', num2str(m)]); 
drawnow
pause(0.6);


%% food_step test
row = 4;
col = 2;
f_th = 0.5;

new_map = food_step(map, row, col, f_th);

%% Step test

% Initial values
N = 10; % Array square
M = 20; % # of steps

f1 = 10; % Parasite time to live [0, 15]
f2 = 0.1; % Food threshold [0, 0.01]
f3 = N*0.2; % # new food each step [100, 200, 300, 400]

food_growth = false; % food growth random/localise [false/true]
pop_dens = 0.1; % Population density [10%, 20, 30%, 40%]

% Initialize map array
[map, para_array] = init_array(N, pop_dens, food_growth, f1);

%%
% Update parasites and food loop 
    for i = 1:N
        for j = 1:N
            
            [occ, cell] = cell_occupied(map, i, j);
            
            % Cell is food
            if cell > 0
                map = para_step(map, i, j, f1);
            
            % Cell is a parasite
            elseif cell < 0
                map = food_step(map, i, j, f2);
            end
            
        end 
    end %end update loop
        
    % Grow new food
    for f = 1:f3
        
        free = false; % while loop guard
        
        while free == false
        
            % random coordinates
            u_f_row = round(rand * (N-1) + 1);
            u_f_col = round(rand * (N-1) + 1);
            
            % if unoccupied set array cell to food cell integer (-1)
            if cell_occupied(map, u_f_row, u_f_col) == false
                map(u_f_row, u_f_col) = - 1;
                free = true;         
            end
            
        end %end while loop
        
    end %end food loop
    
    
