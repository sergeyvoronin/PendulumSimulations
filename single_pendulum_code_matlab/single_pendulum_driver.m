% driver for single pendulum simulation

g = 9.8;
l = 10;
theta0 = 3.1416/4;
v0 = 0;
ti = 0; 
tf = 20;
N = 1500;
alpha = 30;
m = 50;

[angles,speeds] = rk4sys_integrator( g,l, alpha, m, theta0, v0, N, ti, tf); 

plot_pendulum(l,angles,0);
