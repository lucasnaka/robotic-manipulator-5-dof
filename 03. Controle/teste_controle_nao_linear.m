clear all
close all
clc

Jeff = 0.5;
Beff = 50;
K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
% K = 40; % ganho do sistema linear
Km = 4000;
Km_NL = 4.8694e+03;
R = 2; % resistencia da armadura do motor [Ohm]
% K = Km/(R*Beff); % ganho do sistema linear
K_NL = Km_NL/(R*Beff); % ganho do sistema linear
%T = Jeff/Beff;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem
h = 0.0175; % Backlash width
phi = 43.47;

xi = 1;
wn = 15; % chute // fazer o bode para tirar o wn
Kd = (2*xi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
Kd_NL = (2*xi*wn*Jeff - Beff)/K_NL;
Kp_NL = (wn^2*Jeff)/K_NL;
N = 3;

Td = Kd/Kp;
Td_NL = Kd_NL/Kp_NL;
Ts = 1/100;

% Non lineartiry parameters
amp = 5;
freq = 0.1;
Fs = (phi+10)*Beff;
Fc = phi*Beff;
alpha = 1.25;
sigma0 = 200*Beff;
sigma1 = 20*Beff;
sigma2 = 0.2*Beff;

traj_th1 = [0, 5, 10];
traj_th2 = [0, 0, 0];
traj_th3 = [0, 0, 0];
traj_th4 = [0, 0, 0];
traj_th5 = [0, 0, 0];

T = 5;

% Update rate and evaluation time vector
simulation_time = ((length(traj_th1)-1)*T);
rate = 1/simulation_time;

% Call high level function
addpath(strcat(fileparts(pwd),'\02. Trajetórias'))
[t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
[t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
[t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);
[t4, th4_path, dth4_path, ddth4_path] = geraTrajetoria(traj_th4, T, rate);
[t5, th5_path, dth5_path, ddth5_path] = geraTrajetoria(traj_th5, T, rate);

th_path = [t1' th1_path' th2_path' th3_path' th4_path' th5_path'];
dth_path = [t1' dth1_path' dth2_path' dth3_path' dth4_path' dth5_path'];
ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path' ddth4_path' ddth5_path'];

set_param('ControleFF_D_NL/Dinâmica do robô/Int_Thr', 'InitialCondition', mat2str([0 0 0 0 0]));
set_param('ControleFF_D_NL/Dinâmica do robô1/Int_Thr', 'InitialCondition', mat2str([0 0 0 0 0]));
set_param('ControleFF_D_NL/Dinâmica do robô2/Int_Thr', 'InitialCondition', mat2str([0 0 0 0 0]));
set_param('ControleFF_D_NL','StartTime','0','StopTime',num2str(simulation_time))
sim('ControleFF_D_NL')
%%
% Plots
close all

figure;
% subplot(5,1,1)
plot_angular_position_ff(Thr_lin.signals.values(:,1), Thr_nonlin.signals.values(:,1), Thr_nonlin_pre_comp.signals.values(:,1), Thd_path.signals.values(:,1), Thr_lin.time, 1)
hold on
% subplot(5,1,2)
plot_angular_position_ff(Thr_lin.signals.values(:,2), Thr_nonlin.signals.values(:,2), Thr_nonlin_pre_comp.signals.values(:,2), Thd_path.signals.values(:,2), Thr_lin.time, 2)
hold on
% subplot(5,1,3)
plot_angular_position_ff(Thr_lin.signals.values(:,3), Thr_nonlin.signals.values(:,3), Thr_nonlin_pre_comp.signals.values(:,3), Thd_path.signals.values(:,3), Thr_lin.time, 3)
hold on
% subplot(5,1,4)
plot_angular_position_ff(Thr_lin.signals.values(:,4), Thr_nonlin.signals.values(:,4), Thr_nonlin_pre_comp.signals.values(:,4), Thd_path.signals.values(:,4), Thr_lin.time, 4)
hold on
% subplot(5,1,5)
plot_angular_position_ff(Thr_lin.signals.values(:,5), Thr_nonlin.signals.values(:,5), Thr_nonlin_pre_comp.signals.values(:,5), Thd_path.signals.values(:,5), Thr_lin.time, 1)
% grid('on')
% xlabel('Tempo (s)')
% ylabel('Posição(º)')
% legend('$\theta_{1r}$', '$\theta^d_1$','$\theta_{2r}$', '$\theta^d_2$', ...
%     '$\theta_{3r}$', '$\theta^d_3$', '$\theta_{4r}$', '$\theta^d_4$', ...
%     '$\theta_{5r}$', '$\theta^d_5$', 'Interpreter', 'latex', 'FontSize', 12);

function plot_angular_position_ff(thr_lin, thr_nonlin, thr_nonlin_prec, thd, tout, joint_number)
    plot(tout,thr_lin,'b',tout,thr_nonlin,'r', tout, thr_nonlin_prec, 'g', tout,thd,strcat('--','k'));
    title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo (s)')
    ylabel('Posição (º)')
    legend(strcat('Lin $\theta_{',int2str(joint_number),'r}$'), strcat( ...
         'NL $\theta_{', int2str(joint_number),'r}$'), strcat( ...
         'NLP $\theta_{', int2str(joint_number),'r}$'), strcat( ...
         '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
    set(gca,'FontSize',12)
end