clear all
close all

% Cubic polynomials [Craig pag 203]

syms a0(th0) a1 a2(th0, thf, tf) a3(th0, thf, tf) th(t) dth(t) ddth(t)

% Position equation coefficients
a0(th0) = th0;
a1 = 0;
a2(th0, thf, tf) = 3/tf^2 * (thf - th0);
a3(th0, thf, tf) = -2/tf^3 * (thf - th0);

% Numeric values
th0 = 15;
thf = 75;
tf = 3;

% Applying numeric values to determine coefficients
a0 = a0(th0);
a2 = a2(th0, thf, tf);
a3 = a3(th0, thf, tf);

% Position, velocity and acceleration equations
th(t) = a0 + a1*t + a2*t^2 + a3*t^3;
dth(t) = a1 + 2*a2*t + 3*a3*t^2;
ddth(t) = 2*a2 + 6*a3*t;

% Plot solutions
t = 0:0.1:tf;
th_plot = [];
dth_plot = [];
ddth_plot = [];

for i=t
    th_plot = [th_plot, th(i)];
    dth_plot = [dth_plot, dth(i)];
    ddth_plot = [ddth_plot, ddth(i)];
end

figure (1)
subplot(3,1,1)
plot(t, th_plot)
subplot(3,1,2)
plot(t, dth_plot)
subplot(3,1,3)
plot(t, ddth_plot)

%%
clear all
close all
% Cubic polynomials for a path with via points [Craig pag 205]

syms a0(th0) a1(dth0) a2(th0, thf, dth0, dthf, tf) a3(th0, thf, dth0, dthf, tf) th(t)

% Position equation coefficients
a0(th0) = th0;
a1(dth0) = dth0;
a2(th0, thf, dth0, dthf, tf) = 3/tf^2*(thf - th0) - 2/tf*dth0 - 1/tf*dthf;
a3(th0, thf, dth0, dthf, tf) = -2/tf^3*(thf - th0) + 1/tf^2*(dthf + dth0);

% Numeric values
th0 = 15;
thf = 75;
dth0 = 1;
dthf = 1;
tf = 3;

% cc = cubcoef(th0, dth0, thf, dthf, tf);

% Applying numeric values to determine coefficients
a0 = a0(th0);
a1 = a1(dth0);
a2 = a2(th0, thf, dth0, dthf, tf);
a3 = a3(th0, thf, dth0, dthf, tf);

% Position, velocity and acceleration equations
th(t) = a0 + a1*t + a2*t^2 + a3*t^3;
dth(t) = a1 + 2*a2*t + 3*a3*t^2;
ddth(t) = 2*a2 + 6*a3*t;

% Plot solutions
t = 0:0.1:tf;
th_plot = [];
dth_plot = [];
ddth_plot = [];

for i=t
    th_plot = [th_plot, th(i)];
    dth_plot = [dth_plot, dth(i)];
    ddth_plot = [ddth_plot, ddth(i)];
end

figure (1)
subplot(3,1,1)
plot(t, th_plot)
subplot(3,1,2)
plot(t, dth_plot)
subplot(3,1,3)
plot(t, ddth_plot)

%%
% Quintic polynomials [Craig pag 210]
clear all
close all

syms th(t) a0(th0) a1(dth0) a2(ddth0) a3(th0, thf, dth0, dthf, ddth0, ddthf, tf) a4(th0, thf, dth0, dthf, ddth0, ddthf, tf) a5(th0, thf, dth0, dthf, ddth0, ddthf, tf)

% Position equation coefficients
a0(th0) = th0;
a1(dth0) = dth0;
a2(ddth0) = ddth0/2;
a3(th0, thf, dth0, dthf, ddth0, ddthf, tf) = (20*thf - 20*th0 - (8*dthf + 12*dth0)*tf - 3*(ddth0 - ddthf)*tf^2)/(2*tf^3);
a4(th0, thf, dth0, dthf, ddth0, ddthf, tf) = (30*th0 - 30*thf + (14*dthf + 16*dth0)*tf + (3*ddth0 - 2*ddthf)*tf^2)/(2*tf^4);
a5(th0, thf, dth0, dthf, ddth0, ddthf, tf) = (12*thf - 12*th0 - (6*dthf + 6*dth0)*tf - (ddth0 - ddthf)*tf^2)/(2*tf^5);

% Numeric values
th0 = 15;
thf = 75;
dth0 = 1;
dthf = 1;
ddth0 = 1;
ddthf = -1;
tf = 3;

% Applying numeric values to determine coefficients
a0 = a0(th0);
a1 = a1(dth0);
a2 = a2(ddth0);
a3 = a3(th0, thf, dth0, dthf, ddth0, ddthf, tf);
a4 = a4(th0, thf, dth0, dthf, ddth0, ddthf, tf);
a5 = a5(th0, thf, dth0, dthf, ddth0, ddthf, tf);

% Position, velocity and acceleration equations
th(t) = a0 + a1*t + a2*t^2 + a3*t^3 + a4*t^4 + a5*t^5;
dth(t) = a1 + 2*a2*t + 3*a3*t^2 + 4*a4*t^3 + 5*a5*t^4;
ddth(t) = 2*a2 + 6*a3*t + 12*a4*t^2 + 20*a5*t^3;

% Plot solutions
t = 0:0.1:tf;
th_plot = [];
dth_plot = [];
ddth_plot = [];

for i=t
    th_plot = [th_plot, th(i)];
    dth_plot = [dth_plot, dth(i)];
    ddth_plot = [ddth_plot, ddth(i)];
end

figure (1)
subplot(3,1,1)
plot(t, th_plot)
subplot(3,1,2)
plot(t, dth_plot)
subplot(3,1,3)
plot(t, ddth_plot)

%%
clear all
close all
% Cubic polynomials for a path with via points [Exercicio 1 da lista de geracao de trejetorias do Fabio]

th0 = 15;
th1 = 70;
th2 = 13;
th3 = 35;
thf = 75;
T = 3;

% Arrange trajectory points in a vector
traj_points = [th0, th1, th2, th3, thf];

% Vectors of cubic coefficients (one segment per line)
cctot = trajectoryplanning(traj_points, T);

% Update rate and evaluation time vector
rate = 0.1;
t_eval = rate:rate:T;

t = [0];
th_plot = [th0];
dth_plot = [0];
ddth_plot = [0];

for k = 1:size(cctot, 1)
    a0 = cctot(k,1);
    a1 = cctot(k,2);
    a2 = cctot(k,3);
    a3 = cctot(k,4);
    
    tk = (k-1)*T+rate:rate:k*T;
    t = [t, tk];
    
    th_plot = [th_plot, a0 + a1*t_eval + a2*t_eval.^2 + a3*t_eval.^3];
    dth_plot = [dth_plot, a1 + 2*a2*t_eval + 3*a3*t_eval.^2];
    ddth_plot = [ddth_plot, 2*a2 + 6*a3*t_eval];
end

figure (1)
subplot(3,1,1)
plot(t, th_plot)
subplot(3,1,2)
plot(t, dth_plot)
subplot(3,1,3)
plot(t, ddth_plot)