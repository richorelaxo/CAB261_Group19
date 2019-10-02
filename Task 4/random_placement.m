function [map, array] = random_placement(map, array)

N = size(map, 1);

%array offset
offset = 0;
marker = -1;

% if type true set to parasite
if size(array, 2) == 3
    marker = 1;
    offset = 1;
end

for i = 1:size(array, 1)
    
    free = false;
    
    while free == false

        % random coordinates
        u_row = round(rand * (N-1) + 1);
        u_col = round(rand * (N-1) + 1);

        % if unoccupied set mapcell to marker
        if cell_occupied(map, u_row, u_col) == false
            map(u_row, u_col) = marker;
            array(i, offset + 1) = u_row;
            array(i, offset + 2) = u_col;
            free = true;
        end            
    
    end %food loop
    
end%for loop

end% function
