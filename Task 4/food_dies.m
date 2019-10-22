% Function:
%    food_dies removes 
%    
%   
% Input parameters:
%    array = array to check.
%    row = row of array to check.
%    col = col of array to check.
%
% Outputs:
%    map = 
%    

function [map, food_array] = food_dies(map, food_array, f_th)

% Random food dies off
    for i = size(food_array, 1):-1:1
        
        % random sample
        u = rand;

        % food dies if sample is less than food threshold
        if u < f_th
            map(food_array(i, 1), food_array(i, 2)) = 0;
            food_array(i, :) = [];            
        end                
    end