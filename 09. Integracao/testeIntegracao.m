close all
clear
clc
%%
%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%

% Posicao atual
% Th = [0; 0; 0+offset3; 0; 0];
% cinematica_direta;
% thetaAtual = Th;
% 
% figure
% plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)

%%
%=========================================================================%
%                          Cinematica Inversa                             %
%=========================================================================%

% % Emulacao da posicao desejada
% Th = [pi/6; pi/4; pi/4+offset3; 0; pi/2];
% Th = [10*pi/180; 0; 0+offset3; 0; 0];
% cinematica_direta;
% T05_objetivo = T05;
% 
% thetaSolucao = cinInversa(thetaAtual, T05_objetivo);
% 
% Th = thetaSolucao;
% 
% figure
% plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)

%%
%=========================================================================%
%                       Geracao de Trajetoria                             %
%=========================================================================%
T = 40;

offset3 = -90;

SP_theta = [0 0 0 0 0]; % Condicao inicial de theta (em graus)
Theta_final = [90 0 0 0 0]; % Condicao inicial de theta (em graus)

traj_th1 = [SP_theta(1), Theta_final(1)];
traj_th2 = [SP_theta(2), Theta_final(2)];
traj_th3 = [SP_theta(3), Theta_final(3)];
traj_th4 = [SP_theta(4), Theta_final(4)];
traj_th5 = [SP_theta(5), Theta_final(5)];

simulation_time = ((length(traj_th1)-1)*T);
rate = 1/1000;

[t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
[t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
[t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);
[t4, th4_path, dth4_path, ddth4_path] = geraTrajetoria(traj_th4, T, rate);
[t5, th5_path, dth5_path, ddth5_path] = geraTrajetoria(traj_th5, T, rate);

th_path = [t1' th1_path' th2_path' th3_path' th4_path' th5_path'];
dth_path = [t1' dth1_path' dth2_path' dth3_path' dth4_path' dth5_path'];
ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path' ddth4_path' ddth5_path'];

%%
%=========================================================================%
%                               Controle                                  %
%=========================================================================%
K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
Jeff = 0.5;
Beff = 50;
T = Jeff/Beff;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem

xi = 1;
wn = 15; % chute // fazer o bode para tirar o wn
Kd = (2*xi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 3;

Td = Kd/Kp;
Ts = 1/100;

sim('ControleFF_trajetoria_D_integrado', simulation_time)

%% 
%=========================================================================%
%                                Plots                                    %
%=========================================================================%
figure;
subplot(5,1,1)
plot_angular_position_ff(Thr.signals.values(:,1), Thd_path.signals.values(:,1), Thr.time, 1, 'b')

subplot(5,1,2)
plot_angular_position_ff(Thr.signals.values(:,2), Thd_path.signals.values(:,2), Thr.time, 2, 'r')

subplot(5,1,3)
plot_angular_position_ff(Thr.signals.values(:,3), Thd_path.signals.values(:,3), Thr.time, 3, 'm')

subplot(5,1,4)
plot_angular_position_ff(Thr.signals.values(:,4), Thd_path.signals.values(:,4), Thr.time, 4, 'g')

subplot(5,1,5)
plot_angular_position_ff(Thr.signals.values(:,5), Thd_path.signals.values(:,5), Thr.time, 5, 'c')
grid('on')
xlabel('Tempo (s)')
ylabel('Posição(º)')
legend('$\theta_{1r}$', '$\theta^d_1$','$\theta_{2r}$', '$\theta^d_2$', ...
    '$\theta_{3r}$', '$\theta^d_3$', '$\theta_{4r}$', '$\theta^d_4$', ...
    '$\theta_{5r}$', '$\theta^d_5$', 'Interpreter', 'latex', 'FontSize', 12);

figure;
% subplot(2,1,1)
plot(tout,erro.signals.values(:,1),'b',tout,erro.signals.values(:,2),'r', ...
     tout,erro.signals.values(:,3),'m',tout,erro.signals.values(:,4),'g', ...
     tout,erro.signals.values(:,5),'c');
% title('Erro')
grid('on')
xlabel('Tempo (s)'); ylabel('Ângulo (º)')
legend('e_1', 'e_2', 'e_3', 'e_4', 'e_5', 'FontSize', 11);

figure;
% subplot(2,1,2)
plot(tout,Vcontrole.signals.values(:,1),'b',tout,Vcontrole.signals.values(:,2),'r', ...
     tout,Vcontrole.signals.values(:,3),'m',tout,Vcontrole.signals.values(:,4),'g', ...
     tout,Vcontrole.signals.values(:,5),'c');
% title('Tensão de controle')
grid('on')
xlabel('Tempo (s)');  ylabel('Tensão (V)')
legend('V_1', 'V_2', 'V_3', 'V_4', 'V_5', 'FontSize', 11)

%% Funçoes

function plot_angular_position_ff(thr, thd, tout, joint_number, color)
    plot(tout,thr,color,tout,thd,strcat('--',color));
%     title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
%     grid('on')
%     xlabel('Tempo (s)')
%     ylabel('Posição (º)')
%     legend(strcat('$\theta_{',int2str(joint_number),'r}$'), strcat( ...
%          '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
%     set(gca,'FontSize',8)
end