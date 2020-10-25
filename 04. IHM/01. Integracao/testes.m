close all

amp = 20;
freq = 2*pi*0.5;
Fc = 2.4;
Fs = 4.9;
sigma0 = 1e4;
sigma1 = 500;
sigma2 = 11.1;
alpha = 6.7;

tal_F_array = [];
dThr_array = [];

% for i=-50:50
%     amp = i;
%     sim('ControleFF_nao_linearidade')
%     tal_F_array = [tal_F_array tal_F.signals.values(end,1)];
%     dThr_array = [dThr_array dThr.signals.values(end,1)];
% end
% 
% figure;
% plot(dThr_array, tal_F_array)

sim('ControleFF_nao_linearidade')

tal_F = tal_F.signals.values;

figure;
subplot(5,1,1)
plot_friction_force(tal_F(:,1), tout, 1, 'b')
subplot(5,1,2)
plot_friction_force(tal_F(:,2), tout, 2, 'r')
subplot(5,1,3)
plot_friction_force(tal_F(:,3), tout, 3, 'm')
subplot(5,1,4)
plot_friction_force(tal_F(:,4), tout, 4, 'g')
subplot(5,1,5)
plot_friction_force(tal_F(:,5), tout, 5, 'c')

dThr = dThr.signals.values;

figure;
subplot(5,1,1)
plot_velocity(dThr(:,1), tout, 1, 'b')
subplot(5,1,2)
plot_velocity(dThr(:,2), tout, 2, 'r')
subplot(5,1,3)
plot_velocity(dThr(:,3), tout, 3, 'm')
subplot(5,1,4)
plot_velocity(dThr(:,4), tout, 4, 'g')
subplot(5,1,5)
plot_velocity(dThr(:,5), tout, 5, 'c')

Thr = Thr.signals.values;

figure;
subplot(5,1,1)
plot_position(Thr(:,1), tout, 1, 'b')
subplot(5,1,2)
plot_position(Thr(:,2), tout, 2, 'r')
subplot(5,1,3)
plot_position(Thr(:,3), tout, 3, 'm')
subplot(5,1,4)
plot_position(Thr(:,4), tout, 4, 'g')
subplot(5,1,5)
plot_position(Thr(:,5), tout, 5, 'c')

V = V.signals.values;

figure;
subplot(5,1,1)
plot_coriolis_centrifugal_forces(V(:,1), tout, 1, 'b')
subplot(5,1,2)
plot_coriolis_centrifugal_forces(V(:,2), tout, 2, 'r')
subplot(5,1,3)
plot_coriolis_centrifugal_forces(V(:,3), tout, 3, 'm')
subplot(5,1,4)
plot_coriolis_centrifugal_forces(V(:,4), tout, 4, 'g')
subplot(5,1,5)
plot_coriolis_centrifugal_forces(V(:,5), tout, 5, 'c')

figure;
plot(dThr(:,1), tal_F(:,1))
xlabel('Velocidade [rad/s]')
ylabel('Torque de atrito [N.m]')
set(gca,'FontSize',10)

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