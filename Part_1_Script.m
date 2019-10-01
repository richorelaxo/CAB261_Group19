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

%% Part 1 b) %%
% 2D Representation
% Parasite model function used

% Defining Parameters
k1 = 1;
k2 = 2;
k3 = 2; %linspace(0,50,10);
k4 = 4;
k5 = 3;
T = 20;
tspan = [0,T];
X_1_0 = 1;
X_2_0 = 1;
y0 = [X_1_0, X_2_0];

% Calling ODE45 to solve parasite function


f = @(t,y) Parasite(t,y,k1,k2,k3,k4,k5);
[t,y] = ode45(f,tspan,y0);
figure()
hold on
plot(t,y);
legend("Pred (Parasite)","Prey")

%% Parameter Sweep %%

n = 201;
k3 = linspace(0,50,n);
Tol = 1e-2;
Parms_Para = zeros(1,n);
Parms_Prey = zeros(1,n);

for i = 1:n
    f = @(t,y) Parasite(t,y,k1,k2,k3(i),k4,k5);
    [t,y] = ode45(f,tspan,y0);
    if ((y(end,1) < Tol) && y(end,2) > Tol) % Stores succesfull paramters for Para => 0
        Parms_Para(i) = k3(i);
    end
    if (abs(y(end,2) - 2) < Tol)  % Stores succesfull paramters for Prey => 2
      Parms_Prey(i) = k3(i);  
    end
end

%% Plotting Successful Parameters k3 %%

Parms_Para = Parms_Para(Parms_Para ~= 0); % Getting rid of the zero's
Parms_Prey = Parms_Prey(Parms_Prey ~= 0); 

Min_Para_Die = min(Parms_Para);
Max_Para_Die = max(Parms_Para);
Min_Prey_2 = min(Parms_Prey);
Max_Prey_2 = max(Parms_Prey);

figure;
subplot(1,2,1)
boxplot(Parms_Para','Labels',{'Parasites ==> 0'})
title('Parameter Sweep Parasite Model')
xlabel('System Dynamics')
ylabel('Value of k3')
subplot(1,2,2)
boxplot(Parms_Prey','Labels',{'Prey ==> 2'})
title('Parameter Sweep Parasite Model')
xlabel('System Dynamics')
ylabel('Value of k3')

%% Part 1 c) %%
% Paired parameter sweep k3 and k4

% Defining sweep variables

n = 100;
k3 = linspace(0,50,n);
k4 = linspace(0,50,n);
Parms_Para_c = zeros(n*n,2);  % Storing succesful parameters in an array
Parms_Prey_c = zeros(n*n,2);


for j = 1:n
    for i = 1:n
        f = @(t,y) Parasite(t,y,k1,k2,k3(i),k4(j),k5);
        [t,y] = ode45(f,tspan,y0);
        if ((y(end,1) < Tol) && y(end,2) > Tol) % Stores succesfull paramters for Para => 0
            Parms_Para_c(i*j,1) = k3(i);
            Parms_Para_c(i*j,2) = k4(j);
        end
        if (abs(y(end,2) - 2) < Tol)  % Stores succesfull paramters for Prey => 2
            Parms_Prey_c(i*j,1) = k3(i);
            Parms_Prey_c(i*j,2) = k4(j);
            
        end
    end
end

%% The Plotting %%

x = linspace(0,50,200);  % For Plotting (x = y) curve

figure;
subplot(1,2,1)
scatter(Parms_Para_c(:,1),Parms_Para_c(:,2))
hold on
plot(x,x)
grid on
grid minor
title('Parasite ==> 0')
xlabel('k3')
ylabel('k4')
legend('Successfull Parameter Pairs','y = x (k3 = k4)','Location','southeast')
subplot(1,2,2)
scatter(Parms_Prey_c(:,1),Parms_Prey_c(:,2))
hold on
plot(2*x,x)
xlim([0,50])
grid on
grid minor
title('Prey ==> 2')
xlabel('k3')
ylabel('k4')
legend('Successfull Parameter Pairs','y = x/2 (k3 = k4/2)','Location','northwest')

%% Part 1 d) %%
% Paired parameter sweep k4 and k5

% Defining sweep variables

n = 100;
k3 = 10;
k4 = linspace(0,50,n);
k5 = linspace(0,50,n);
Parms_Para_d = zeros(n*n,2);  % Storing succesful parameters in an array
Parms_Prey_d = zeros(n*n,2);


for j = 1:n
    for i = 1:n
        f = @(t,y) Parasite(t,y,k1,k2,k3,k4(i),k5(j));
        [t,y] = ode45(f,tspan,y0);
        if ((y(end,1) < Tol) && y(end,2) > Tol) % Stores succesfull paramters for Para => 0
            Parms_Para_d(i*j,1) = k4(i);
            Parms_Para_d(i*j,2) = k5(j);
        end
        if (abs(y(end,2) - 2) < Tol)  % Stores succesfull paramters for Prey => 2
            Parms_Prey_d(i*j,1) = k4(i);
            Parms_Prey_d(i*j,2) = k5(j);
            
        end
    end
end

%% The Plotting for d) %%

figure;
subplot(1,2,1)
scatter(Parms_Para_d(:,1),Parms_Para_d(:,2))
hold on
grid on
grid minor
title('Parasite ==> 0')
xlabel('k4')
ylabel('k5')
subplot(1,2,2)
scatter(Parms_Prey_d(:,1),Parms_Prey_d(:,2))
hold on
xlim([0,50])
grid on
grid minor
title('Prey ==> 2')
xlabel('k4')
ylabel('k5')













