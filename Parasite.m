function [dydt] = Parasite(t,y,k1,k2,k3,k4,k5)
% Parasite 2D function
% To be used with ODE45

X1 = y(1);
X2 = y(2);

dX1dt = k1*X1*X2 - k2*X1;
dX2dt = k3 - k4*X2 - k5*X1;

dydt = [dX1dt,dX2dt]';


end