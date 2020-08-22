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
traj_th1 = [0, 10  0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th2 = [0,  0, 0, 0, 10, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th3 = [0,  0, 0, 0,  0, 0, 0, 10, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th4 = [0,  0, 0, 0,  0, 0, 0,  0, 0, 0, 10, 0, 0,  0, 0, 0];
traj_th5 = [0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0, 10, 0, 0];
% traj_th1 = [0, 5, 10];
% traj_th2 = [0, 0, 0];
% traj_th3 = [0, 0, 0];
% traj_th4 = [0, 0, 0];
% traj_th5 = [0, 0, 0];

T = 5;

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

% sim('ControleFF_trajetoria_D', simulation_time)
sim('ControlePD_trajetoria', simulation_time)

%%
% Plots
close all

figure;
% subplot(5,1,1)
plot_angular_position_ff(Thr.signals.values(:,1), Thd_path.signals.values(:,1), Thr.time, 1, 'b')
hold on
% subplot(5,1,2)
plot_angular_position_ff(Thr.signals.values(:,2), Thd_path.signals.values(:,2), Thr.time, 2, 'r')
hold on
% subplot(5,1,3)
plot_angular_position_ff(Thr.signals.values(:,3), Thd_path.signals.values(:,3), Thr.time, 3, 'm')
hold on
% subplot(5,1,4)
plot_angular_position_ff(Thr.signals.values(:,4), Thd_path.signals.values(:,4), Thr.time, 4, 'g')
hold on
% subplot(5,1,5)
plot_angular_position_ff(Thr.signals.values(:,5), Thd_path.signals.values(:,5), Thr.time, 5, 'c')
grid('on')
xlabel('Tempo (s)')
ylabel('Posição(º)')
legend('$\theta_{1r}$', '$\theta^d_1$','$\theta_{2r}$', '$\theta^d_2$', ...
    '$\theta_{3r}$', '$\theta^d_3$', '$\theta_{4r}$', '$\theta^d_4$', ...
    '$\theta_{5r}$', '$\theta^d_5$', 'Interpreter', 'latex', 'FontSize', 12);

% figure;
% % subplot(5,1,1)
% plot_angular_velocity_ff(dThr.signals.values(:,1), dThd_path.signals.values(:,1), dThr.time, 1, 'b')
% hold on
% % subplot(5,1,2)
% plot_angular_velocity_ff(dThr.signals.values(:,2), dThd_path.signals.values(:,2), dThr.time, 2, 'r')
% hold on
% % subplot(5,1,3)
% plot_angular_velocity_ff(dThr.signals.values(:,3), dThd_path.signals.values(:,3), dThr.time, 3, 'm')
% hold on
% % subplot(5,1,4)
% plot_angular_velocity_ff(dThr.signals.values(:,4), dThd_path.signals.values(:,4), dThr.time, 4, 'g')
% hold on
% % subplot(5,1,5)
% plot_angular_velocity_ff(dThr.signals.values(:,5), dThd_path.signals.values(:,5), dThr.time, 5, 'c')
% grid('on')
% xlabel('Tempo (s)')
% ylabel('Velocidade (º/s)')
% legend('$\dot{\theta}_{1r}$', '$\dot{\theta}^d_1$','$\dot{\theta}_{2r}$', '$\dot{\theta}^d_2$', ...
%     '$\dot{\theta}_{3r}$', '$\dot{\theta}^d_3$', '$\dot{\theta}_{4r}$', '$\dot{\theta}^d_4$', ...
%     '$\dot{\theta}_{5r}$', '$\dot{\theta}^d_5$', 'Interpreter', 'latex', 'FontSize', 12);

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

%%
% Plots
% close all
% 
% figure;
% subplot(5,1,1)
% plot_angular_position_ff(Thr.signals.values(:,1), Thd_path.signals.values(:,1), Thr.time, 1, 'b')
% % figure;
% subplot(5,1,2)
% % hold on
% plot_angular_position_ff(Thr.signals.values(:,2), Thd_path.signals.values(:,2), Thr.time, 2, 'r')
% % figure;
% subplot(5,1,3)
% % hold on
% plot_angular_position_ff(Thr.signals.values(:,3), Thd_path.signals.values(:,3), Thr.time, 3, 'm')
% % figure;
% subplot(5,1,4)
% % hold on
% plot_angular_position_ff(Thr.signals.values(:,4), Thd_path.signals.values(:,4), Thr.time, 4, 'g')
% % figure;
% subplot(5,1,5)
% % hold on
% plot_angular_position_ff(Thr.signals.values(:,5), Thd_path.signals.values(:,5), Thr.time, 5, 'k')
% % grid('on')
% % xlabel('Tempo (s)')
% % ylabel('Posição(º)')
% % legend('$\theta_{1r}$', '$\theta^d_1$','$\theta_{2r}$', '$\theta^d_2$', ...
% %     '$\theta_{3r}$', '$\theta^d_3$', '$\theta_{4r}$', '$\theta^d_4$', ...
% %     '$\theta_{5r}$', '$\theta^d_5$', 'Interpreter', 'latex');
% 
% figure;
% subplot(5,1,1)
% % hold on
% plot_angular_velocity_ff(dThr.signals.values(:,1), dThd_path.signals.values(:,1), dThr.time, 1, 'b')
% % figure;
% subplot(5,1,2)
% % hold on
% plot_angular_velocity_ff(dThr.signals.values(:,2), dThd_path.signals.values(:,2), dThr.time, 2, 'r')
% % figure;
% subplot(5,1,3)
% % hold on
% plot_angular_velocity_ff(dThr.signals.values(:,3), dThd_path.signals.values(:,3), dThr.time, 3, 'm')
% % figure;
% subplot(5,1,4)
% % hold on
% plot_angular_velocity_ff(dThr.signals.values(:,4), dThd_path.signals.values(:,4), dThr.time, 4, 'g')
% % figure;
% subplot(5,1,5)
% % hold on
% plot_angular_velocity_ff(dThr.signals.values(:,5), dThd_path.signals.values(:,5), dThr.time, 5, 'k')
% % grid('on')
% % xlabel('Tempo (s)')
% % ylabel('Velocidade (º/s)')
% % legend('$\dot{\theta}_{1r}$', '$\dot{\theta}^d_1$','$\dot{\theta}_{2r}$', '$\dot{\theta}^d_2$', ...
% %     '$\dot{\theta}_{3r}$', '$\dot{\theta}^d_3$', '$\dot{\theta}_{4r}$', '$\dot{\theta}^d_4$', ...
% %     '$\dot{\theta}_{5r}$', '$\dot{\theta}^d_5$', 'Interpreter', 'latex');

% figure;
% subplot(5,1,1)
% plot_error_ff(erro.signals.values(:,1),tout,1,'b')
% % figure;
% subplot(5,1,2)
% plot_error_ff(erro.signals.values(:,2),tout,2,'r')
% % figure;
% subplot(5,1,3)
% plot_error_ff(erro.signals.values(:,3),tout,3,'m')
% % figure;
% subplot(5,1,4)
% plot_error_ff(erro.signals.values(:,4),tout,4,'g')
% % figure;
% subplot(5,1,5)
% plot_error_ff(erro.signals.values(:,5),tout,5,'k')
% 
% figure;
% subplot(5,1,1)
% plot_esforco_ff(Vcontrole.signals.values(:,1),tout,1,'b')
% % figure;
% subplot(5,1,2)
% plot_esforco_ff(Vcontrole.signals.values(:,2),tout,2,'r')
% % figure;
% subplot(5,1,3)
% plot_esforco_ff(Vcontrole.signals.values(:,3),tout,3,'m')
% % figure;
% subplot(5,1,4)
% plot_esforco_ff(Vcontrole.signals.values(:,4),tout,4,'g')
% % figure;
% subplot(5,1,5)
% plot_esforco_ff(Vcontrole.signals.values(:,5),tout,5,'k')

% % figure;
% % plot(tout,erro.signals.values(:,1),'b',tout,erro.signals.values(:,2),'r', ...
% %      tout,erro.signals.values(:,3),'m',tout,erro.signals.values(:,4),'g', ...
% %      tout,erro.signals.values(:,5),'c');
% % grid('on')
% % xlabel('Tempo (s)'); ylabel('Ângulo (º)')
% % legend('$e_1$', '$e_2$', '$e_3$', '$e_4$', '$e_5$','Interpreter','latex');
% % 
% % figure;
% % plot(tout,Vcontrole.signals.values(:,1),'b',tout,Vcontrole.signals.values(:,2),'r', ...
% %      tout,Vcontrole.signals.values(:,3),'m',tout,Vcontrole.signals.values(:,4),'g', ...
% %      tout,Vcontrole.signals.values(:,5),'c');
% % grid('on')
% % xlabel('Tempo (s)');  ylabel('Tensão (V)')
% % legend('V_1', 'V_2', 'V_3', 'V_4', 'V_5');

%% Funcoes

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

function plot_angular_velocity_ff(thr, thd, tout, joint_number, color)
    plot(tout,thr,color,tout,thd,strcat('--',color));
%     title(strcat('Velocidade angular da junta',{' '},int2str(joint_number)))
%     grid('on')
%     xlabel('Tempo (s)')
%     ylabel('Velocidade (º/s)')
%     legend(strcat('$\dot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
%       '$\dot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
%   set(gca,'FontSize',8)
end

function plot_error_ff(erro, tout, joint_number, color)
    plot(tout,erro,color)
    grid('on')
    xlabel('Tempo (s)'); ylabel('Ângulo (º)');
    legend(strcat('$e_',int2str(joint_number),'$'),'Interpreter','latex','FontSize',12);
%     set(gca,'FontSize',8)
end

function plot_esforco_ff(esforco, tout, joint_number, color)
    plot(tout,esforco,color)
    grid('on')
    xlabel('Tempo (s)'); ylabel('Tensão (V)');
    legend(strcat('$V_',int2str(joint_number),'$'),'Interpreter','latex','FontSize',12);
%     set(gca,'FontSize',8)
end
