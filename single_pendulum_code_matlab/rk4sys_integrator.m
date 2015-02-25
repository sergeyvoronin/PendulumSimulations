function [angles,speeds] = rk4sys_integrator( N, ti, tf, u0, f )
% Runge-Kutta 4th order method for ODE IVP system: 
% u' = f(t,u), u(0) = u0
% with N steps over the time interval [ti,tf],
% u and f are vector functions
h = (tf - ti)/N; 
theta = u0(1); v = u0(2); t = ti;
angles = zeros(N,1);
speeds = zeros(N,1);
for i = 1 : N
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


    angles(i) = u(1);
    speeds(i) = u(2);
    fprintf('angle = %f, speed = %f\n', u(1), u(2));
end
