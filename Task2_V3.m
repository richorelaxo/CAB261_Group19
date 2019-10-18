%% Task 2

% Initialisations
n = 50;
stepSize = 1;

sampleLength = n*stepSize;

for j = 1:10 % how many times to loop through
    
    % initialise
    k3 = zeros(n,1);
    k4 = zeros(n,1);
    k5 = zeros(n,1);
    
    X = linspace(0,n,(sampleLength)+1); % 0 to n with n*stepSize steps
    Y = linspace(0,n,(sampleLength)+1);
    Z = linspace(0,n,(sampleLength)+1);
    
    k3Nums = X(randperm(sampleLength,sampleLength));
    k4Nums = Y(randperm(sampleLength,sampleLength));
    k5Nums = Z(randperm(sampleLength,sampleLength));
    
    % find random number between each array element 
    % and the next vertice and save as k
    for i = 1:length(k3Nums)
        
        % rng = vertex -  (vertex - stepsize)
        rng3 = k3Nums(i) - (k3Nums(i) - stepSize);
        rng4 = k4Nums(i) - (k4Nums(i) - stepSize);
        rng5 = k5Nums(i) - (k5Nums(i) - stepSize);
        
        % k3 = (vertex - 1) + rng*rand()
        % values between 0 and 50
        k3(i) = (k3Nums(i)) + (rng3*rand());
        k4(i) = (k4Nums(i)) + (rng4*rand());
        k5(i) = (k5Nums(i)) + (rng5*rand());
    end
    
    % store the parameters
    
    Parms(:,:) = [k3(:), k4(:), k5(:)];
    
    if j == 1
        allParms = Parms;
    else
        allParms(length(allParms):length(allParms) + length(Parms)-1,:) = Parms;
    end

end


Parms = allParms;
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

for i = 1:n
    
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

%% Visuals

% plane calcs
[x, y] = meshgrid(0:1:50);
z = 1.25.*x;

[x1, z1] = meshgrid(0:1:50);
y1 = 0.5.*x1;

%%
figure(1)
grid on
pp = plot3(Parms_X1(:,1), Parms_X1(:,2), Parms_X1(:,3), 'b.', ...
    Parms_X2(:,1), Parms_X2(:,2), Parms_X2(:,3), 'r.')
pp(1).MarkerSize = 8;
pp(2).MarkerSize = 8;
xlabel("k1")
ylabel("k2")
zlabel("k3")
xlim([0 50]); ylim([0 50]); zlim([0 50])
hold on
ff = surf(x,y,z)
set(ff, 'edgecolor','none','facecolor',[.9 .9 .9], 'FaceAlpha', 0.8)
hold on
gg = surf(x1,y1,z1)
grid on
set(gg, 'edgecolor','none','facecolor',[.75 .75 .75], 'FaceAlpha', 0.8)

legend("X1 -> 0", "X2 -> 2", "z = 1.25x", "y = 0.5x")



%%
figure(2) 
for i = 1:length(Parms_X1(:,1))
    [t1, y1] = parasitesFn(Parms_X1(i,1), Parms_X1(i,2), Parms_X1(i,3));
    plot(t1,y1(:,1))
    legend( "X1")
    title("X1 to 0")
    hold on
end



