%% Exercício 5

%% Description 
% Simulação da integração da malha de controle PD independente por junta
% com a malha de controle de velocidade (Resolved Rate-Control)

%% Version Control
%
% 1.0; Karoline C. Burger; 2019/10/23 ; First issue.
%  
%% Script 

% Parâmetros de entrada 
L = [0.5;0.5;0.5];

% Especificação de comando - parâmetros iniciais
ThetaA0 = [10;20;30];
XdotC0 = [.2 -.3 -.2]'; 

W_0 = [1 2 3]';

% Parâmetros de simulação 
tsim = 30;
tstep = 0.1;

% Parâmetros do sistema
K = 17.7;
Jeff = 2.2;
Beff = 50;
T = Jeff/Beff;
r = 1;

% Calculo parâmetros de controle
qsi = 1;
wn =10; % chute
Kd = (2*qsi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 10;

% N = 15; % chute
% Kd = Kp*Td;
Td = Kd/Kp;
Ts = 1/100;

% Especificações de set-point
SP_theta = ThetaA0;

% Simulação
sim('rate_control_integrado_controlePD_r2018b')

%% Figuras

close all

% Item a
figure; subplot(2,1,1)
plot(tout,ThetadotA(:,1),tout,ThetadotA(:,2),'g',tout,ThetadotA(:,3),'r')
xlabel('tempo (s)'); ylabel('velocidade angular(º/s)')
title('Item a - Velocidade angular das juntas')
legend('$\dot{\theta}_1$','$\dot{\theta}_2$','$\dot{\theta}_3$', 'Interpreter','latex')

% Item b
subplot(2,1,2)
plot(tout,ThetaA(:,1),tout,ThetaA(:,2),'g',tout,ThetaA(:,3),'r')
xlabel('tempo (s)'); ylabel('ângulo(º)')
title('Item b - Posição das juntas')
legend('\theta_1','\theta_2','\theta_3')

% Item c
figure;
subplot(2,1,1); plot(tout,XA(:,1),tout,XA(:,2),'r')
xlabel('tempo (s)'); ylabel('distância(m)')
title('Posição da ferramenta em relação ao sistema de referência da base')
legend('x','y')

subplot(2,1,2); plot(tout,XA(:,3))
xlabel('tempo (s)'); ylabel('\phi(º)')
title('Orientação da ferramenta em relação ao sistema de referência da base')

% Item d
figure; 
subplot(2,1,1), plot(tout,Det)
xlabel('tempo (s)'); ylabel('determinante')
title('Item d - Determinante da matriz jacobiana')

% Item e
subplot(2,1,2), plot(tout,Tau(:,1),tout,Tau(:,2),'g',tout,Tau(:,3),'r')
xlabel('tempo (s)'); ylabel('torque (kgº/s²)')
title('Torque nas juntas')
legend('\tau_1','\tau_2','\tau_3')

% Adicional
figure; 
subplot(3,1,1); plot(tout,ThetaC(:,1),'--k',tout,ThetaA(:,1),'b')
xlabel('tempo (s)'); ylabel('\theta (°)'), legend('Desejado','Real')
title('Angulo da junta 1')

subplot(3,1,2); plot(tout,ThetaC(:,2),'--k',tout,ThetaA(:,2),'r')
xlabel('tempo (s)'); ylabel('\theta (°)'), legend('Desejado','Real')
title('Angulo da junta 2')

subplot(3,1,3); plot(tout,ThetaC(:,3),'--k',tout,ThetaA(:,3),'g')
xlabel('tempo (s)'); ylabel('\theta (°)'), legend('Desejado','Real')
title('Angulo da junta 3')

figure; 
subplot(3,1,1); plot(tout,ThetadotC(:,1),'--k',tout,ThetadotA(:,1),'b')
xlabel('tempo (s)'); ylabel('$\dot{\theta}(^{\circ}/s)$','Interpreter','latex'), 
legend('Desejado','Real')
title('Velocidade da junta 1')

subplot(3,1,2); plot(tout,ThetadotC(:,2),'--k',tout,ThetadotA(:,2),'r')
xlabel('tempo (s)'); ylabel('$\dot{\theta}(^{\circ}/s)$','Interpreter','latex'), 
legend('Desejado','Real')
title('Velocidade da junta 2')

subplot(3,1,3); plot(tout,ThetadotC(:,3),'--k',tout,ThetadotA(:,3),'g')
xlabel('tempo (s)'); ylabel('$\dot{\theta}(^{\circ}/s)$','Interpreter','latex'), 
legend('Desejado','Real')
title('Velocidade da junta 3')

% tTw=[0.1 0.2 30];
% figure; title('Plot Manipulator - Simulador sem dinâmica')
% for i=1:length(tout)
%      plot_manipulator(ThetaA(i,:),L,tTw)
% end

