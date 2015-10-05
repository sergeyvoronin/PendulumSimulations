% driver for single pendulum simulation
close all; clear all;

m = 2000;
alpha = 0;
g = 9.8;
l = 10;
%theta0 = 0.75*pi;
theta0 = 0.99*pi;
v0 = 0;

f = @(t,u)[ u(2); -(alpha/m)*u(2) - (g/l)*sin(u(1)) ];


%rk4sys_integrator( N, a, b, y0, f )
[angles,speeds] = rk4sys_integrator( 2000, 0, 20, [theta0; v0], f ); 

plot_pendulum(l,angles,0);

