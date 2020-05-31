%% Exercício 4 - Lista 3

%% Description 
% Simulação de um controlador PD independente por junta para acompanhamento
% do braço planar de três juntas.

%% Version Control
%
% 1.0; Karoline C. Burger; 2017/08/25 ; First issue.
%  
% 1.1; Karoline C. Burger; 2019/10/14; Modifications.
%
%% Script 

% Parâmetros do sistema
K = 17.7;
Jeff = 2.2;
Beff = 50;
T = Jeff/Beff;
r = 1;

%% Item a

% Calculo parâmetros de controle
qsi = 1;
wn = 10; % chute
Kd = (2*qsi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 10;

% N = 15; % chute
% Kd = Kp*Td;
Td = Kd/Kp;
Ts = 1/100;

% Especificações de set-point
SP_theta = [60;-110;20;20;20];

% sim('ControlePD_ind')
sim('ControlePD_ind')

% Plots
close all

figure;
subplot(5,1,1)
plot(tout,th1,'b',tout,thd1,'--b');
title('Posição angular da junta 1');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_1 (º)')
legend('$\theta_1$', '$\theta^d_1$','Interpreter','latex');

subplot(5,1,2)
plot(tout,th2,'r',tout,thd2,'--r');
title('Posição angular da junta 2');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_2 (º)')
legend('$\theta_2$', '$\theta^d_2$','Interpreter','latex');

subplot(5,1,3)
plot(tout,th3,'m',tout,thd3,'--m');
title('Posição angular da junta 3');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_3 (º)')
legend('$\theta_3$', '$\theta^d_3$','Interpreter','latex');

subplot(5,1,4)
plot(tout,th4,'g',tout,thd4,'--g');
title('Posição angular da junta 4');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_4 (º)')
legend('$\theta_4$', '$\theta^d_4$','Interpreter','latex');

subplot(5,1,5)
plot(tout,th5,'k',tout,thd5,'--k');
title('Posição angular da junta 5');
grid('on')
xlabel('Tempo (s)'); ylabel('\theta_5 (º)')
legend('$\theta_5$', '$\theta^d_5$','Interpreter','latex');

figure;
plot(tout,th1,'b',tout,thd1,'--b',tout,th2,'r',tout,thd2,'--r',tout,th3,'m',tout,thd3,'--m',tout,th4,'g',tout,thd4,'--g',tout,th5,'k',tout,thd5,'--k');
title('Posição angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Posição angular (º)')
legend('$\theta_1$','$\theta^d_1$','$\theta_2$','$\theta^d_2$',...
    '$\theta_3$','$\theta^d_3$','$\theta_4$','$\theta^d_4$',...
    '$\theta_5$','$\theta^d_5$','Interpreter','latex');

figure;
plot(tout,dth1,'b',tout,dth2,'r',tout,dth3,'m',tout,dth4,'g',tout,dth5,'k');
title('Velocidade angular das juntas');
grid('on')
xlabel('Tempo (s)'); ylabel('Velocidade angular (º/s)')
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$', '$\dot{\theta}_4$', '$\dot{\theta}_5$', 'Interpreter','latex');

figure;
subplot(2,1,1)
plot(tout,erro1,'b',tout,erro2,'r',tout,erro3,'m',tout,erro4,'g',tout,erro5,'k');
title('Erro')
grid('on')
xlabel('Tempo (s)'); ylabel('Ângulo (º)')
legend('$e_1$', '$e_2$', '$e_3$', '$e_4$', '$e_5$','Interpreter','latex');

subplot(2,1,2)
plot(tout,Vcontrole1,'b',tout,Vcontrole2,'r',tout,Vcontrole3,'m',tout,Vcontrole4,'g',tout,Vcontrole5,'k');
title('Tensão de controle (V)')
grid('on')
xlabel('Tempo (s)');
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


