%% Task 2 - Latin Hypercube Sampling
% Bridget McCarron n9962263

clear

% Initialisations
n = 50;             % max range
spacingFactor = 10;       % step size

sampleLength = n*spacingFactor;  % size of each array/ no of samples to be taken
its = 100;         % number of iterations

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
        rng = 1/ spacingFactor;
        
        % calculate a random number and to add to bottom array vertice
        % random number will be between the two vertices
        k3(i) = (k3Nums(i)) + (rng*rand());
        k4(i) = (k4Nums(i)) + (rng*rand());
        k5(i) = (k5Nums(i)) + (rng*rand());
    end
     
     % index within Parms
     index = 1+(j-1)*sampleLength:sampleLength+(j-1)*sampleLength;
     
     % update Parms with new 3-tuple of parameters
     Parms(index,:) = [k3, k4, k5];
    
end

%% Parameter check

% tolerance
Tol = 1e-2;

% initialise position index  
j = 1;
k = 1;

for i = 1:length(Parms)
    
    % solve ode
    [t,y] = parasitesFn(Parms(i,1), Parms(i,2), Parms(i,3));
    
    if ~any(y < 0) % check it doesn't fall below 0
        
        if ((y(end,1) < Tol)) % Check for X1 => 0 at end
            
            % store if successful
            Parms_X1(j,:) = Parms(i,:); 
            % move indexer to next position
            j = j+1;       
            
        end % end check for X1 => 0
        
        if (abs(y(end,2) - 2) < Tol) % Checks for X2 => 2 at end
           
           % store if successful 
           Parms_X2(k,:) = Parms(i,:); 
           % move indexer to next position
           k = k+1;
           
        end % end check for X2 => 2
        
    end % end check for >= 0
    
end % end step through all

%% Calculations for planes at Boundaries

% Boundary 1
[x, y] = meshgrid(0:1:50);
z = 1.25.*x;

% Boundary 2
[x1, z1] = meshgrid(0:1:50);
y1 = 0.5.*x1;

%% Visualise 
figure(1)

% scatter(X,Y,Z) = scatter(k3,k4,k5)
pp = scatter3(Parms_X1(:,1), Parms_X1(:,2), Parms_X1(:,3), 'b.');
pp.MarkerEdgeAlpha = 0.4;
pp.MarkerFaceAlpha = 0.4;

hold on
% scatter(X,Y,Z) = scatter(k3,k4,k5)
hh = scatter3(Parms_X2(:,1), Parms_X2(:,2), Parms_X2(:,3), 'r.');
hh.MarkerEdgeAlpha = 0.4;
hh.MarkerFaceAlpha = 0.4;

xlabel("k3")
ylabel("k4")
zlabel("k5")
xlim([0 50]); ylim([0 50]); zlim([0 50])

hold on
% "z = 1.25x  (k5 = 1.25k3)"
ff = surf(x,y,z);
set(ff, 'edgecolor','none','facecolor',[.9 .9 .9], 'FaceAlpha', 0.8)

hold on
% "y = 0.5x (k4 = 0.5k3)"
gg = surf(x1,y1,z1);
set(gg, 'edgecolor','none','facecolor',[.75 .75 .75], 'FaceAlpha', 0.8)

leg = legend({"$X1 \Rightarrow 0$", "$X2 \Rightarrow 2$", ...
    "y = 0.5x (k4 = 0.5k3)","z = 1.25x  (k5 = 1.25k3)"}, ...
    "Interpreter", "Latex");

title({'Boundaries between regions','of interesting system dynamics'},...
    'Interpreter', 'latex', 'FontSize', 14);

% "z = 1.25x  (k5 = 1.25k3)"
% "y = 0.5x (k4 = 0.5k3)"

box on
grid on
ax = gca;
ax.TickLabelInterpreter = "Latex";
leg.Interpreter = "Latex";
leg.FontSize = 12;

%% Additional Plots

% Check X1 values are going to 0
% figure(2)
% for i = 1:80
%     [t1, y1] = parasitesFn(Parms_X1(i,1), Parms_X1(i,2), Parms_X1(i,3));
%     plot(t1,y1(:,1))
%     title({"$X1 \Rightarrow 0$"}, "Interpreter", "Latex", "FontSize", 16)
%     hold on
% end

%%
% Check X2 values are going to 2
% figure(3)
% for i = 1:80
%     [t1, y1] = parasitesFn(Parms_X2(i,1), Parms_X2(i,2), Parms_X2(i,3));
%     plot(t1,y1(:,2))
%     title({"$X2 \Rightarrow 2$"}, "Interpreter", "Latex", "FontSize", 16)
%     hold on
% end





