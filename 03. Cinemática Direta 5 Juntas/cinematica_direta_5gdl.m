clear
clc

% i  alpha(i-1)    a(i-1)     d(i)     theta(i)
% 1    0            0           0       theta1
% 2   90�           0           0       theta2
% 3    0           L2           0       theta3
% 4   270�          0       L3+L4       theta4
% 5   90�           0           0       theta5

% t1 = theta1; t1p = theta1 ponto;
syms t1 t2 t3 t4 t5 L1 L2 L3 L4 T(alpha, a, d, theta) t1p t2p t3p t4p t5p

%% Funcao simbolica para gerar matriz T dados (alpha, a, d, theta)
T(alpha, a, d, theta) = [cos(theta),            -sin(theta),           0,           a;
                         sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
                         sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha), cos(alpha)*d
                         0,                     0,                      0,          1];

%%
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
d4 = L3 + L4;

d5 = 0;

%% Matrizes T e R                     
T01 = T(0, 0, d1, t1);
T12 = T(alpha1, a1, d2, t2);
T23 = T(alpha2, a2, d3, t3);
T34 = T(alpha3, a3, d4, t4);
T45 = T(alpha4, a4, d5, t5);

T02 = simplify(T01*T12);             % Transforma de {2} para {0}
T03 = simplify(T01*T12*T23);         % Transforma de {3} para {0}
T04 = simplify(T01*T12*T23*T34);     % Transforma de {4} para {0}
T05 = simplify(T01*T12*T23*T34*T45); % Transforma de {5} para {0}

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

R02 = simplify(R01*R12);             % Rotaciona de {2} para {0}
R03 = simplify(R01*R12*R23);         % Rotaciona de {3} para {0}
R04 = simplify(R01*R12*R23*R34);     % Rotaciona de {4} para {0}
R05 = simplify(R01*R12*R23*R34*R45); % Rotaciona de {5} para {0}

% Origens dos sistemas de coordenadas
O01 = T01(1:3,4);
O12 = T12(1:3,4);
O23 = T23(1:3,4);
O34 = T34(1:3,4);
O45 = T45(1:3,4);

%% Calcula vetores velocidade (i+1)w(i+1) notado por w_(i+1)_(i+1) e (i+1)v(i+1) notado por v_(i+1)_(i+1)
v_0_0 = [0; 0; 0];
w_0_0 = [0; 0; 0];

w_1_1 = R10*w_0_0 + [0; 0; t1p];
v_1_1 = R10*(v_0_0 + cross(w_0_0, O01));

w_2_2 = R21*w_1_1 + [0; 0; t2p];
v_2_2 = R21*(v_1_1 + cross(w_1_1, O12));

w_3_3 = R32*w_2_2 + [0; 0; t3p];
v_3_3 = R32*(v_2_2 + cross(w_2_2, O23));

w_4_4 = R43*w_3_3 + [0; 0; t4p];
v_4_4 = R43*(v_3_3 + cross(w_3_3, O34));

w_5_5 = R54*w_4_4 + [0; 0; t5p];
v_5_5 = R54*(v_4_4 + cross(w_4_4, O45));

%% Calcula vetores velocidade (0)w(n) notado por w_0_n e (0)v(n) notado por v_0_n
w_0_5 = R05*w_5_5; % w de {5} expressa em {0} = rotacao de {5} pra {0} * w de {5} expressa em {5}
v_0_5 = R05*v_5_5; % v de {5} expressa em {0} = rotacao de {5} pra {0} * v de {5} expressa em {5}

%% Calcula jacobiano J_0 -> [v_5_0; w_5_0] = J * [t1p; t2p; t3p; t4p; t5p]
J = [diff(v_0_5, t1p), diff(v_0_5, t2p), diff(v_0_5, t3p), diff(v_0_5, t4p), diff(v_0_5, t5p);
     diff(w_0_5, t1p), diff(w_0_5, t2p), diff(w_0_5, t3p), diff(w_0_5, t4p), diff(w_0_5, t5p)];

%% Visualiza��o do robo
% A visualiza��o � feita a partir da constru��o de ligamentos sucessivos
% que s�o determinados a partir de tr�s elementos:
% - Matriz de rota��o R(0,i)
% - Dire��o desejada para o ligamento expressa na base {i}: versor do ligamento(olhar a geometria do rob�)
% - Comprimento do ligamento L
% Para construir um ligamento, precisamos de dois pontos: o primeiro �
% determinado a partir da posi��o do fim do �ltimo ligamento, e o segundo �
% determinado pelo versor do ligamento na base {0} (= R(0,i)*[versor na
% base {i}]) multiplicado pelo seu comprimento.

close all

t1_val = 0;
t2_val = 0;
t3_val = -pi/2;
t4_val = 0;
t5_val = pi/2;
L0_val = 0.050; % [m]
L1_val = 0.226; % [m]
L2_val = 0.250; % [m]
L3_val = 0.160; % [m]
L4_val = 0.072; % [m]
L5_val = 0.075; % [m]

T01_val = subs(T01, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T02_val = subs(T02, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T03_val = subs(T03, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T04_val = subs(T04, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
T05_val = subs(T05, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});

R01_val = subs(R01, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R02_val = subs(R02, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R03_val = subs(R03, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R04_val = subs(R04, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});
R05_val = subs(R05, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val, t4_val, t5_val});

figure
hold on
view([45 25])
grid
xlim([-0.6 0.6])
ylim([-0.6 0.6])
zlim([-0.2 0.6])

p0 = [0; 0; 0]; % Coordenadas da origem 

% Ligamento 0 - base inferior do rob�
r0 = -L0_val * [0; 0; 1];   % Versor do ligamento 0 na base {0}
L0_1 = p0 + r0;             % Primeiro ponto do ligamento 0
L0_2 = p0;                  % Segundo ponto do ligamento 0
arm0_x = [L0_1(1) L0_2(1)];
arm0_y = [L0_1(2) L0_2(2)];
arm0_z = [L0_1(3) L0_2(3)];
plot3(arm0_x, arm0_y, arm0_z, 'LineWidth',3)

% Ligamento 1
r1 = R01_val * [0; 0; 1];     
L1_1 = L0_2; 
L1_2 = L0_2 + L1_val*r1; 
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
r4 = R04_val * [0; 0; 1]; 
L4_1 = L3_2;
L4_2 = L4_1 + L4_val*r4;
arm4_x = [L4_1(1) L4_2(1)];
arm4_y = [L4_1(2) L4_2(2)];
arm4_z = [L4_1(3) L4_2(3)];
plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',3)
 
% Ligamento 5
r5 = R05_val * [1; 0; 0]; 
L5_1 = L4_2;
L5_2 = L5_1 + L5_val*r5;
arm5_x = [L5_1(1) L5_2(1)];
arm5_y = [L5_1(2) L5_2(2)];
arm5_z = [L5_1(3) L5_2(3)];
plot3(arm5_x, arm5_y, arm5_z, 'LineWidth',3)

xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
zlabel('z','FontSize',16)