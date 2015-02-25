function [angles,vs] = rk4sys_integrator( g,l, alpha, m, theta0, v0, N, ti, tf)
% Runge-Kutta 4th order method for ODE IVP system: 
% u' = f(t,u), u(0) = u0
% with N steps over the time interval [ti,tf],
% u and f are vector functions
h = (tf - ti)/N; 
theta = theta0; v = v0; t = ti;
angles = zeros(N,1);
vs = zeros(N,1);
angles(1) = theta;
vs(1) = v;
for i = 2 : N
    whos t u
    k11 = h*v;
    k12 = -h*(alpha/m)*v - h*(g/l)*sin(theta);

    k21 = h*(v + k11/2);
    k22 = -h*(alpha/m)*(v + k12/2) - h*(g/l)*sin(theta + k12/2);

    k31 = h*(v + k21/2);
    k32 = -h*(alpha/m)*(v + k22/2) -h*(g/l)*sin(theta + k22/2);

    k41 = h*(v + k31);
    k42 =  -h*(alpha/m)*(v + k32) - h*(g/l)*sin(theta + k32);

    theta = theta + (k11 + 2*k21 + 2*k31 + k41)/6;
    v = v + (k12 + 2*k22 + 2*k32 + k42)/6;
    t = t + h;

    angles(i) = theta;
    vs(i) = v;
    fprintf('angle = %f, v = %f\n', theta, v);
end
