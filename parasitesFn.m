function [t, y] = parasitesFn(k3, k4, k5)
% Parasite Model
% X1 represents a population of parasites that feeds off a population X2. 
% k1 represents the birth rate of X1
% k2 represents the death rate of X1
% k3 represents the rate of food growth
% k4 represents food decay 
% k5 represents food consumption by the parasites
% All these constants are positive.

% y contains a vector [X1, X2]

% Bridget McCarron n9962263

% T = 20 time units
tspan = [0 20];

% k1 and k2 are fixed
k1 = 1;
k2 = 2;

% Initial values
initialVals = zeros(2,1);
initialVals(1) = 1;         % X1(0) = 1
initialVals(2) = 1;         % X2(0) = 1

% Differential Equation system
parasiteODE = @(t,y) [  k1*y(1)*y(2) - k2*y(1)    ;
                        k3 - k4*y(2) - k5*y(1) ];
                 
% solve using ODE45
[t, y] = ode45(parasiteODE, tspan, initialVals);
                    
               

