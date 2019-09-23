%%% Task 4 - Spatial Agent Simulation %%%

% Initial values
N = 10; % Array square
M = 20; % # of steps

f1 = 10; % Parasite time to live [0, 15]
f2 = 0.1; % Food threshold [0, 0.01]
f3 = N*0.2; % # new food each step [100, 200, 300, 400]

food_growth = false; % food growth random/localise [false/true]
pop_dens = 0.1; % Population density [10%, 20, 30%, 40%]

% Initialize map array
map = init_array(N, pop_dens, food_growth, f1);

col_map = mapcolour(map);
set(figure, 'Visible', 'on', 'Position', get(0,'Screensize'))
imshow(col_map, 'InitialMagnification', 'Fit');
title('Step number N = 0');
drawnow

% Step Loop 
for m = 1:M

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
    
    col_map = mapcolour(map);
    imshow(col_map, 'InitialMagnification', 'Fit'); % this has the same effect as the line above, but is slower
    title(['Step number N = ', num2str(m)]); 
    drawnow
    pause(1);
    
    
end %end step loop

%% This function converts a matrix of interger values 0, -1, 1+ into an rgb matrix
function [Map] = mapcolour(A)
%Input; A:= Matrix (R x C) of integers (0 to 3) representing cells types
    %space, life, food and water.
%Output; Map := 3D Matrix (R x C x 3) representing colours of a matrix of 
    %R x C pixels.

% instantiate map
Map = zeros(size(A,1), size(A,2), 3, 'uint8');

for row = 1:size(A,1)
    for col = 1:size(A,2)
        cell = A(row,col);
        
        if cell == 0 
                % space is white
                Map(row, col,1) = 255; Map(row, col,2) = 255; Map(row, col,3) = 255;
                            
        elseif cell < 0
                % food is green
                Map(row, col,1) = 0; Map(row, col,2) = 204; Map(row, col,3) = 0;
        
        elseif cell > 0 && cell <= 5
                % old parasite is purple
                Map(row, col,1) = 238; Map(row, col,2) = 130; Map(row, col,3) = 238;        
        
        elseif cell > 5
                % young parasite is red
                Map(row, col,1) = 255; Map(row, col,2) = 0; Map(row, col,3) = 0;
        end
    end
end

end% end function mapcolour
