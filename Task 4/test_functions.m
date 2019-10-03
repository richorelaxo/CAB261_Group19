% Test functions
N = 10;
pop_dens = 0.3;
food_growth = false;
p_ttl = 3;


[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');


%% Test para step
[map, para_array, food_array] = para_step(map, para_array, food_array, p_ttl);
[para_cnt, food_cnt] = pop_cnt(map);

col_map = mapcolour(map);
imshow(col_map, 'InitialMagnification', 'Fit');

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

myVideo = VideoWriter('Parasite')
open(myVideo)

M = 200;
N = 200;
pop_dens = 0.3;
food_growth = false;
f_th = 0.01;
p_ttl = 7;
new_food = 500;

pop_cnts = zeros(1,2);

% Init
[map, para_array, food_array] = init_array(N, pop_dens, food_growth, p_ttl);
[pop_cnts(1, 1), pop_cnts(1,2)] = pop_cnt(map);

col_map = mapcolour(map);
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
    [pop_cnts(1+i, 1), pop_cnts(1+i,2)] = pop_cnt(map);
    
    % Visualize map
    col_map = mapcolour(map);
    imshow(col_map, 'InitialMagnification', 'Fit');
    title(['n = ', num2str(i)]);
    
    frame = getframe; % get the frame
    writeVideo(myVideo, frame) % write the frame to the video
    
    pause(0.3);
    
end

close(myVideo); % close the video file
%%
figure
plot(1:1:size(pop_cnts, 1), pop_cnts(:,1), 'b')
hold on
plot(1:1:size(pop_cnts, 1), pop_cnts(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')