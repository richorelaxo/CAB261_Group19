%% Task 2 Attempt 2
clear all;
clc;
close all;

%% seems about right

n = 50;                     % n is the range max
gridSize = 2*n+1;           % size of the grid 2*50 + 1 (index from [1 51])

X = linspace(0,n,gridSize);      % 0 to n with 51 steps
Y = linspace(0,n,gridSize);
Z = linspace(0,n,gridSize);

Parms = -1*ones(n,3);    % store parameters
valid = false;

i = 1;

while i <= gridSize
    
    k1 = X(randi([1 gridSize]));
    k2 = Y(randi([1 gridSize]));
    k3 = Z(randi([1 gridSize]));
    
    while valid == false
        
        while ~(sum(k1 ~= Parms(:,1)) == n) 
            k1 = X(randi([1 gridSize]));
        end
        
        while ~(sum(k2 ~= Parms(:,2)) == n) 
            k2 = Y(randi([1 gridSize]));
        end 
        
        while  ~(sum(k3 ~= Parms(:,3)) == n) 
            k3 = Z(randi([1 gridSize]));
        end

        valid = true;
    end
    
    Parms(i,:) = [k1 k2 k3];
    valid = false;
    i = i + 1;

end


%% FROM MATT // Parameter check
% 3tuple parameter sweep k3,k4 and k5

Tol = 1e-2;
k1 = 1;
k2 = 2;
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
    f = @(t,y) Parasite(t,y,k1,k2,Parms(i,1),Parms(i,2),Parms(i,3));
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
    
    f = @(t,y) Parasite(t,y,k1,k2,Parms(i,1),Parms(i,2),Parms(i,3));
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



