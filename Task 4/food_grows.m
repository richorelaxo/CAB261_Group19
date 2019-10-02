function [new_map, food_array] = food_grows(map, food_array, new_food, food_growth)

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