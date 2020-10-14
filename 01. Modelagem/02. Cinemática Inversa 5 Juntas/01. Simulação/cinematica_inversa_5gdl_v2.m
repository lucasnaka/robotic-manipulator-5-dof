close all
clear
clc
%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%

addpath(strcat(fileparts(fileparts(pwd)),'\01. Cinemática Direta 5 Juntas\01. Simulação'))

offset3 = -pi/2;

% Ex1 relatorio
% Th = [0; 0; 0+offset3; 0; 0];

% Ex2 relatorio
% Th = [pi/6; 0; pi/4+offset3; 0; -pi/4];

% Ex3 relatorio
Th = [pi/6; 0; pi/4+offset3; pi/4; pi/4]; 

% Ex4 relatorio
% Th = [pi/4; 0; pi/2+offset3; pi/4; 0];

% Th = [0; 0; 0+offset3; 0; 0];

cinematica_direta;
T05_direta = T05;

figure(1)
plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)

%%
%=========================================================================%
%                                Pieper                                   %
%=========================================================================%

% Inputs da cinemática inversa:
%   - (px, py, pz) = posição da origem dos sistemas 4 e 5
%   -     alpha    = rotação da garra em relação ao eixo Z5
%   -     beta     = rotação da garra em relação ao eixo Z4

px = T05(1,4)-eps;
py = T05(2,4)-eps;
pz = T05(3,4)-eps;

alpha = pi/2; 
beta = 0; 

Theta_new = cinematica_inversa(px, py, pz, alpha, beta, [0,0,0+offset3,0,0], L);

Th = Theta_new;
cinematica_direta;
T05_direta = T05;

figure(2)
plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)



%%
% %=========================================================================%
% %                          Calculo dos thetas                             %
% %=========================================================================%
% 
% % Calculo de theta3
% r = px^2 + py^2 + pz^2;
% S3 = (L(2)^2 + L(3)^2 - r) / (2*L(2)*L(3));
% if(abs(S3) > 1 + eps)
%     disp('Espaco nao alcancavel, erro no theta 3')
%     return
% else
%     C3_1 = sqrt(1 - S3^2); 
%     C3_2 = -C3_1;
%     theta3 = [atan2(S3, C3_1), atan2(S3, C3_2)];
% end
% theta3 = repmat(theta3,1,2);
% 
% 
% % Calculo de theta2
% a = L(2) - L(3)*S3;
% b_1 = L(3)*C3_1;
% b_2 = L(3)*C3_2;
% 
% theta2 = [atan2(a,b_1) - acos(pz/(sqrt(a^2 + b_1^2))), ...
%           atan2(a,b_2) - acos(pz/(sqrt(a^2 + b_2^2))), ...
%           atan2(a,b_1) + acos(pz/(sqrt(a^2 + b_1^2))), ...
%           atan2(a,b_2) + acos(pz/(sqrt(a^2 + b_2^2)))];
% 
%       
% % Calculo de theta1
% g1 = L(2)*cos(theta2) - L(3)*sin(theta2 + theta3);
% 
% theta1 = atan2(py./g1, px./g1);
% 
% % theta4
% theta4 = repmat(beta,1,4);
% 
% % theta5
% theta5 = [];
% for i = 1:4
%     if theta1(i) < pi/2 && theta1(i) > -pi/2
%         theta5 = [theta5, alpha];
%     else
%         theta5 = [theta5, -alpha];
%     end
% end
% 
% %=========================================================================%
% %                          Plot dos resultados                            %
% %=========================================================================%
% for i = 1:size(theta5,2)
%     Th = [theta1(i), theta2(i), theta3(i), theta4(i), theta5(i)];
%     cinematica_direta;
%     figure
%     plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)
% end