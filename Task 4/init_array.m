% Function:
%   init_array, produces an N x N array of parasite, food and empty
%   cells. Population density of parasites and food is pre-determined by
%   pop_dens parameter and the food can be randomised or localised depending
%   on the food_growth switch.
%
% Input parameters:
%   N = array size N x N [#]
%   pop_dens = population density of parasites and food [%]
%   food_growth = random or localised food growth [boolean], false for random,
%   true for localised.
%   p_ttl = parasite time to live, steps a parasite lives for [#].
%
% Outputs:
%   map = N x N array with parasites, food and empty cells

function [map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl)
    
    % Population # of parasites and food
    pop = round(N^2 * pop_dens);
    
    % Initialize map array
    map = zeros(N);
    
    % Initialize Parasite array for time to live
    para_array = zeros(pop, 3);
    para_array(:,1) = p_ttl;
    
    % Randomly populate map with Parasites
    [map, para_array] = random_placement(map, para_array);
    
    % Initialize Food array 
    food_array = zeros(pop, 2);  
    
    % Populate map with food [random/localised]
    if food_growth == false
        [map, food_array] = random_placement(map, food_array);
    else
        [map, food_array] = local_placement(map, food_array);
    end 
        
end %end function