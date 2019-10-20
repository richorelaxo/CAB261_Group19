% Test functions
N = 200;
pop_dens = 0.3;
food_growth = true;
p_ttl = 3;

[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Test para step
para_array0 = para_array;

[map, para_array, food_array, cell_array] = para_step(map, para_array, food_array, p_ttl);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');

%comp_array = [para_array [cell_array; zeros((size(para_array,1) - size(cell_array,1)),1)]];

%% Test food map update

[map, food_array] = food_update(map, food_array);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Test food death
f_th = 0.05;

[map, food_array] = food_dies(map, food_array, f_th);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');

%% Food growth
new_food = 3;

[map, food_array] = food_grows(map, food_array, new_food, food_growth);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Full loop test

%  myVideo = VideoWriter('Parasite');
%  myVideo.FrameRate = 5;
%  open(myVideo)

M = 500;
N = 200;
pop_dens = 0.1;         %10, 20, 30, 40[%]
food_growth = true;    % false = random, true = localised
f_th = 0.02;            % (0, 0.1)
p_ttl = 10;              % [0,15]
new_food = 400;         % 100, 200, 300, 400

pop_cnts = zeros(1,2);
quad_cnts1 = zeros(1,2);
quad_cnts2 = zeros(1,2);
quad_cnts3 = zeros(1,2);
quad_cnts4 = zeros(1,2);

% Init
[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
[pop_cnts(1, 1), pop_cnts(1,2)] = pop_cnt(map);
[quad_cnts1(1, 1), quad_cnts1(1,2)] = pop_cnt(map(1:N/2, 1:N/2));
[quad_cnts2(1, 1), quad_cnts2(1,2)] = pop_cnt(map(1:N/2, (N/2+1):N));
[quad_cnts3(1, 1), quad_cnts3(1,2)] = pop_cnt(map((N/2+1):N, 1:N/2));
[quad_cnts4(1, 1), quad_cnts4(1,2)] = pop_cnt(map((N/2+1):N,(N/2+1):N));

col_map = mapcolour(map);
figure
imshow(col_map, 'InitialMagnification', 'Fit');
title("n = 0");

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
    col_map = mapcolour(map);    

    imshow(col_map, 'InitialMagnification', 'Fit');
    title(['n = ', num2str(i)]);   

%      frame = getframe; % get the frame
%      writeVideo(myVideo, frame) % write the frame to the video
    
    pause(0.1);
    
end

%close(myVideo); % close the video file
%% Whole map
figure
plot(1:1:size(pop_cnts, 1), pop_cnts(:,1), 'b')
hold on
plot(1:1:size(pop_cnts, 1), pop_cnts(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')
title(['Pop''n Dens ', num2str(pop_dens), ', fd thr ', num2str(f_th), ', para ttl ', num2str(p_ttl), ', new food ', num2str(new_food) ]);
%% Quadrants
figure

% Quadrant 1
subplot(2,2,1)
plot(1:1:size(quad_cnts1, 1), quad_cnts1(:,1), 'b')
hold on
plot(1:1:size(quad_cnts1, 1), quad_cnts1(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')
title('Quadrant 1')

% Quadrant 2
subplot(2,2,2)
plot(1:1:size(quad_cnts2, 1), quad_cnts2(:,1), 'b')
hold on
plot(1:1:size(quad_cnts2, 1), quad_cnts2(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')
title('Quadrant 2')

% Quadrant 3
subplot(2,2,3)
plot(1:1:size(quad_cnts3, 1), quad_cnts3(:,1), 'b')
hold on
plot(1:1:size(quad_cnts3, 1), quad_cnts3(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')
title('Quadrant 3')

% Quadrant 4
subplot(2,2,4)
plot(1:1:size(quad_cnts4, 1), quad_cnts4(:,1), 'b')
hold on
plot(1:1:size(quad_cnts4, 1), quad_cnts4(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')
title('Quadrant 4')
