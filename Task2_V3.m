%% Task 2 - Latin Hypercube Sampling
clear

% Initialisations
n = 50;             % max range
stepSize = 0.1;       % step size

sampleLength = n*stepSize;  % size of each array/ no of samples to be taken

its = 100000;

Parms = zeros(sampleLength*its, 3);

for j = 1:its
    
    % initialise parameter sample arrays
    k3 = zeros(sampleLength,1);
    k4 = zeros(sampleLength,1);
    k5 = zeros(sampleLength,1);
    
    % set up second array with allowed values in the range
    X = linspace(0,n,(sampleLength)+1);
    Y = linspace(0,n,(sampleLength)+1);
    Z = linspace(0,n,(sampleLength)+1);
    
    % randomly shuffle each X,Y,Z array
    k3Nums = X(randperm(sampleLength,sampleLength));
    k4Nums = Y(randperm(sampleLength,sampleLength));
    k5Nums = Z(randperm(sampleLength,sampleLength));
    
    % for each element in the array
    for i = 1:length(k3Nums)
        
        % calculate the range between the vertices of the cube
        rng = 1/ stepSize;
        
        % calculate a random number and to add to bottom array vertice
        % random number will be between the two vertices
        k3(i) = (k3Nums(i)) + (rng*rand());
        k4(i) = (k4Nums(i)) + (rng*rand());
        k5(i) = (k5Nums(i)) + (rng*rand());
    end
    
    % store the parameters
%     if j == 1
%         Parms = [k3, k4, k5];
%     else
%         Parms = Parms + [k3, k4, k5];
%     end
     index = 1+(j-1)*sampleLength:sampleLength+(j-1)*sampleLength;
     Parms(index,:) = [k3, k4, k5];
    
end

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
% Parms_X1 = zeros(n,3);
% Parms_X2 = zeros(n,3);

% initialise counters  
j = 1;
k = 1;

for i = 1:n
    
    % solve ode
    [t,y] = parasitesFn(Parms(i,1), Parms(i,2), Parms(i,3));
    
    if ~any(y < 0) % check it doesn't fall below 0
        
        if ((y(end,1) < Tol)) %&& y(end,2) > Tol) % Check for X1 => 0 at end
            
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

%% Visuals

% % plane calcs
% [x, y] = meshgrid(0:1:50);
% z = 1.25.*x;
% 
% [x1, z1] = meshgrid(0:1:50);
% y1 = 0.5.*x1;

%%
figure(1)
grid on
pp = plot3(Parms_X1(:,1), Parms_X1(:,2), Parms_X1(:,3), 'b.', ...
    Parms_X2(:,1), Parms_X2(:,2), Parms_X2(:,3), 'r.');
pp(1).MarkerSize = 8;
pp(2).MarkerSize = 8;
xlabel("k1")
ylabel("k2")
zlabel("k3")
xlim([0 50]); ylim([0 50]); zlim([0 50])
% hold on
% ff = surf(x,y,z)
% set(ff, 'edgecolor','none','facecolor',[.9 .9 .9], 'FaceAlpha', 0.8)
% hold on
% gg = surf(x1,y1,z1)
% grid on
% set(gg, 'edgecolor','none','facecolor',[.75 .75 .75], 'FaceAlpha', 0.8)

% legend("X1 -> 0", "X2 -> 2", "z = 1.25x", "y = 0.5x")



%%
figure(2) 
for i = 1:length(Parms_X1(:,1))
    [t1, y1] = parasitesFn(Parms_X1(i,1), Parms_X1(i,2), Parms_X1(i,3));
    plot(t1,y1(:,1))
    legend( "X1")
    title("X1 to 0")
    hold on
end



