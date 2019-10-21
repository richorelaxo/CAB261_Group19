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
Tol = 1e-1;
Parms_Para = zeros(1,n);
Parms_Prey = zeros(1,n);

for i = 1:n
    f = @(t,y) Parasite(t,y,k1,k2,k3(i),k4,k5);
    [t,y] = ode45(f,tspan,y0);
    if ((y(end,1) < Tol) && (y(end,1) > 0) && (y(end,2) > 0)) % Stores succesfull paramters for Para => 0
        Parms_Para(i) = k3(i);
    end
    if ((abs(y(end,2) - 2) < Tol) && (y(end,1) > 0))  % Stores succesfull paramters for Prey => 2
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

%% Plot style 2 %% 

y1 = ones(length(Parms_Para));
y2 = ones(length(Parms_Prey));
%%%
figure;
subplot(1,2,1)
plot(Parms_Para',y1,'b*','LineWidth',2)
set(gca,'YTickLabel',[]);
title('Parameter Sweep Parasite Model')
ylabel('System Dynamics Parasites ==> 0')
xlabel('Value of k3')
grid on 
grid minor
subplot(1,2,2)
plot(Parms_Prey',y2,'r*','LineWidth',2)
set(gca,'YTickLabel',[]);
title('Parameter Sweep Parasite Model')
ylabel('System Dynamics Prey ==> 2')
xlabel('Value of k3')
grid on
grid minor

%% Plot Style 3 k3 Sweep

figure();
plot(Parms_Para',y1,'.','MarkerSize',12)
hold on
plot(Parms_Prey',y2,'r.', 'MarkerSize',12)
legend('Parasites ==> 0','Prey ==> 2','Location','northeast')
xlabel('Value of k3')
grid on
grid minor
ax = gca;
ax.FontSize = 12;
set(gca,'YTickLabel',[]);
title({'System Dynamics with varying k3 values';'Fixed k1 = 1 ,k2 = 2,k4 = 4 ,k5 = 3'})
txt = {'Range for Prey ==> 2';'[7.75,50]'};
text(25,1.2,txt,'FontSize',12)
txt2 = {'Range for Para ==> 0';'[0.25,8.0]'};
text(0.5,1.2,txt2,'FontSize',12)

%% Part 1 c) %%
% Paired parameter sweep k3 and k4

% Defining sweep variables

n = 150;
k3 = linspace(0,50,n);
k4 = linspace(0,50,n);
Parms_Para_c = [0,0];  % Storing succesful parameters in an array
Parms_Prey_c = [0,0];


for j = 1:n
    for i = 1:n
        f = @(t,y) Parasite(t,y,k1,k2,k3(i),k4(j),k5);
        [t,y] = ode45(f,tspan,y0);
        if ((y(end,1) < Tol)&& (y(end,1) > 0) && (y(end,2) > 0)) % Stores succesfull paramters for Para => 0
            Parms_Para_c(end+1,1) = k3(i);
            Parms_Para_c(end,2) = k4(j);
        end
        if ((abs(y(end,2) - 2) < Tol) && (y(end,1) > 0))  % Stores succesfull paramters for Prey => 2
            Parms_Prey_c(end+1,1) = k3(i);
            Parms_Prey_c(end,2) = k4(j);
            
        end
    end
end

%% The Plotting %%

%Parms_Para_c(1,1) = [];
%Parms_Prey_c(1,1) = [];
x = linspace(0,50,200);  % For Plotting (x = y) curve

figure;
subplot(1,2,1)
scatter(Parms_Para_c(:,1),Parms_Para_c(:,2))
hold on
plot(1.9*x,x,'LineWidth',2)
xlim([0,50])
grid on
grid minor
title('Parasite ==> 0','FontSize',16)
xlabel('k3','FontSize',16)
ylabel('k4','FontSize',16)
legend('Successfull Parameter Pairs','1.9y = x','FontSize',14,'Location','southeast')
subplot(1,2,2)
scatter(Parms_Prey_c(:,1),Parms_Prey_c(:,2))
hold on
plot(1.9*x,x,'LineWidth',2)
xlim([0,50])
grid on
grid minor
title('Prey ==> 2','FontSize',16)
xlabel('k3','FontSize',16)
ylabel('k4','FontSize',16)
legend('Successfull Parameter Pairs','1.9y = x','FontSize',14,'Location','northwest')


%% Plot Take 2 %%

figure;
scatter(Parms_Para_c(:,1),Parms_Para_c(:,2))
hold on
scatter(Parms_Prey_c(:,1),Parms_Prey_c(:,2))
plot(1.9*x,x,'g-','LineWidth',2)
xlim([0,50])
grid on
grid minor
title('System Dynamics','FontSize',16)
xlabel('k3','FontSize',16)
ylabel('k4','FontSize',16)
legend('Parasite ==> Tol','Prey ==> 2','1.9y = x','FontSize',16)


%% Part 1 d) %%
% Paired parameter sweep k4 and k5

% Defining sweep variables

n = 150;
k3 = 10;
k4 = linspace(0,50,n);
k5 = linspace(0,50,n);
Parms_Para_d = [0 0];
Parms_Prey_d = [0 0];


for j = 1:n
    for i = 1:n
        f = @(t,y) Parasite(t,y,k1,k2,k3,k4(i),k5(j));
        [t,y] = ode45(f,tspan,y0);
        if ((y(end,1) < Tol)&& (y(end,1) > 0) && (y(end,2) > 0)) % Stores succesfull paramters for Para => 0
            Parms_Para_d(end+1,1) = k4(i);
            Parms_Para_d(end,2) = k5(j);
        end
        if ((abs(y(end,2) - 2) < Tol) && (y(end,1) > 0))  % Stores succesfull paramters for Prey => 2
            Parms_Prey_d(end+1,1) = k4(i);
            Parms_Prey_d(end,2) = k5(j);
            
        end
    end
end

%Parms_Para_d(1,1) = [];
%Parms_Prey_d(1,1) = [];


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

%% Plot Type 2 %%

figure;
scatter(Parms_Para_d(:,1),Parms_Para_d(:,2),'gs')
hold on
scatter(Parms_Prey_d(:,1),Parms_Prey_d(:,2),'bo')
grid on
grid minor
xline(5.2,'r','LineWidth',2)
title('System Dynamics k4 and k4 Sweep','FontSize',16)
xlabel('k4','FontSize',16)
ylabel('k5','FontSize',16)
legend('Parasite ==> Tol','Prey ==> 2','x = 5.2','FontSize',16)













