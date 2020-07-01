%% Description 
% Simulação de um controlador PD independente por junta

%% Script 
clear all
close all
clc

% Parâmetros do sistema
K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
Jeff = 0.5;
Beff = 50;
T = Jeff/Beff;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem

% Calculo parâmetros de controle
xi = 1;
wn = 15; % chute // fazer o bode para tirar o wn
Kd = (2*xi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 3;

% Kd = Kp*Td;
Td = Kd/Kp;
Ts = 1/100;

SP_theta = [0 0 0 0 0];

% Usando a funcao de alto nivel "geraTrajetoria"

% Arrange trajectory points in a vector
% traj_th1 = [0, 5, 0, 0, 0, 0, 0];
% traj_th2 = [0, 0, 5, 0, 0, 0, 0];
% traj_th3 = [0, 0, 0, 5, 0, 0, 0];
% traj_th4 = [0, 0, 0, 0, 5, 0, 0];
% traj_th5 = [0, 0, 0, 0, 0, 5, 0];
traj_th1 = [0, 5, 10];
traj_th2 = [0, 0, 0];
traj_th3 = [0, 0, 0];
traj_th4 = [0, 0, 0];
traj_th5 = [0, 0, 0];

T = 30;

% Update rate and evaluation time vector
simulation_time = ((length(traj_th1)-1)*T);
rate = 1/simulation_time;

% Call high level function
[t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
[t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
[t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);
[t4, th4_path, dth4_path, ddth4_path] = geraTrajetoria(traj_th4, T, rate);
[t5, th5_path, dth5_path, ddth5_path] = geraTrajetoria(traj_th5, T, rate);

th_path = [t1' th1_path' th2_path' th3_path' th4_path' th5_path'];
dth_path = [t1' dth1_path' dth2_path' dth3_path' dth4_path' dth5_path'];
ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path' ddth4_path' ddth5_path'];

sim('ControleFF_trajetoria_D', simulation_time)

%%
% Plots
close all

figure;
subplot(5,1,1)
plot_angular_position_ff(th1r, th1_path, tout, 1, 'b')

subplot(5,1,2)
plot_angular_position_ff(th2r, th2_path, tout, 2, 'r')

subplot(5,1,3)
plot_angular_position_ff(th3r, th3_path, tout, 3, 'm')

subplot(5,1,4)
plot_angular_position_ff(th4r, th4_path, tout, 4, 'g')

subplot(5,1,5)
plot_angular_position_ff(th5r, th5_path, tout, 5, 'c')

figure;
subplot(2,1,1)
plot(tout,erro1,'b',tout,erro2,'r',tout,erro3,'m',tout,erro4,'g',tout,erro5,'c');
title('Erro')
grid('on')
xlabel('Tempo (s)'); ylabel('Ângulo (º)')
legend('$e_1$', '$e_2$', '$e_3$', '$e_4$', '$e_5$','Interpreter','latex');

subplot(2,1,2)
plot(tout,Vcontrole1,'b',tout,Vcontrole2,'r',tout,Vcontrole3,'m', ...
     tout,Vcontrole4,'g',tout,Vcontrole5,'c');
title('Tensão de controle')
grid('on')
xlabel('Tempo (s)');  ylabel('Tensão (V)')
legend('V_1', 'V_2', 'V_3', 'V_4', 'V_5');

% figure;
% plot(tout,th1_path,'b',tout,thetar(1),'--b',tout,th2_path,'r',tout,thetar(2),'--r', ...
%      tout,th3_path,'m',tout,thetar(3),'--m',tout,th4_path,'g',tout,thetar(4),'--g', ...
%      tout,th5_path,'c',tout,thetar(5),'--c');
% title('Posição angular das juntas');
% grid('on')
% xlabel('Tempo (s)'); ylabel('Posição angular (º)')
% legend('$\theta_1^d$','$\theta_{1r}$','$\theta_2^d$','$\theta_{2r}$', ...
%        '$\theta_3^d$','$\theta_{3r}$','$\theta_4^d$','$\theta_{4r}$', ...
%        '$\theta_5^d$','$\theta_{5r}$','Interpreter','latex');

% figure;
% plot(t1,dth1_path,'b',t1,dth2_path,'r',t1,dth3_path,'m',t1,dth4_path,'g',t1,dth5_path,'c');
% title('Velocidade angular das juntas');
% grid('on')
% xlabel('Tempo (s)'); ylabel('Posição angular (º)')
% legend('$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$','$\dot{\theta}_4$','$\dot{\theta}_5$', ...
%        'Interpreter','latex');
%    
% figure;
% plot(t1,ddth1_path,'b',t1,ddth2_path,'r',t1,ddth3_path,'m',t1,ddth4_path,'g',t1,ddth5_path,'c');
% title('Aceleração angular das juntas');
% grid('on')
% xlabel('Tempo (s)'); ylabel('Posição angular (º)')
% legend('$\ddot{\theta}_1$','$\ddot{\theta}_2$','$\ddot{\theta}_3$','$\ddot{\theta}_4$','$\ddot{\theta}_5$', ...
%        'Interpreter','latex');



%%
% Plots
close all

% Plot posicoes angulares


figure;
plot(tout,th1_path,'b',tout,thd1,'--b',tout,th2_path,'r',tout,thd2,'--r',tout,th3_path,'m', ...
    tout,thd3,'--m',tout,th4_path,'g',tout,thd4,'--g',tout,th5_path,'c',tout,thd5,'--c');
title('Posição angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Posição angular (º)')
legend('$\theta_1$','$\theta^d_1$','$\theta_2$','$\theta^d_2$',...
    '$\theta_3$','$\theta^d_3$','$\theta_4$','$\theta^d_4$',...
    '$\theta_5$','$\theta^d_5$','Interpreter','latex');

figure;
plot(tout,dth1_path,'b',tout,dth2_path,'r',tout,dth3_path,'m',tout,dth4_path,'g',tout,dth5_path,'c');
title('Velocidade angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Velocidade angular (º/s)')
legend('$\dot{\theta}_{1m}$', '$\dot{\theta}_{2m}$', '$\dot{\theta}_{3m}$', ...
       '$\dot{\theta}_{4m}$', '$\dot{\theta}_{5m}$', 'Interpreter','latex');

%% Funcoes

function plot_angular_position_ff(thr, thd, tout, joint_number, color)
    plot(tout,thr,color,tout,thd,strcat('--',color));
    title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo (s)')
    ylabel(strcat('\theta_',int2str(joint_number),' (º)'))
    legend(strcat('$\theta_{',int2str(joint_number),'r}$'), strcat( ...
         '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex');
end
