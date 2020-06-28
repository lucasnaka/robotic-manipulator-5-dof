close all
clear
clc

%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%

offset3 = -pi/2;
Th = [0; 0; 0 + offset3; 0; 0];

cinematica_direta;

figure(1)
plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)

%%
%=========================================================================%
%                                Pieper                                   %
%=========================================================================%
% Matriz definida pelo operador. Nos definimos a seguinte matriz:

syms gamma beta

% gamma = pi/4;
% beta = 0;

Rbeta = [0           1            0;
         sin(beta)   0   -cos(beta);
         -cos(beta)  0   -sin(beta)];

Rgamma = [sin(gamma)  cos(gamma) 0;
          0           0          -1;
          -cos(gamma) sin(gamma) 0];
     
Robjetivo = Rbeta * Rgamma;

ax = Robjetivo(1,3);
ay = Robjetivo(2,3);
az = Robjetivo(3,3);

ox = Robjetivo(1,2);
oy = Robjetivo(2,2);
oz = Robjetivo(3,2);

nx = Robjetivo(1,1);
ny = Robjetivo(2,1);
nz = Robjetivo(3,1);

px = T05(1,4);
py = T05(2,4);
pz = T05(3,4);

%=========================================================================%
%                          Calculo dos thetas                             %
%=========================================================================%

% Calculo de theta3
r = px^2 + py^2 + pz^2;
S3 = (L(2)^2 + L(3)^2 - r) / (2*L(2)*L(3));
if(abs(S3) > 1 + eps)
    disp('Espaco nao alcancavel, erro no theta 3')
    return
else
    C3_1 = sqrt(1 - S3^2); 
    C3_2 = -C3_1;
    theta3 = [atan2(S3, C3_1), atan2(S3, C3_2)];
end

% Calculo de theta2
a = L(2) - L(3)*S3;
b_1 = L(3)*C3_1;
b_2 = L(3)*C3_2;

theta2 = [atan2(a,b_1) - acos(pz/(sqrt(a^2 + b_1^2))), ...
          atan2(a,b_2) - acos(pz/(sqrt(a^2 + b_2^2))), ...
          atan2(a,b_1) + acos(pz/(sqrt(a^2 + b_1^2))), ...
          atan2(a,b_2) + acos(pz/(sqrt(a^2 + b_2^2)))];

% Calculo de theta1
g1 = L(2)*cos(theta2) - L(3)*sin(theta2 + repmat(theta3,1,2));

theta1 = atan2(py./g1, px./g1);

% Calculo de theta4
% S4 = -cos(theta1) ./ cos(theta2 + repmat(theta3,1,2));
% C4 = -sin(theta1);
% theta4 = atan2(S4,C4);
theta4 = [atan2(cos(theta1)*sqrt(ny^2 + oy^2), sin(theta1)), ...
         -atan2(cos(theta1)*sqrt(ny^2 + oy^2), sin(theta1))]

% % Calculo de theta5
% S5 = oy*cos(theta1)./-sin(theta4);
% C5 = ny*cos(theta1)./sin(theta4);
% theta5 = atan2(S5,C5);
% 
% % Todas as solucoes ate o momento
% all_q = [theta1; theta2; repmat(theta3,1,2); theta4; theta5].';
%% PLOT SOLUCOES
disp('CINEMATICA INVERSA')

figure(2)
for i=1:size(all_q,1)
    disp(strcat('q',int2str(i),' = '))
    disp(all_q(i,:))
    
    Th = all_q(i,:);
    cinematica_direta;
    
    subplot(2,2,i)
    plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)
end


%% Verificacao da orientacao

R05_obj = [nx, ox, ax;
           ny, oy  ay;
           nz, oz, az];  

% {0}
X = [1; 0; 0];
Y = [0; 1; 0];
Z = [0; 0; 1];

% {5} objetivo
X5obj = R05_obj' * 1.2*X;
Y5obj = R05_obj' * 1.2*Y;
Z5obj = R05_obj' * 1.2*Z;

% {5} obtido
X5 = R05' * 1.4*X;
Y5 = R05' * 1.4*Y;
Z5 = R05' * 1.4*Z;

figure(3)
view([45 25])
grid
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
hold on

quiver3(0,0,0,X(1),X(2),X(3), 'Color', 'b', 'linewidth', 1.2);
quiver3(0,0,0,Y(1),Y(2),Y(3), 'Color', 'b', 'linewidth', 1.2);
h1 = quiver3(0,0,0,Z(1),Z(2),Z(3), 'Color', 'b', 'linewidth', 1.2);

quiver3(0,0,0,X5obj(1),X5obj(2),X5obj(3), 'Color', 'r', 'linewidth', 1.2);
quiver3(0,0,0,Y5obj(1),Y5obj(2),Y5obj(3), 'Color', 'r', 'linewidth', 1.2);
h2 = quiver3(0,0,0,Z5obj(1),Z5obj(2),Z5obj(3), 'Color', 'r', 'linewidth', 1.2);

quiver3(0,0,0,X5(1),X5(2),X5(3), 'Color', 'g', 'linewidth', 1.2);
quiver3(0,0,0,Y5(1),Y5(2),Y5(3), 'Color', 'g', 'linewidth', 1.2);
h3 = quiver3(0,0,0,Z5(1),Z5(2),Z5(3), 'Color', 'g', 'linewidth', 1.2);

hold off

legend([h1, h2, h3], '\{0\}', '\{5\} desejado', '\{5\} obtido')

xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
zlabel('z','FontSize',16)