% Function:
%    cell_occupied, checks row and column of array and determines if it is
%    occupied and with what type of cell
%   
% Input parameters:
%    array = array to check.
%    row = row of array to check.
%    col = col of array to check.
%
% Outputs:
%    occupied = cell is occupied [boolean]
%    cell = value in cell [int].

function [occupied, cell] = cell_occupied(array, row, col)
    
    if array(row, col) < 0
        cell = array(row,col);
        occupied = true;
    elseif array(row, col) > 0
        cell = array(row,col);
        occupied = true;
    else        
        cell = 0;
        occupied = false;
    end

end