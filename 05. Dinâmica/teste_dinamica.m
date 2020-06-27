clear all
close all

% Especificacoes para simulacao
theta_initial = [0 0 0 0 0];
torque_step_time = [0 0 0 0 0];
torque_initial = [0 0 0 0 0];
torque_final = [0 0 0 0 0];

sim('sim_dinamica')

% Plots
close all

figure(1)
plot(tout,ddth(:,1),'b',tout,ddth(:,2),'r',tout,ddth(:,3),'m',tout,ddth(:,4),'g',tout,ddth(:,5),'c');
% title('Joint Angular Acceleration');
grid('on')
xlabel('Time (s)'); ylabel('dd\Theta (º/sec^2)')
legend('$dd\theta_1$', '$dd\theta_2$', '$dd\theta_3$', '$dd\theta_4$', '$dd\theta_5$','Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)

figure(2)
plot(tout,dth(:,1),'b',tout,dth(:,2),'r',tout,dth(:,3),'m',tout,dth(:,4),'g',tout,dth(:,5),'c');
% title('Joint Angular Velocity');
grid('on')
xlabel('Time (s)'); ylabel('d\Theta (º/sec)')
legend('$d\theta_1$', '$d\theta_2$', '$d\theta_3$', '$d\theta_4$', '$d\theta_5$','Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)

figure(3)
plot(tout,th(:,1),'b',tout,th(:,2),'r',tout,th(:,3),'m',tout,th(:,4),'g',tout,th(:,5),'c');
% title('Joint Angular Position');
grid('on')
xlabel('Time (s)'); ylabel('\Theta (º)')
legend('$\theta_1$', '$\theta_2$', '$\theta_3$', '$\theta_4$', '$\theta_5$','Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)

figure(4)
plot(tout,result_torque(:,1),'b',tout,result_torque(:,2),'r',tout,result_torque(:,3),'m',tout,result_torque(:,4),'g',tout,result_torque(:,5),'c');
% title('Resultant Torque');
grid('on')
xlabel('Time (s)'); ylabel('Torque (Nm)')
legend('1', '2', '3', '4', '5','Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)

figure(5)
plot(tout,V(:,1),'b',tout,V(:,2),'r',tout,V(:,3),'m',tout,V(:,4),'g',tout,V(:,5),'c');
% title('Coriolis and Centrifugal Torques');
grid('on')
xlabel('Time (s)'); ylabel('Torque (Nm)')
legend('1', '2', '3', '4', '5','Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)

figure(6)
plot(tout,G(:,1),'b',tout,G(:,2),'r',tout,G(:,3),'m',tout,G(:,4),'g',tout,G(:,5),'c');
% title('Gravitational Torque');
grid('on')
xlabel('Time (s)'); ylabel('Torque (Nm)')
legend('1', '2', '3', '4', '5','Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)

figure(7)
plot(tout,F(:,1),'b',tout,F(:,2),'r',tout,F(:,3),'m',tout,F(:,4),'g',tout,F(:,5),'c');
% title('Friction Torques');
grid('on')
xlabel('Time (s)'); ylabel('Torque (Nm)')
legend({'1', '2', '3', '4', '5'},'Interpreter','latex', 'FontSize', 12);
set(gca,'FontSize',12)