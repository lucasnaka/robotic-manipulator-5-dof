%% Description 
% Simulação de um controlador PD independente por junta

%% Script 
clear all
close all

% Parâmetros do sistema
K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
Jeff = 0.5;
Beff = 50;
T = Jeff/Beff;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem

% Valores para o nosso manipulador robotico
% Jeff_teste = J_mk + r_k^2*m_kk_medio;
% Beff = B_mk + K_bk*K_mk/R_k;

% Calculo parâmetros de controle
xi = 1;
% ts = 0.9;
wn = 15; % chute // fazer o bode para tirar o wn
Kd = (2*xi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 3;

% Kd = Kp*Td;
Td = Kd/Kp;
Ts = 1/100;

% Tf = tf([(K*Kp/Jeff)^2],[1 (Beff+K*Kd)/Jeff K*Kp/Jeff]);
% figure (1)
% bode(Tf)
% figure (2)
% nichols(Tf)
% ngrid

SP_theta = [0 0 0 0 0];

% Usando a funcao de alto nivel "geraTrajetoria"

% Arrange trajectory points in a vector
traj_th1 = [0, 5, 10];
T = 3;

% Update rate and evaluation time vector
rate = 1;

% Call high level function
[t1, th1, dth1, ddth1] = geraTrajetoria(traj_th1, T, rate);

thpath = [0 0 0 0 0];
thdotpath = [0 0 0 0 0];
thdotdotpath = [0 0 0 0 0];

simulation_time = 30;

% sim('ControlePD_ind')
sim('ControleFF', simulation_time)
%%
% Plots
close all

% Plot posicoes angulares
figure;
subplot(5,1,1)
plot_angular_position(th1, thd1, tout, 1, 'b')

subplot(5,1,2)
plot_angular_position(th2, thd2, tout, 2, 'r')

subplot(5,1,3)
plot_angular_position(th3, thd3, tout, 3, 'm')

subplot(5,1,4)
plot_angular_position(th4, thd4, tout, 4, 'g')

subplot(5,1,5)
plot_angular_position(th5, thd5, tout, 5, 'c')

figure;
plot(tout,th1,'b',tout,thd1,'--b',tout,th2,'r',tout,thd2,'--r',tout,th3,'m', ...
    tout,thd3,'--m',tout,th4,'g',tout,thd4,'--g',tout,th5,'c',tout,thd5,'--c');
title('Posição angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Posição angular (º)')
legend('$\theta_1$','$\theta^d_1$','$\theta_2$','$\theta^d_2$',...
    '$\theta_3$','$\theta^d_3$','$\theta_4$','$\theta^d_4$',...
    '$\theta_5$','$\theta^d_5$','Interpreter','latex');

figure;
plot(tout,dth1,'b',tout,dth2,'r',tout,dth3,'m',tout,dth4,'g',tout,dth5,'c');
title('Velocidade angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Velocidade angular (º/s)')
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$', ...
       '$\dot{\theta}_4$', '$\dot{\theta}_5$', 'Interpreter','latex');

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

%% Item b

% Valores trajetoria exercicio 3
[thpath,thdotpath,thdotdotpath] = ex3_function(1/100);

% sim('ControlePD_ind_itemb');
sim('ControlePD_ind_sat_itemb')

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

%% Funcoes

function plot_angular_position(th, thd, tout, joint_number, color)
    plot(tout,th,color,tout,thd,strcat('--',color));
    title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo (s)')
    ylabel(strcat('\theta_',int2str(joint_number),' (º)'))
    legend(strcat('$\theta_',int2str(joint_number),'$'), strcat( ...
         '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex');
end
