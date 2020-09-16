%% Exercício 4 - Lista 3

%% Description 
% Simulação de um controlador PD independente por junta para acompanhamento
% do braço planar de três juntas.

%% Version Control
%
% 1.0; Karoline C. Burger; 2017/08/25 ; First issue.
%  
% 1.1; Karoline C. Burger; 2019/10/14; Modifications.
%
%% Script 

% Parâmetros do sistema
K = 17.7;
Jeff = 2.2;
Beff = 50;
T = Jeff/Beff;
r = 0.01;

%% Item a

% Calculo parâmetros de controle
qsi = 1;
wn =10; % chute
Kd = (2*qsi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 10;

% N = 15; % chute
% Kd = Kp*Td;
Td = Kd/Kp;
Ts = 1/100;

SP_theta = [0 0 0];

% Arrange trajectory points in a vector
% traj_th1 = [0, 10  0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0];
% traj_th2 = [0,  0, 0, 0, 10, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0];
% traj_th3 = [0,  0, 0, 0,  0, 0, 0, 10, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th1 = [0, 5, 10];
traj_th2 = [0, 0, 0];
traj_th3 = [0, 0, 0];

T = 5;

% Update rate and evaluation time vector
simulation_time = ((length(traj_th1)-1)*T);
rate = 1/simulation_time;

% Call high level function
[t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
[t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
[t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);

th_path = [t1' th1_path' th2_path' th3_path'];
dth_path = [t1' dth1_path' dth2_path' dth3_path'];
ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path'];

% sim('ControlePD_ind')
sim('ControleFF_trajetoria_D_integrado_RRR')

% Plots
close all

figure;
subplot(3,1,1)
plot(tout,th1,'b',tout,thd1,'--b');
title('Posição angular da junta 1');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_1 (º)')
legend('$\theta_1$', '$\theta^d_1$','Interpreter','latex');

subplot(3,1,2)
plot(tout,th2,'r',tout,thd2,'--r');
title('Posição angular da junta 2');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_2 (º)')
legend('$\theta_2$', '$\theta^d_2$','Interpreter','latex');

subplot(3,1,3)
plot(tout,th3,'m',tout,thd3,'--m');
title('Posição angular da junta 3');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_3 (º)')
legend('$\theta_3$', '$\theta^d_3$','Interpreter','latex');

figure;
plot(tout,th1,'b',tout,thd1,'--b',tout,th2,'r',tout,thd2,'--r',tout,th3,'m',tout,thd3,'--m');
title('Posição angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Posição angular (º)')
legend('$\theta_1$','$\theta^d_1$','$\theta_2$','$\theta^d_2$',...
    '$\theta_3$','$\theta^d_3$','Interpreter','latex');

figure;
plot(tout,dth1,'b',tout,dth2,'r',tout,dth3,'m');
title('Velocidade angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Velocidade angular (º/s)')
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$','Interpreter','latex');

figure;
subplot(2,1,1)
plot(tout,erro1,'b',tout,erro2,'r',tout,erro3,'m');
title('Erro')
grid('on')
xlabel('Tempo (s)'); ylabel('Ângulo (º)')
legend('$e_1$', '$e_2$', '$e_3$','Interpreter','latex');

subplot(2,1,2)
plot(tout,Vcontrole1,'b',tout,Vcontrole2,'r',tout,Vcontrole3,'m');
title('Tensão de controle (V)')
grid('on')
xlabel('Tempo (s)');
legend('V_1', 'V_2', 'V_3');

%% Item b

SP_theta = [0, 0, 0];
Theta_final = [90, 0, 0];

% Valores trajetoria exercicio 3
[thpath,thdotpath,thdotdotpath] = createTrajectory(SP_theta, Theta_final);

% sim('ControlePD_ind_itemb');
sim('ControlePD_ind_itemb')

% Adjusting format
p = length(th1);
thd1 = reshape(thd1,[1,p]);
thd2 = reshape(thd2,[1,p]);
thd3 = reshape(thd3,[1,p]);

% Plots
% close all

figure;
subplot(3,1,1)
plot(tout,th1,'b',tout,thd1,'--b');
title('Posição angular da junta 1');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_1 (º)')
legend('$\theta_1$', '$\theta^d_1$','Interpreter','latex');

subplot(3,1,2)
plot(tout,th2,'r',tout,thd2,'--r');
title('Posição angular da junta 2');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_2 (º)')
legend('$\theta_2$', '$\theta^d_2$','Interpreter','latex');

subplot(3,1,3)
plot(tout,th3,'m',tout,thd3,'--m');
title('Posição angular da junta 3');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_3 (º)')
legend('$\theta_3$', '$\theta^d_3$','Interpreter','latex');


figure;
plot(tout,th1,'b',tout,thd1,'--b',tout,th2,'r',tout,thd2,'--r',tout,th3,'m',tout,thd3,'--m');
title('Posição angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Posição angular (º)')
legend('$\theta_1$','$\theta^d_1$','$\theta_2$','$\theta^d_2$',...
    '$\theta_3$','$\theta^d_3$','Interpreter','latex');

figure;
plot(tout,dth1,'b',tout,dth2,'r',tout,dth3,'m');
title('Velocidade angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Velocidade angular (º/s)')
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$','Interpreter','latex');

figure;
subplot(2,1,1)
plot(tout,erro1,'b',tout,erro2,'r',tout,erro3,'m');
title('Erro')
grid('on')
xlabel('Tempo (s)'); ylabel('Ângulo (º)')
legend('$e_1$', '$e_2$', '$e_3$','Interpreter','latex');

subplot(2,1,2)
plot(tout,Vcontrole1,'b',tout,Vcontrole2,'r',tout,Vcontrole3,'m');
title('Tensão de controle (V)')
grid('on')
xlabel('Tempo (s)');
legend('V_1', 'V_2', 'V_3');


