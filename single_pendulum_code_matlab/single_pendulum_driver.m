% driver for single pendulum simulation

g = 9.8;
l = 10;
theta0 = pi/4;
v0 = .3;

f = @(t,u)[ u(2); -(g/l)*sin(u(1)) ];


%rk4sys_integrator( N, a, b, y0, f )
[angles,speeds] = rk4sys_integrator( 2000, 0, 20, [theta0; v0], f ); 

plot_pendulum(l,angles,0);

