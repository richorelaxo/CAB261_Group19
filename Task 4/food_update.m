function [map, food_array] = food_update(map, food_array)

% Update map with live food
    for m = size(food_array, 1):-1:1
        
        [occ, ~] = cell_occupied(map, food_array(m, 1), food_array(m, 2));
        
        % If a parasite occupies cell, food was eaten
        if occ == true
           food_array(m,:)  = [];
        
        % Otherwise food still lives
        else
            map(food_array(m,1), food_array(m,2)) = -1;
        end
    end