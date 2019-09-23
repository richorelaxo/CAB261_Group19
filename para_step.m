% Function:
%    para_step, simulates movement of parasite. Parasite moves in a random
%    N, S, W, E dir'n (equal chance). If next step is occupied with another
%    parasite it doesn't move. If occupied by food it eats the food and a
%    new parasite is born at the previous coords. If empty the parasite
%    moves to the new coords. In all cases the parasite time to live
%    decrements.
%   
% Input parameters:
%    array = current array.
%    para_array = parasite array with time to live and coords.
%    food_array = food array index.
%    p_ttl = parasite time to live.
%    index = para_array index number.
%
% Outputs:
%    array = new array.
%
function [array, para_array, food_array] = para_step(array, para_array, food_array, p_ttl, index)
    
    if para_array(index, 1) < 1
        return;
    end

    N = length(array);
    row = para_array(index, 2);
    col = para_array(index, 3);

%%% Next Step Direction %%%
    
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
    
        
%%% Check cell at next step and update array %%%
    
    [occ, cell] = cell_occupied(array, nrow, ncol);

    % Cell occupied by P -> Stay put, decrement ttl
    if cell > 0
        
        para_array(index, 1) = para_array(index, 1) - 1;
        
    % Cell occupied by F -> Move, eat food and birth new P, decrement ttl
    elseif cell < 0
        
        % Move to new coords, decrement ttl
        para_array(index, 1) = para_array(index, 1) - 1;
        para_array(index, 2) = nrow;
        para_array(index, 3) = ncol;
        array(nrow, ncol) = 1;
        
        % Birth new P
        para_array(size(para_array, 1) + 1, 1) = p_ttl;
        para_array(size(para_array, 1), 2) = row;
        para_array(size(para_array, 1), 3) = col;
        
        % clear food_array
        x = find(food_array(:,1) == nrow & food_array(:,2) == ncol);
        food_array(x, :) = [];
    
    % Cell empty -> Move to new cell, decrement ttl
    else
        para_array(index, 1) = para_array(index, 1) - 1;
        para_array(index, 2) = nrow;
        para_array(index, 3) = ncol;
        array(nrow, ncol) = 1;
        
        % empty old cell
        array(row, col) = 0;
    end
    
    % Check for dead parasites and clear array
    if para_array(index, 1) < 1
        array(para_array(index, 2), para_array(index, 2)) = 0;
    end
    
end %end funciton