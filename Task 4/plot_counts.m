function plot_counts(pop_cnts, quad_cnts1, quad_cnts2, quad_cnts3, quad_cnts4, food_growth)


plot_title = 'Random food placement';

if food_growth == true
    plot_title = 'Localised food placement';
    
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

end

% Plot whole map counts
figure
plot(1:1:size(pop_cnts, 1), pop_cnts(:,1), 'b')
hold on
plot(1:1:size(pop_cnts, 1), pop_cnts(:,2), 'g')
legend('Parasites', 'Food', 'Location', 'NorthEast')
title(plot_title);


