% Function:
%    food_step, 
%   
% Input parameters:
%    food_array = array of current food coords.
%    f_th = food threshold, [0, 0.01].
%    new_food = # new food cells per step.
%    food_growth = random or localised food growth [boolean], false for
%    random.
%
% Outputs:
%    array = new array.
%
function [new_map, food_array] = food_step(map, food_array, f_th, new_food, food_growth)
    
    % Random food dies off
    for i = size(food_array, 1):-1:1
        
        % random sample
        u = rand;

        % food dies if sample is less than food threshold
        if u < f_th
            food_array(i, :) = [];                
        end                
    end
    
    
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
    
    
    % New food grows (random/localised)    
    new_food_array = zeros(new_food, 2);
    
    % Random food growth
    if food_growth == false
        [new_map, new_food_array] = random_placement(map, new_food_array);
        food_array = [food_array; new_food_array];        
    
    % localised food growth
    else
        %TBD
    end
    
end %end function