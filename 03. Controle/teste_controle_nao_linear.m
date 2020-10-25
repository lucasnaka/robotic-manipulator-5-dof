clear all
close all
clc

% K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
K = 48.69;
Jeff = 0.5;
Beff = 50;
%T = Jeff/Beff;
r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem
%r = 1./[231.22*4 139.138 139.138]; % Relacoes de engrenagem

xi = 1;
wn = 15; % chute // fazer o bode para tirar o wn
Kd = (2*xi*wn*Jeff - Beff)/K;
Kp = (wn^2*Jeff)/K;
N = 3;

Td = Kd/Kp;
Ts = 1/100;

% Non linearity parameters
phi = 43.47;

set_param('ControleFF_D_NL','StartTime','0','StopTime',num2str(20))
sim('ControleFF_D_NL')