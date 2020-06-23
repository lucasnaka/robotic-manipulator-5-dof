close all
clear
clc

% i  alpha(i-1)    a(i-1)     d(i)     theta(i)
% 1    0            0           0       theta1
% 2   90°           0           0       theta2
% 3    0           L2           0       theta3
% 4   270°          0       L3+L4       theta4
% 5   90°           0           0       theta5

% t1 = theta1;
syms t1 t2 t3 t4 t5 L1 L2 L3 L4 T(alpha, a, d, theta)

%% Funcao simbolica para gerar matriz T dados (alpha, a, d, theta)
T(alpha, a, d, theta) = [cos(theta),            -sin(theta),           0,           a;
                         sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
                         sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha), cos(alpha)*d
                         0,                     0,                      0,          1];

%% CINEMATICA DIRETA   
alpha1 = pi/2;
a1 = 0;
d1 = 0;

alpha2 = 0;
a2 = L2;
d2 = 0;

alpha3 = 3*pi/2;
a3 = 0;
d3 = 0;

alpha4 = pi/2;
a4 = 0;
d4 = L3;

d5 = 0;

T01 = T(0, 0, d1, t1);
T12 = T(alpha1, a1, d2, t2);
T23 = T(alpha2, a2, d3, t3);
T34 = T(alpha3, a3, d4, t4);
T45 = T(alpha4, a4, d5, t5);

T02 = simplify(combine(T01*T12));             % Transforma de {2} para {0}
T03 = simplify(combine(T01*T12*T23));         % Transforma de {3} para {0}
T04 = simplify(combine(T01*T12*T23*T34));     % Transforma de {4} para {0}
T05 = simplify(combine(T01*T12*T23*T34*T45)); % Transforma de {5} para {0}

R01 = T01(1:3,1:3);
R12 = T12(1:3,1:3);
R23 = T23(1:3,1:3);
R34 = T34(1:3,1:3);
R45 = T45(1:3,1:3);

R10 = R01.';
R21 = R12.';
R32 = R23.';
R43 = R34.';
R54 = R45.';

R02 = simplify(combine(R01*R12));             % Rotaciona de {2} para {0}
R03 = simplify(combine(R01*R12*R23));         % Rotaciona de {3} para {0}
R04 = simplify(combine(R01*R12*R23*R34));     % Rotaciona de {4} para {0}
R05 = simplify(combine(R01*R12*R23*R34*R45)); % Rotaciona de {5} para {0}

offset3 = -pi/2;

t1_val = pi/4;
t2_val = pi/4; 
t3_val = pi/4 + offset3;
t4_val = pi/4;
t5_val = pi/4;

L0_val = 0.050; % [m]
L1_val = 0.226; % [m]
L2_val = 0.250; % [m]
L3_val = 0.160 + 0.072; % [m]
% L3_val = 0.160; % [m] = 0.160 + 0.072 
L4_val = 0.075; % [m]

