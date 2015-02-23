function [angles,speeds] = rk4sys_integrator( N, ti, tf, u0, f )
% Runge-Kutta 4th order method for ODE IVP system: 
% u' = f(t,u), u(0) = u0
% with N steps over the time interval [ti,tf],
% u and f are vector functions
u = u0; h = (ti - tf)/N; t = ti;
us = {};
angles = zeros(N,1);
speeds = zeros(N,1);
for i = 1 : N
    k1 = f(t,u);
    k2 = f(t + h/2, u + h*k1/2);
    k3 = f(t + h/2, u + h*k2/2);
    k4 = f(t + h, u + h*k3);
    u = u + h*(k1 + 2*k2 + 2*k3 + k4)/6;
    us{i} = u;
    t = t + h;
    angles(i) = u(1);
    speeds(i) = u(2);
    fprintf('angle = %f, speed = %f\n', u(1), u(2));
end
