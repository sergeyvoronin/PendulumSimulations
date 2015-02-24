% driver for single pendulum simulation

g = 9.8;
l = 10;
theta0 = 3.1416/4;
v0 = 0;
ti = 0; 
tf = 20;
N = 1500;

f = @(t,u)[ u(2); -(g/l)*sin(u(1)) ];

[angles,speeds] = rk4sys_integrator( N, ti, tf, [theta0; v0], f ); 

plot_pendulum(l,angles,0);
