%% Part 2  %%
% 3tuple parameter sweep k3,k4 and k5

Tol = 1e-2;
k1 = 1;
k2 = 2;
n = 50; % n should equal how many lines in your (k3,k4,k5) storage vector


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

