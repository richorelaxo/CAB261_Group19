% Function:
%    para_step, 
%   
% Input parameters:
%    array = current array.
%    row = row of parasite poistion.
%    col = column of parasite position.
%    f_th = food threshold, [0, 0.01]
%
% Outputs:
%    array = new array.
%
function [array] = food_step(array, row, col, f_th)
    
    % random sample
    u = rand;
    
    % food dies if sample is less than food threshold
    if u < f_th
        array(row, col) = 0;
    end    
    
end %end function