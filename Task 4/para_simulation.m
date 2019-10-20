%% Parasite Simulation Function

function [pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4] = ...
    para_simulation(M, N, pop_dens, food_growth, f_th, p_ttl, new_food, viz, vid)

    %%% Intitialize Video 
    if vid == true && viz == true
         myVideo = VideoWriter('Parasite');
         myVideo.FrameRate = 5;
         open(myVideo)
    end

    % Initialize output arrays and map
    pop_cnts = zeros(1,2);
    quad_cnts1 = zeros(1,2);
    quad_cnts2 = zeros(1,2);
    quad_cnts3 = zeros(1,2);
    quad_cnts4 = zeros(1,2);

    [map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
    [pop_cnts(1, 1), pop_cnts(1,2)] = pop_cnt(map);
    [quad_cnts1(1, 1), quad_cnts1(1,2)] = pop_cnt(map(1:N/2, 1:N/2));
    [quad_cnts2(1, 1), quad_cnts2(1,2)] = pop_cnt(map(1:N/2, (N/2+1):N));
    [quad_cnts3(1, 1), quad_cnts3(1,2)] = pop_cnt(map((N/2+1):N, 1:N/2));
    [quad_cnts4(1, 1), quad_cnts4(1,2)] = pop_cnt(map((N/2+1):N,(N/2+1):N));

    % Init Visulaization
    if viz == true 
        col_map = mapcolour(map);
        figure
        imshow(col_map, 'InitialMagnification', 'Fit');
        title("n = 0");
    end

    % Loop
    for i = 1:M

        % Parasite step
        [map, para_array, food_array] = para_step(map, para_array, food_array, p_ttl);

        % Map food update
        [map, food_array] = food_update(map, food_array);

        % Food random death
        [map, food_array] = food_dies(map, food_array, f_th);

        % Food growth
        [map, food_array] = food_grows(map, food_array, new_food, food_growth);

        % population counts    

            % entire map
            [pop_cnts(1+i, 1), pop_cnts(1+i,2)] = pop_cnt(map);

            % quadrants
            [quad_cnts1(1+i, 1), quad_cnts1(1+i,2)] = pop_cnt(map(1:N/2, 1:N/2));
            [quad_cnts2(1+i, 1), quad_cnts2(1+i,2)] = pop_cnt(map(1:N/2, (N/2+1):N));
            [quad_cnts3(1+i, 1), quad_cnts3(1+i,2)] = pop_cnt(map((N/2+1):N, 1:N/2));
            [quad_cnts4(1+i, 1), quad_cnts4(1+i,2)] = pop_cnt(map((N/2+1):N,(N/2+1):N));

        % Visualize map
        if viz ==  true
            col_map = mapcolour(map); 
            imshow(col_map, 'InitialMagnification', 'Fit');
            title(['n = ', num2str(i)]);   
            pause(0.1);
        end

        %%%    Make Video 
        if vid == true && viz == true
             frame = getframe; % get the frame
             writeVideo(myVideo, frame) % write the frame to the video
        end



    end

    % close the video file
    if vid == true && viz == true
        close(myVideo); 
    end
    
end
