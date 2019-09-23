% Function:
%   init_array, produces an N x N array of parasite, food and empty
%   cells. Population density of parasites and food is pre-determined by
%   pop_dens parameter and the food can be randomised or localised depending
%   on the food_growth switch.
%
% Input parameters:
%   N = array size N x N [#]
%   pop_dens = population density of parasites and food [%]
%       food_growth = random or localised food growth [boolean], false for random,
%       true for localised.
%   p_ttl = parasite time to live, steps a parasite lives for [#].
%
% Outputs:
%   array = N x N array with parasites, food and empty cells

function [array, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl)
    
    % Population # of parasites and food
    pop = N^2 * pop_dens;
    
    % Initialize map array
    array = zeros(N);
    
    % Parasite array for time to live and coords
    para_array = zeros(pop, 3);
    para_array(:,1) = p_ttl;
    
    % Food array coords
    food_array = zeros(pop, 2);
    
    for i = 1:pop
        
        % Parasite while loop guard
        free = false; 
        
        % Parasite loop
        while free == false
            
            % random coordinates
            u_p_row = round(rand * (N-1) + 1);
            u_p_col = round(rand * (N-1) + 1);
            
            % if unoccupied set array cell to parasite
            if cell_occupied(array, u_p_row, u_p_col) == false                
                array(u_p_row, u_p_col) = 1;
                para_array(i, 2) = u_p_row;
                para_array(i, 3) = u_p_col;
                free = true;
            end            
        end %end food loop
        
        %%% Food growth switch %%%        
        
        % Random food growth %
        if food_growth == false
            
            % Food while loop guard
        free = false; 
        
        % Food loop
        while free == false
            
            % random coordinates
            u_f_row = round(rand * (N-1) + 1);
            u_f_col = round(rand * (N-1) + 1);
            
            % if unoccupied set array cell to food cell integer (-1)
            if cell_occupied(array, u_f_row, u_f_col) == false
                array(u_f_row, u_f_col) = -1;
                food_array(i, 1) = u_f_row;
                food_array(i, 2) = u_f_col;
                free = true;
            end            
        end %end food loop
            
        % Localised food growth % - TBD
        else            
            
        end
        
    end %end population for loop  
        
end %end function