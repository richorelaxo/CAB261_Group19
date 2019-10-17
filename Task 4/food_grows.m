function [new_map, food_array] = food_grows(map, food_array, new_food, food_growth)

% New food grows (random/localised)    
    new_food_array = zeros(new_food, 2);
    
    % Random food growth
    if food_growth == false
        [new_map, new_food_array] = random_placement(map, new_food_array);               
    
    % localised food growth
    else
        [new_map, new_food_array] = local_placement(map, new_food_array);
    end
    
    % Output augmented food_array
    food_array = [food_array; new_food_array];
    
end