function [map, array] = local_placement(map, array)
    
    %init local variables
    u = rand();
    N = size(map, 1);
    [para_cnt, ~] = pop_cnt(map);
    
    %set quadrant bounds based on array size
    if size(array, 1) > 1000
        mid_bnd = round(sqrt(para_cnt*2+1000)); %N^2-para_cnt
    else
        mid_bnd = N/2;
    end

    % Select random quadrant each step

    % top left quadrant
    if u < 1/4
        row_lwr = 0;
        row_upr = mid_bnd;
        col_lwr = 0;
        col_upr = mid_bnd;

    % top right quadrant
    elseif u < 1/2
        row_lwr = N - mid_bnd +1;
        row_upr = N;
        col_lwr = 0;
        col_upr = mid_bnd ;

    % lower left quadrant
    elseif u < 3/4
        row_lwr = 0;
        row_upr = mid_bnd ;
        col_lwr = N - mid_bnd +1;
        col_upr = N;

    % lower right quadrant
    else
        row_lwr = N - mid_bnd +1;
        row_upr = N;
        col_lwr = N - mid_bnd +1;
        col_upr = N;
    end

    % grow randomly food in selected quadrant
    for i = 1:size(array, 1)

        free = false;

        while free == false

            % random coordinates
            u_row = round(rand * (row_upr - row_lwr - 1) + row_lwr + 1);
            u_col = round(rand * (col_upr - col_lwr - 1) + col_lwr + 1);

            % if unoccupied set mapcell to food
            if cell_occupied(map, u_row, u_col) == false
                map(u_row, u_col) = -1;
                array(i, 1) = u_row;
                array(i, 2) = u_col;
                free = true;
            end
        end %food loop
    end%for loop

end