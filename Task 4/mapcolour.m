%% This function converts a matrix of interger values 0, -1, 1+ into an rgb matrix
function [Map] = mapcolour(A)
%Input; A:= Matrix (R x C) of integers (0 to 3) representing cells types
    %space, life, food and water.
%Output; Map := 3D Matrix (R x C x 3) representing colours of a matrix of 
    %R x C pixels.

% instantiate map
Map = zeros(size(A,1), size(A,2), 3, 'uint8');

for row = 1:size(A,1)
    for col = 1:size(A,2)
        cell = A(row,col);
        
        if cell == 0 
                % space is white
                Map(row, col,1) = 255; Map(row, col,2) = 255; Map(row, col,3) = 255;
                            
        elseif cell < 0
                % food is green
                Map(row, col,1) = 0; Map(row, col,2) = 204; Map(row, col,3) = 0;
        
        elseif cell > 0 
                % parasite is purple
                Map(row, col,1) = 238; Map(row, col,2) = 130; Map(row, col,3) = 238;              
        end
    end
end

end% end function mapcolour
