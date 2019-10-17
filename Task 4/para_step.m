% Function:
%    para_step, simulates movement of parasite. Parasite moves in a random
%    N, S, W, E dir'n (equal chance). If next step is occupied with another
%    parasite it doesn't move. If occupied by food it eats the food and a
%    new parasite is born at the previous coords. If empty the parasite
%    moves to the new coords. In all cases the parasite time to live
%    decrements. This function covers the action of all parasites in a
%    single of the whole map space.
%   
% Input parameters:
%    map = current map.
%    para_array = parasite array with time to live and coords.
%    food_array = food array index.
%    p_ttl = parasite time to live.
%
% Outputs:
%    map = new map with ONLY next parasites placed.
%
function [new_map, para_array, food_array, cell_array] = para_step(map, para_array, food_array, p_ttl)
    
    % Initialize local variables
    N = size(map,1);
    new_map = zeros(N);
    
    % random order of parasites to reduce sequential bias
    rand_order = randperm(size(para_array, 1)); 
    cell_array = zeros(size(para_array,1),1); % TESTING
    
    % parasite loop
    for i = rand_order
        
        row = para_array(i, 2);
        col = para_array(i, 3);
        
        % Initialize next step row and column
        nrow = row;
        ncol = col;
    
        % Random direction (N, S, W, E) to step
        u = rand;
    
        % wrap around edges, adjusting for matlab index beginning at 1:
        % [ ((index - 1) +/- 1 ) mod N ] + 1
    
        % North
        if u < 1/4
            nrow = mod((row - 1) - 1, N) + 1;
    
        % South
        elseif u < 1/2
            nrow = mod((row - 1) + 1, N) + 1;
    
        % West
        elseif u < 3/4
            ncol = mod((col - 1) - 1, N) + 1;
    
        % East
        else
            ncol = mod((col - 1) + 1, N) + 1;
        end
        
        
        
        %%% Check cell at next step on map %%%
        [~, cell] = cell_occupied(map, nrow, ncol);        
        cell_array(i, 1) = cell;
        
        % Cell occupied by P
        if cell == 1
           
            %coords remain the same, decrement ttl
            para_array(i, 1) = para_array(i, 1) - 1;
            
            
        % Cell occupied by F
        elseif cell == -1
            
            % Move to new coords, decrement ttl
            para_array(i, 1) = para_array(i, 1) - 1;
            para_array(i, 2) = nrow;
            para_array(i, 3) = ncol;
            
            % Birth new Parasite
            para_array(size(para_array, 1) + 1, 1) = p_ttl;
            para_array(size(para_array, 1), 2) = row;
            para_array(size(para_array, 1), 3) = col;
            
            % Food cell -> para cell to more births at coord
            map(nrow, ncol) = 1;            
        
        % Cell empty (0)
        elseif cell == 0
            
            % move to new coords, decrement ttl
            para_array(i, 1) = para_array(i, 1) - 1;
            para_array(i, 2) = nrow;
            para_array(i, 3) = ncol;
            
            % empty cell -> para cell to more moves at coord
            map(nrow, ncol) = 1;
            
        end% end step conditions
        
    end% end parasite loop
    
    % Remove dead parasites
    for d = size(para_array, 1):-1:1
        if para_array(d, 1) == 0
            para_array(d,:) = [];
        end
    end
        
    % Add parasites to new_map
    for p = 1:size(para_array, 1)        
        new_map(para_array(p, 2), para_array(p, 3)) = 1;
    end
       
    
        
end %end funciton