close all
clear all

Jeff = 0.5;
Beff = 50;
% K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
% K = 40; % ganho do sistema linear
Km = 4000;
Km_NL = 4.8694e+03;
R = 2; % resistencia da armadura do motor [Ohm]
K = Km/(R*Beff); % ganho do sistema linear
K_NL = Km_NL/(R*Beff); % ganho do sistema linear
%T = Jeff/Beff;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem
h = 0.0175; % Backlash width
phi = 43.47;

amp = 5;

SP_theta = [0,0,0,0,0];

freq = 0.1;
Fs = (phi+10)*Beff;
Fc = phi*Beff;
alpha = 1.25;
sigma0 = 200*Beff;
sigma1 = 20*Beff;
sigma2 = 0.2*Beff;

sim('ControleNL_Degrau')
tal_F = tal_F.signals.values;
dThr = dThr.signals.values;
figure;
subplot(2,1,1)
plot(dThr(:,1), tal_F(:,1))
xlabel('Velocidade [rad/s]')
ylabel('Torque de atrito [N.m]')
set(gca,'FontSize',10)
subplot(2,1,2)
esforco_controle = esforco_controle.signals.values;
plot(esforco_controle(:,1), dThr(:,1))
xlabel('Esforço de controle [V]')
ylabel('Velocidade [rad/s]')
set(gca,'FontSize',10)

% 
% figure;
% subplot(5,1,1)
% plot_friction_force(tal_F(:,1), tout, 1, 'b')
% subplot(5,1,2)
% plot_friction_force(tal_F(:,2), tout, 2, 'r')
% subplot(5,1,3)
% plot_friction_force(tal_F(:,3), tout, 3, 'm')
% subplot(5,1,4)
% plot_friction_force(tal_F(:,4), tout, 4, 'g')
% subplot(5,1,5)
% plot_friction_force(tal_F(:,5), tout, 5, 'c')
% 
% 
% figure;
% subplot(5,1,1)
% plot_velocity(dThr(:,1), tout, 1, 'b')
% subplot(5,1,2)
% plot_velocity(dThr(:,2), tout, 2, 'r')
% subplot(5,1,3)
% plot_velocity(dThr(:,3), tout, 3, 'm')
% subplot(5,1,4)
% plot_velocity(dThr(:,4), tout, 4, 'g')
% subplot(5,1,5)
% plot_velocity(dThr(:,5), tout, 5, 'c')
% 
% Thr = Thr.signals.values;
% 
% figure;
% subplot(5,1,1)
% plot_position(Thr(:,1), tout, 1, 'b')
% subplot(5,1,2)
% plot_position(Thr(:,2), tout, 2, 'r')
% subplot(5,1,3)
% plot_position(Thr(:,3), tout, 3, 'm')
% subplot(5,1,4)
% plot_position(Thr(:,4), tout, 4, 'g')
% subplot(5,1,5)
% plot_position(Thr(:,5), tout, 5, 'c')
% 
% V = V.signals.values;
% 
% figure;
% subplot(5,1,1)
% plot_coriolis_centrifugal_forces(V(:,1), tout, 1, 'b')
% subplot(5,1,2)
% plot_coriolis_centrifugal_forces(V(:,2), tout, 2, 'r')
% subplot(5,1,3)
% plot_coriolis_centrifugal_forces(V(:,3), tout, 3, 'm')
% subplot(5,1,4)
% plot_coriolis_centrifugal_forces(V(:,4), tout, 4, 'g')
% subplot(5,1,5)
% plot_coriolis_centrifugal_forces(V(:,5), tout, 5, 'c')
% 
% tal_motor = tal_motor.signals.values;
% 
% figure;
% subplot(4,1,1)
% plot_friction_force(tal_F(1:size(tal_F,1)/6,1), tout(1:size(tal_F,1)/6), 1, 'b')
% subplot(4,1,2)
% plot_velocity(dThr(1:size(tal_F,1)/6,1), tout(1:size(tal_F,1)/6), 1, 'b')
% subplot(4,1,3)
% plot_control_effort(esforco_controle(1:size(tal_F,1)/6,1), tout(1:size(tal_F,1)/6), 1, 'b')
% subplot(4,1,4)
% plot_motor_force(tal_motor(1:size(tal_F,1)/6,1), tout(1:size(tal_F,1)/6), 1, 'b')
% 
% figure;
% subplot(4,1,1)
% plot_friction_force(tal_F(:,1), tout, 1, 'b')
% subplot(4,1,2)
% plot_velocity(dThr(:,1), tout, 1, 'b')
% subplot(4,1,3)
% plot_control_effort(esforco_controle(:,1), tout, 1, 'b')
% subplot(4,1,4)
% plot_motor_force(tal_motor(:,1), tout, 1, 'b')
% 


function plot_friction_force(tal_F, tout, joint_number, color)
    plot(tout,tal_F,color);
    title(strcat('Torque de atrito da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo [s]')
    ylabel('[N.m]')
    set(gca,'FontSize',8)
end

function plot_coriolis_centrifugal_forces(V, tout, joint_number, color)
    plot(tout,V,color);
    title(strcat('Forças centrífugas e de Coriolis da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo [s]')
    ylabel('[N.m]')
    set(gca,'FontSize',8)
end

function plot_position(Thr, tout, joint_number, color)
    plot(tout,Thr,color);
    title(strcat('Posição da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo [s]')
    ylabel('[rad]')
    set(gca,'FontSize',8)
end

function plot_velocity(dThr, tout, joint_number, color)
    plot(tout,dThr,color);
    title(strcat('Velocidade da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo [s]')
    ylabel('[rad/s]')
    set(gca,'FontSize',8)
end

function plot_control_effort(V_controle, tout, joint_number, color)
    plot(tout,V_controle,color);
    title(strcat('Esforço de controle da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo [s]')
    ylabel('[V]')
    set(gca,'FontSize',8)
end

function plot_motor_force(tal_motor, tout, joint_number, color)
    plot(tout,tal_motor,color);
    title(strcat('Torque motor da junta',{' '},int2str(joint_number)))
    grid('on')
    xlabel('Tempo [s]')
    ylabel('[N.m]')
    set(gca,'FontSize',8)
end