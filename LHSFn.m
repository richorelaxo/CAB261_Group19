function Parms = LHSFn(n, gridSize)

Parms = -1*ones(gridSize,3);       % storage matrix for parameters

% ranges for the cube 
X = linspace(0,n,gridSize); % 0 to n with gridsize steps
Y = linspace(0,n,gridSize);
Z = linspace(0,n,gridSize);

for i = 1:gridSize
    
    % initialise
    k3 = X(randi([1 gridSize]));
    k4 = Y(randi([1 gridSize]));
    k5 = Z(randi([1 gridSize]));
    
    % check each variable is valid for LHS
    while ~(sum(k3 ~= Parms(:,1)) == gridSize)
        k3 = X(randi([1 gridSize]));
    end
    
    while ~(sum(k4 ~= Parms(:,2)) == gridSize)
        k4 = Y(randi([1 gridSize]));
    end
    
    while  ~(sum(k5 ~= Parms(:,3)) == gridSize)
        k5 = Z(randi([1 gridSize]));
    end
    
    % store parameters that create a valid LH sample
    Parms(i,:) = [k3 k4 k5];
    
end