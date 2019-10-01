%% MXB 261 Assignment 2 %%
% Part 1 Script
% Matt Sampson

%% Part 1 a) %%
% Defining Parameters

K = 100;
x0 = 50;
r = 2;
h = 0.01;
steps = 2000;
s = linspace(0,400,9);


%% Testing with a for loop %%


x = zeros(length(s),steps);
x(:,1) = 50;

for j = 1:length(s)
    for i = 1:steps
        if i-s(j) < 1
            x(j,i+1) = x(j,i)*(1 + h*r - (h*r*x(j,1))/K); % Ghost Points
        else
            x(j,i+1) = x(j,i)*(1 + h*r - (h*r*x(j,i-s(j)))/K);
        end
    end
end

figure;
for m = 1:length(s)    
    subplot(3,3,m)
    plot(x(m,:))
    hold on
    grid on
    grid minor
    title(['Delay = ', num2str(s(m))])
    if (mod(m,3)) == 1
        ylabel('Population Count')
    end
    if m > 6
        xlabel('No. of Time Steps')
    end
end


%% Repeating new r and new h %%

r = 1/2;
h = 0.05;

x = zeros(length(s),steps);
x(:,1) = 50;

for j = 1:length(s)
    for i = 1:steps
        if i-s(j) < 1
            x(j,i+1) = x(j,i)*(1 + h*r - (h*r*x(j,1))/K); % Ghost Points
        else
            x(j,i+1) = x(j,i)*(1 + h*r - (h*r*x(j,i-s(j)))/K);
        end
    end
end

figure;
for m = 1:length(s)    
    subplot(3,3,m)
    plot(x(m,:))
    hold on
    grid on
    grid minor
    title(['Delay = ', num2str(s(m))])
    if (mod(m,3)) == 1
        ylabel('Population Count')
    end
    if m > 6
        xlabel('No. of Time Steps')
    end
end






