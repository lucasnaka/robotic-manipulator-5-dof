close all
clear
clc

% Acerta tamanho de fontes para gráficos
set(0, 'defaultlinelinewidth', 1.2);
set(0, 'defaultaxesfontsize', 12);

%% Parâmetros

K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
Jeff = 0.5;
Beff = 50;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem

amp = 0.01;
omega = 2*pi*0.01;
h = 0.002; % Backlash width

SP_theta = [0,0,0,0,0];

%% Simulação em malha aberta

out = sim('ControleFF_D_NL_backlash_2020a');

%% Plots em malha aberta

close all

figure
plot_angular_position_openLoop(out.Thr_linear.signals.values(:,1), out.Thr_backlash.signals.values(:,1), out.Thr_linear.time, 1, 'b')

% figure;
% subplot(5,1,1)
% plot_angular_position_openLoop(out.Thr_linear.signals.values(:,1), out.Thr_backlash.signals.values(:,1), out.Thr_linear.time, 1, 'b')
% hold on
% subplot(5,1,2)
% plot_angular_position_openLoop(out.Thr_linear.signals.values(:,2), out.Thr_backlash.signals.values(:,2), out.Thr_linear.time, 2, 'r')
% hold on
% subplot(5,1,3)
% plot_angular_position_openLoop(out.Thr_linear.signals.values(:,3), out.Thr_backlash.signals.values(:,3), out.Thr_linear.time, 3, 'm')
% hold on
% subplot(5,1,4)
% plot_angular_position_openLoop(out.Thr_linear.signals.values(:,4), out.Thr_backlash.signals.values(:,4), out.Thr_linear.time, 4, 'g')
% hold on
% subplot(5,1,5)
% plot_angular_position_openLoop(out.Thr_linear.signals.values(:,5), out.Thr_backlash.signals.values(:,5), out.Thr_linear.time, 5, 'c')

%% Simulação em malha fechada

% Calculo parâmetros de controle
xi = 1;
wn = 15; % chute // fazer o bode para tirar o wn
Kd = (2*xi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 3;

Td = Kd/Kp;
Ts = 1/100;

% Usando a funcao de alto nivel "geraTrajetoria"

% Arrange trajectory points in a vector
traj_th1 = [0, 10  0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th2 = [0,  0, 0, 0, 10, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th3 = [0,  0, 0, 0,  0, 0, 0, 10, 0, 0,  0, 0, 0,  0, 0, 0];
traj_th4 = [0,  0, 0, 0,  0, 0, 0,  0, 0, 0, 10, 0, 0,  0, 0, 0];
traj_th5 = [0,  0, 0, 0,  0, 0, 0,  0, 0, 0,  0, 0, 0, 10, 0, 0];

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

% sim('ControleFF_D_NL_2020a');

%% Plots malha fechada

close all

figure;
subplot(5,1,1)
plot_angular_position_closedLoop(Thr_linear.signals.values(:,1), Thr_backlash.signals.values(:,1), Thr_linear.time, 1, 'b')
hold on
subplot(5,1,2)
plot_angular_position_closedLoop(Thr_linear.signals.values(:,2), Thr_backlash.signals.values(:,2), Thr_linear.time, 2, 'r')
hold on
subplot(5,1,3)
plot_angular_position_closedLoop(Thr_linear.signals.values(:,3), Thr_backlash.signals.values(:,3), Thr_linear.time, 3, 'm')
hold on
subplot(5,1,4)
plot_angular_position_closedLoop(Thr_linear.signals.values(:,4), Thr_backlash.signals.values(:,4), Thr_linear.time, 4, 'g')
hold on
subplot(5,1,5)
plot_angular_position_closedLoop(Thr_linear.signals.values(:,5), Thr_backlash.signals.values(:,5), Thr_linear.time, 5, 'c')


%% Funções
function plot_angular_position_openLoop(th_lin, th_backlash, tout, joint_number, color)
    plot(tout,th_lin,color,tout,th_backlash,strcat('--',color));
    title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo (s)')
    ylabel('Posição (º)')
    legend(strcat('$\theta_{',int2str(joint_number),',linear}$'), strcat( ...
         '$\theta_{',int2str(joint_number),',backlash}$'), 'Interpreter', 'latex','FontSize',12);
    set(gca,'FontSize',8)
end

function plot_angular_position_closedLoop(th_lin, th_backlash, tout, joint_number, color)
%     plot(tout,th_lin,color,tout,th_backlash,strcat('--',color));
    plot(tout,th_lin,color)
    plot(tout,th_backlash,color)
    title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo (s)')
    ylabel('Posição (º)')
    legend(strcat('$\theta_{',int2str(joint_number),',linear}$'), strcat( ...
         '$\theta_{',int2str(joint_number),',backlash}$'), 'Interpreter', 'latex','FontSize',12);
    set(gca,'FontSize',8)
end