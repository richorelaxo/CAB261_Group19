%% Task 2
clear all;
clc;
close all;

%% Latin Hypercube Sampling in 3D

n = 50;                     % n is the range max [0 n]
x = 50;                     % divisions
gridSize = x*n+1;           % size of the grid- for matlab indexing [1 51]

% Latin HyperCube Sample output Parms = (n, 3) ->[k3 k4 k5]
Parms = LHSFn(n,gridSize);

%% Parameter check

% tolerance
Tol = 1e-2;
% set parameters
k1 = 1;         
k2 = 2;
% timespan for ode45 to solve over
T = 20;
tspan = [0,T];
% initial values
X_1_0 = 1;      
X_2_0 = 1;
y0 = [X_1_0, X_2_0];

% initialise storage of successful parameters for two conditions
Parms_X1 = zeros(n,3);
Parms_X2 = zeros(n,3);

% initialise counters  
j = 1;
k = 1;

for i = 1:gridSize
    
    % solve ode
    [t,y] = parasitesFn(Parms(i,1), Parms(i,2), Parms(i,3));
    
    if (sum(sum(y(:,:) >= 0)) == size(y,1)*2) % check it doesn't fall below 0
        if ((y(end,1) < Tol) && y(end,2) > Tol) % Check for X1 => at end
            
            % store if successful
            Parms_X1(j,:) = Parms(i,:);
            j = j+1;
        end % end check for X1 => 0
        
        if (abs(y(end,2) - 2) < Tol)  % Checks for X2 => 2 at end
            % store if successful
           Parms_X2(k,:) = Parms(i,:);
           k = k+1;
        end % end check for X2 => 2
        
    end % end check for >= 0
    
end % end step through all

%% Visualise

figure(1)
grid on
plot3(Parms_X1(:,1), Parms_X1(:,2), Parms_X1(:,3), 'bo', Parms_X2(:,1), Parms_X2(:,2), Parms_X2(:,3), 'ro')
xlabel("x")
ylabel("y")
zlabel("z")
xlim([0 50]); ylim([0 50]); zlim([0 50])
hold on
surf(x,y,z) 
hold on
surf(x1,y1,z1)


%%

[x, y] = meshgrid(0:1:50);
z = 1.25.*x;

[x1, z1] = meshgrid(0:1:50);
y1 = 0.5.*x1;
%%
figure(2) 
for i = 1:length(Parms_X1(:,1))
    [t1, y1] = parasitesFn(Parms_X1(i,1), Parms_X1(i,2), Parms_X1(i,3));
    plot(t1,y1(:,1))
    legend( "X1")
    title("X1 to 0")
    hold on
end


%% ALL CODE BELOW IS OLD LMAO


%% FROM MATT // Parameter check
% 3tuple parameter sweep k3,k4 and k5

Tol = 1e-2;
k3 = 1;
k4 = 2;
n = 50; % n should equal how many lines in your (k3,k4,k5) storage vector
T = 20;
tspan = [0,T];
X_1_0 = 1;
X_2_0 = 1;
y0 = [X_1_0, X_2_0];

% If you store the LHS output as 3D vector use this
% Parms(:,1) should be k3 Parms(:,2) k4 and Parms(:,3) k5

%Parms = (3 column parameter vector);
Parms_Para_LHS = zeros(n,3);  % Storing succesful parameters in an array
Parms_Prey_LHS = zeros(n,3);

for i = 1:n
    f = @(t,y) Parasite(t,y,k3,k4,Parms(i,1),Parms(i,2),Parms(i,3));
    [t,y] = ode45(f,tspan,y0);
    if ((y(end,1) < Tol) && y(end,2) > Tol) % Stores succesfull paramters for Para => 0
        Parms_Para_LHS(i,1) = Parms(i,1);
        Parms_Para_LHS(i,2) = Parms(i,2);
        Parms_Para_LHS(i,3) = Parms(i,3);
    end
    if (abs(y(end,2) - 2) < Tol)  % Stores succesfull paramters for Prey => 2
        Parms_Prey_LHS(i,1) = Parms(i,1);
        Parms_Prey_LHS(i,2) = Parms(i,2);
        Parms_Prey_LHS(i,3) = Parms(i,3);
        
    end
end

%% keep the bad boys that have X1 and X2 not going below 0
j = 1;
k = 1;

for i = 1:n
    
    f = @(t,y) Parasite(t,y,k3,k4,Parms(i,1),Parms(i,2),Parms(i,3));
    [t,y] = ode45(f,tspan,y0);
    
    if (sum(Parms_Prey_LHS(i,:)) ~= 0) && (sum(sum(y(:,:) >= 0)) == size(y,1)*2)
        Parms_To_Two(j,:) = Parms_Prey_LHS(i,:);
        j = j+1;
    end
    
    if (sum(Parms_Para_LHS(i,:)) ~= 0) && (sum(sum(y(:,:) >= 0)) == size(y,1)*2) 
        Parms_To_Zero(k,:) = Parms_Para_LHS(i,:);
        k = k+1;
    end
end


%% check the plots look tasty

figure(1)
for i = 1:length(Parms_To_Two(:,1))
    [t1, y1] = parasitesFn(Parms_To_Two(i,1), Parms_To_Two(i,2), Parms_To_Two(i,3));
    plot(t1,y1(:,2))
    legend( "X2")
    title("X2 to 2")
    hold on
end

figure(2)
for i = 1:length(Parms_To_Zero(:,1))
    [t2, y2] = parasitesFn(Parms_To_Zero(i,1), Parms_To_Zero(i,2), Parms_To_Zero(i,3));
    plot(t2,y2(:,1))
    legend("X1")
    title("X1 to 0")
    hold on
end





%% OLD
while i <= gridSize
    
    k3 = X(randi([1 gridSize]));
    k4 = Y(randi([1 gridSize]));
    k5 = Z(randi([1 gridSize]));
    
    while valid == false
        
        while ~(sum(k3 ~= Parms(:,1)) == n) 
            k3 = X(randi([1 gridSize]));
        end
        
        while ~(sum(k4 ~= Parms(:,2)) == n) 
            k4 = Y(randi([1 gridSize]));
        end 
        
        while  ~(sum(k5 ~= Parms(:,3)) == n) 
            k5 = Z(randi([1 gridSize]));
        end

        valid = true;
    end
    
    Parms(i,:) = [k3 k4 k5];
    valid = false;
    i = i + 1;

end




