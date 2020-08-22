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

% Especificacoes de set-point
SP_theta = [0;0;0;0;0];

% Especificacoes do degrau
ganho_degrau = [5;5;5;5;5];
tempo_degrau = [10;20;30;40;50];

simulation_time = 60;

% sim('ControlePD_ind')
sim('ControlePD_5juntas', simulation_time)
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
% title('Posição angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Posição angular (º)')
legend('$\theta_1$','$\theta^d_1$','$\theta_2$','$\theta^d_2$',...
    '$\theta_3$','$\theta^d_3$','$\theta_4$','$\theta^d_4$',...
    '$\theta_5$','$\theta^d_5$','Interpreter','latex', 'FontSize', 13);

figure;
plot(tout,dth1,'b',tout,dth2,'r',tout,dth3,'m',tout,dth4,'g',tout,dth5,'c');
% title('Velocidade angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Velocidade angular (º/s)')
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$', ...
       '$\dot{\theta}_4$', '$\dot{\theta}_5$', 'Interpreter','latex', 'FontSize', 13);

figure;
% subplot(2,1,1)
plot(tout,erro1,'b',tout,erro2,'r',tout,erro3,'m',tout,erro4,'g',tout,erro5,'c');
% title('Erro')
grid('on')
xlabel('Tempo (s)'); ylabel('Ângulo (º)')
legend('e_1', 'e_2', 'e_3', 'e_4', 'e_5', 'FontSize', 11);
figure;
% subplot(2,1,2)
plot(tout,Vcontrole1,'b',tout,Vcontrole2,'r',tout,Vcontrole3,'m', ...
     tout,Vcontrole4,'g',tout,Vcontrole5,'c');
% title('Tensão de controle')
grid('on')
xlabel('Tempo (s)');  ylabel('Tensão (V)')
legend('V_1', 'V_2', 'V_3', 'V_4', 'V_5', 'FontSize', 11);

%% Funcoes

function plot_angular_position(thr, thd, tout, joint_number, color)
    plot(tout,thr,color,tout,thd,strcat('--',color));
%     title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
%     grid('on')
%     xlabel('Tempo (s)')
%     ylabel('Posição (º)')
%     legend(strcat('$\theta_{',int2str(joint_number),'r}$'), strcat( ...
%          '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
%     set(gca,'FontSize',8)
end

function plot_angular_velocity(thr, thd, tout, joint_number, color)
    plot(tout,thr,color,tout,thd,strcat('--',color));
%     title(strcat('Velocidade angular da junta',{' '},int2str(joint_number)))
%     grid('on')
%     xlabel('Tempo (s)')
%     ylabel('Velocidade (º/s)')
%     legend(strcat('$\dot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
%       '$\dot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
%   set(gca,'FontSize',8)
end