T01_val = subs(T01, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T02_val = subs(T02, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T03_val = subs(T03, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T04_val = subs(T04, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T05_val = subs(T05, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});

R01_val = subs(R01, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R02_val = subs(R02, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R03_val = subs(R03, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R04_val = subs(R04, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R05_val = subs(R05, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, t1_val, t2_val, t3_val, t4_val, t5_val});

figure(1)
hold on
view([45 25])
grid
xlim([-0.7 0.7])
ylim([-0.7 0.7])
zlim([-0.7 0.7])

p0 = [0; 0; 0]; % Coordenadas da origem 

% Ligamento 1
r1 = R01_val * [0; 0; -1];     
L1_1 = p0 + L1_val*r1; 
L1_2 = p0; 
arm1_x = [L1_1(1) L1_2(1)];
arm1_y = [L1_1(2) L1_2(2)];
arm1_z = [L1_1(3) L1_2(3)];
plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',3)

% Ligamento 2
r2 = R02_val * [1; 0; 0];       
L2_1 = L1_2;
L2_2 = L2_1 + L2_val*r2;
arm2_x = [L2_1(1) L2_2(1)];
arm2_y = [L2_1(2) L2_2(2)];
arm2_z = [L2_1(3) L2_2(3)];
plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',3)

% Ligamento 3
r3 = R03_val * [0; 1; 0];       
L3_1 = L2_2;
L3_2 = L3_1 + L3_val*r3;
arm3_x = [L3_1(1) L3_2(1)];
arm3_y = [L3_1(2) L3_2(2)];
arm3_z = [L3_1(3) L3_2(3)];
plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',3)

% Ligamento 4
r4 = R05_val * [0; 1; 0]; 
L4_1 = L3_2;
L4_2 = L4_1 + L4_val*r4;
arm4_x = [L4_1(1) L4_2(1)];
arm4_y = [L4_1(2) L4_2(2)];
arm4_z = [L4_1(3) L4_2(3)];
plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',3)

xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
zlabel('z','FontSize',16)

disp('Matriz T05')
disp(T05_val)

q = [t1_val, t2_val, t3_val, t4_val, t5_val];
disp('CINEMATICA DIRETA')
disp('q = ')
disp(q)

%% PIEPER

% Matriz definida pelo operador. Nos definimos a seguinte matriz:

gamma = pi/4;
beta = 0;

Rgamma = [sin(gamma)  cos(gamma) 0;
          0           0          -1;
          -cos(gamma) sin(gamma) 0];

Rbeta = [0           1            0;
         sin(beta)   0   -cos(beta);
         -cos(beta)  0  -sin(beta)];
     
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

% px = L2_val + L3_val - 1E-15;
% py = 0;
% pz = 0;
px = T05_val(1,4);
py = T05_val(2,4);
pz = T05_val(3,4);

L2 = L2_val;
L3 = L3_val;

% Calculo de theta3
r = px^2 + py^2 + pz^2;
S3 = (L2^2 + L3^2 - r) / (2*L2*L3);
if(abs(S3) > 1 )
    disp('Espaco nao alcancavel, erro no theta 3')
    return
else
    C3_1 = sqrt(1 - S3^2); 
    C3_2 = -C3_1;
    theta3 = [atan2(S3, C3_1), atan2(S3, C3_2)];
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temos ate o momento:
% theta3(1) e theta3(2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculo de theta2
a = L2 - L3*S3;
b_1 = L3*C3_1;
b_2 = L3*C3_2;

theta2 = [atan2(a,b_1) - acos(pz/(sqrt(a^2 + b_1^2))), ...
          atan2(a,b_2) - acos(pz/(sqrt(a^2 + b_2^2))), ...
          atan2(a,b_1) + acos(pz/(sqrt(a^2 + b_1^2))), ...
          atan2(a,b_2) + acos(pz/(sqrt(a^2 + b_2^2)))];
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temos ate o momento:
% [theta2(1), theta3(1)]
% [theta2(2), theta3(2)]
% [theta2(3), theta3(1)]
% [theta2(4), theta3(2)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g1 = L2*cos(theta2) - L3*sin(theta2 + repmat(theta3,1,2));

% Calculo de theta1
theta1 = atan2(py./g1, px./g1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temos ate o momento:
% [theta1(1), theta2(1), theta3(1)]
% [theta1(2), theta2(2), theta3(2)]
% [theta1(3), theta2(3), theta3(1)]
% [theta1(4), theta2(4), theta3(2)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculo de theta4
S4 = -cos(theta1) ./ cos(theta2 + repmat(theta3,1,2));
C4 = -sin(theta1);

theta4 = atan2(S4,C4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temos ate o momento:
% [theta1(1), theta2(1), theta3(1), theta4(1)]
% [theta1(2), theta2(2), theta3(2), theta4(2)]
% [theta1(3), theta2(3), theta3(1), theta4(3)]
% [theta1(4), theta2(4), theta3(2), theta4(4)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculo de theta5
S5 = oy*cos(theta1)./-sin(theta4);
C5 = ny*cos(theta1)./sin(theta4);
theta5 = atan2(S5,C5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temos ate o momento:
% [theta1(1), theta2(1), theta3(1), theta4(1), theta5(1)]
% [theta1(2), theta2(2), theta3(2), theta4(2), theta5(2)]
% [theta1(3), theta2(3), theta3(1), theta4(3), theta5(3)]
% [theta1(4), theta2(4), theta3(2), theta4(4), theta5(4)]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Todas as solucoes ate o momento
all_q = [theta1; theta2; repmat(theta3,1,2); theta4; theta5].';
%% PLOT SOLUCOES
disp('CINEMATICA INVERSA')

figure(2)
for i=1:size(all_q,1)
    disp(strcat('q',int2str(i),' = '))
    disp(all_q(i,:))
    
    R01_val = subs(R01, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R02_val = subs(R02, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R03_val = subs(R03, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R04_val = subs(R04, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R05_val = subs(R05, {L2, L3, t1, t2, t3, t4, t5}, {L2_val, L3_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});

    subplot(2,2,i)
    hold on
    view([45 25])
    grid
    xlim([-0.7 0.7])
    ylim([-0.7 0.7])
    zlim([-0.7 0.7])

    p0 = [0; 0; 0]; % Coordenadas da origem 

    % Ligamento 1
    r1 = R01_val * [0; 0; -1];     
    L1_1 = p0 + L1_val*r1; 
    L1_2 = p0; 
    arm1_x = [L1_1(1) L1_2(1)];
    arm1_y = [L1_1(2) L1_2(2)];
    arm1_z = [L1_1(3) L1_2(3)];
    plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',3)

    % Ligamento 2
    r2 = R02_val * [1; 0; 0];       
    L2_1 = L1_2;
    L2_2 = L2_1 + L2_val*r2;
    arm2_x = [L2_1(1) L2_2(1)];
    arm2_y = [L2_1(2) L2_2(2)];
    arm2_z = [L2_1(3) L2_2(3)];
    plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',3)

    % Ligamento 3
    r3 = R03_val * [0; 1; 0];       
    L3_1 = L2_2;
    L3_2 = L3_1 + L3_val*r3;
    arm3_x = [L3_1(1) L3_2(1)];
    arm3_y = [L3_1(2) L3_2(2)];
    arm3_z = [L3_1(3) L3_2(3)];
    plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',3)

    % Ligamento 4
    r4 = R05_val * [0; 1; 0]; 
    L4_1 = L3_2;
    L4_2 = L4_1 + L4_val*r4;
    arm4_x = [L4_1(1) L4_2(1)];
    arm4_y = [L4_1(2) L4_2(2)];
    arm4_z = [L4_1(3) L4_2(3)];
    plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',3)

    xlabel('x','FontSize',16)
    ylabel('y','FontSize',16)
    zlabel('z','FontSize',16)
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
X5 = R05_val' * 1.4*X;
Y5 = R05_val' * 1.4*Y;
Z5 = R05_val' * 1.4*Z;

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