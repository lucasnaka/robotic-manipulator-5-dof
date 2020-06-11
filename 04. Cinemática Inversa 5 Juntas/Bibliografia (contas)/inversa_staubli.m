clear
clc

% i  alpha(i-1)    a(i-1)     d(i)     theta(i)
% 1    0            0           0       theta1
% 2   90°           0           0       theta2
% 3    0           D3           0       theta3
% 4   270°          0         RL4       theta4
% 5   90°           0           0       theta5
% 6  -90º           0           0       theta6

syms t1 t2 t3 t4 t5 t6 D3 RL4 T(alpha, a, d, theta)

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
a2 = D3;
d2 = 0;

alpha3 = 3*pi/2;
a3 = 0;
d3 = 0;

alpha4 = pi/2;
a4 = 0;
d4 = RL4;

alpha5 = -pi/2;
a5 = 0;
d5 = 0;

d6 = 0;

%% Matrizes T e R                     
T01 = T(0, 0, d1, t1);
T12 = T(alpha1, a1, d2, t2);
T23 = T(alpha2, a2, d3, t3);
T34 = T(alpha3, a3, d4, t4);
T45 = T(alpha4, a4, d5, t5);
T56 = T(alpha5, a5, d6, t6);

T02 = simplify(T01*T12);                 % Transforma de {2} para {0}
T03 = simplify(T01*T12*T23);             % Transforma de {3} para {0}
T04 = simplify(T01*T12*T23*T34);         % Transforma de {4} para {0}
T05 = simplify(T01*T12*T23*T34*T45);     % Transforma de {5} para {0}
T06 = simplify(T01*T12*T23*T34*T45*T56); % Transforma de {5} para {0}

R01 = T01(1:3,1:3);
R12 = T12(1:3,1:3);
R23 = T23(1:3,1:3);
R34 = T34(1:3,1:3);
R45 = T45(1:3,1:3);
R56 = T56(1:3,1:3);

R10 = R01.';
R21 = R12.';
R32 = R23.';
R43 = R34.';
R54 = R45.';
R65 = R56.';

R02 = simplify(R01*R12);                 % Rotaciona de {2} para {0}
R03 = simplify(R01*R12*R23);             % Rotaciona de {3} para {0}
R04 = simplify(R01*R12*R23*R34);         % Rotaciona de {4} para {0}
R05 = simplify(R01*R12*R23*R34*R45);     % Rotaciona de {5} para {0}
R06 = simplify(R01*R12*R23*R34*R45*R56); % Rotaciona de {5} para {0}

% Origens dos sistemas de coordenadas
O01 = T01(1:3,4);
O12 = T12(1:3,4);
O23 = T23(1:3,4);
O34 = T34(1:3,4);
O45 = T45(1:3,4);
O56 = T56(1:3,4);

%% Visualização do robo
% A visualização é feita a partir da construção de ligamentos sucessivos
% que são determinados a partir de três elementos:
% - Matriz de rotação R(0,i)
% - Direção desejada para o ligamento expressa na base {i}: versor do ligamento(olhar a geometria do robô)
% - Comprimento do ligamento L
% Para construir um ligamento, precisamos de dois pontos: o primeiro é
% determinado a partir da posição do fim do último ligamento, e o segundo é
% determinado pelo versor do ligamento na base {0} (= R(0,i)*[versor na
% base {i}]) multiplicado pelo seu comprimento.

t1_val = pi/4;
t2_val = pi/4;
t3_val = pi/3;
t4_val = pi/3;
t5_val = pi/3;
t6_val = 0;

D3_val = 20;
RL4_val = 10;

T01_val = subs(T01, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
T02_val = subs(T02, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
T03_val = subs(T03, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
T04_val = subs(T04, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
T05_val = subs(T05, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
T06_val = subs(T06, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});

R01_val = subs(R01, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
R02_val = subs(R02, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
R03_val = subs(R03, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
R04_val = subs(R04, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
R05_val = subs(R05, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});
R06_val = subs(R06, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val});

figure
hold on
view([45 25])
grid
xlim([-0.6 0.6])
ylim([-0.6 0.6])
zlim([-0.2 0.6])

p0 = [0; 0; 0]; % Coordenadas da origem 

% Ligamento 0 - base inferior do robô
r0 = -5 * [0; 0; 1];        % Versor do ligamento 0 na base {0}
L0_1 = p0 + r0;             % Primeiro ponto do ligamento 0
L0_2 = p0;                  % Segundo ponto do ligamento 0
arm0_x = [L0_1(1) L0_2(1)];
arm0_y = [L0_1(2) L0_2(2)];
arm0_z = [L0_1(3) L0_2(3)];
plot3(arm0_x, arm0_y, arm0_z, 'LineWidth',3)

% Ligamento 1
r1 = R01_val * [0; 0; 1];     
L1_1 = L0_2; 
L1_2 = L1_1 + 10*r1; 
arm1_x = [L1_1(1) L1_2(1)];
arm1_y = [L1_1(2) L1_2(2)];
arm1_z = [L1_1(3) L1_2(3)];
plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',3)

% Ligamento 2
r2 = R02_val * [1; 0; 0];       
L2_1 = L1_2;
L2_2 = L2_1 + D3_val*r2;
arm2_x = [L2_1(1) L2_2(1)];
arm2_y = [L2_1(2) L2_2(2)];
arm2_z = [L2_1(3) L2_2(3)];
plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',3)

% Ligamento 3
r3 = R03_val * [0; 1; 0];       
L3_1 = L2_2;
L3_2 = L3_1 + RL4_val/2*r3;
arm3_x = [L3_1(1) L3_2(1)];
arm3_y = [L3_1(2) L3_2(2)];
arm3_z = [L3_1(3) L3_2(3)];
plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',3)

% Ligamento 4
r4 = R04_val * [0; 0; 1]; 
L4_1 = L3_2;
L4_2 = L4_1 + RL4_val/2*r4;
arm4_x = [L4_1(1) L4_2(1)];
arm4_y = [L4_1(2) L4_2(2)];
arm4_z = [L4_1(3) L4_2(3)];
plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',3)
 
% Ligamento 5
r5 = R05_val * [1; 0; 0]; 
L5_1 = L4_2;
L5_2 = L5_1 + 5*r5;
arm5_x = [L5_1(1) L5_2(1)];
arm5_y = [L5_1(2) L5_2(2)];
arm5_z = [L5_1(3) L5_2(3)];
plot3(arm5_x, arm5_y, arm5_z, 'LineWidth',3)

xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
zlabel('z','FontSize',16)

%% INVERSA

px = T05_val(1,4);
py = T05_val(2,4);
pz = T05_val(3,4);

ax = T05_val(1,3);
ay = T05_val(2,3);
az = T05_val(3,3);

nx = T05_val(1,2);
ny = T05_val(2,2);
nz = T05_val(3,2);

sx = T05_val(1,1);
sy = T05_val(2,1);
sz = T05_val(3,1);

% t1
theta1_1 = atan2(py,px);
theta1_2 = theta1_1 + pi;

% --

% t2
B1_1 = px*cos(theta1_1) + py*sin(theta1_1);
B1_2 = px*cos(theta1_2) + py*sin(theta1_2);
X = -2*pz*D3_val;
Y_1 = -2*B1_1*D3_val;
Y_2 = -2*B1_2*D3_val;
Z = RL4_val^2 - D3_val^2 - pz^2 - B1_1^2;

S2_1_1 = (X*Z + Y_1*sqrt(X^2+Y_1^2-Z^2))/(X^2 + Y_1^2);
C2_1_1 = (Y_1*Z - X*sqrt(X^2+Y_1^2-Z^2))/(X^2 + Y_1^2);
theta2_1_1 = atan2(S2_1_1, C2_1_1); % carrego theta1_1

S2_2_1 = (X*Z - Y_1*sqrt(X^2+Y_1^2-Z^2))/(X^2 + Y_1^2);
C2_2_1 = (Y_1*Z + X*sqrt(X^2+Y_1^2-Z^2))/(X^2 + Y_1^2);
theta2_2_1 = atan2(S2_2_1, C2_2_1); % carrego theta1_1

S2_1_2 = (X*Z + Y_2*sqrt(X^2+Y_2^2-Z^2))/(X^2 + Y_2^2);
C2_1_2 = (Y_2*Z - X*sqrt(X^2+Y_2^2-Z^2))/(X^2 + Y_2^2);
theta2_1_2 = atan2(S2_1_2, C2_1_2); % carrego theta1_2

S2_2_2 = (X*Z - Y_2*sqrt(X^2+Y_2^2-Z^2))/(X^2 + Y_2^2);
C2_2_2 = (Y_2*Z + X*sqrt(X^2+Y_2^2-Z^2))/(X^2 + Y_2^2);
theta2_2_2 = atan2(S2_2_2, C2_2_2); % carrego theta1_2

% ---

% t3
S3_11 = (-pz*S2_1_1 - B1_1*C2_1_1 + D3_val) / (RL4_val);
C3_11 = (-B1_1*S2_1_1 + pz*C2_1_1) / (RL4_val);
theta3_11 = atan2(S3_11,C3_11); % carrego theta1_1 e theta2_1_1

S3_12 = (-pz*S2_2_1 - B1_1*C2_2_1 + D3_val) / (RL4_val);
C3_12 = (-B1_1*S2_2_1 + pz*C2_2_1) / (RL4_val);
theta3_12 = atan2(S3_12,C3_12); % carrego theta1_1 e theta2_2_1

S3_21 = (-pz*S2_1_2 - B1_2*C2_1_2 + D3_val) / (RL4_val);
C3_21 = (-B1_2*S2_1_2 + pz*C2_1_2) / (RL4_val);
theta3_21 = atan2(S3_21,C3_21); % carrego theta1_2 e theta2_1_2

S3_22 = (-pz*S2_2_2 - B1_2*C2_2_2 + D3_val) / (RL4_val);
C3_22 = (-B1_2*S2_2_2 + pz*C2_2_2) / (RL4_val);
theta3_22 = atan2(S3_22,C3_22); % carrego theta1_2 e theta2_2_2

% ---
% Os termos Hx, Hy e Hz vêm da terceira coluna da matriz de rotação R36 (que leva {6} em {3}) 

% t4 e t5
% primeira solucao carregando theta1_1 e theta2_1_1
Hz = ax*sin(theta1_1) - ay*cos(theta1_1);
Hx = az*sin(theta2_1_1 + theta3_11) + ax*cos(theta2_1_1 + theta3_11)*cos(theta1_1) + ay*cos(theta2_1_1 + theta3_11)*sin(theta1_1);
Hy = az*cos(theta2_1_1 + theta3_11) - ax*sin(theta2_1_1 + theta3_11)*cos(theta1_1) - ay*sin(theta2_1_1 + theta3_11)*sin(theta1_1);

theta4_1_11 = atan2(Hz, -Hx);
S5_1 = -cos(theta4_1_11)*Hx + sin(theta4_1_11)*Hz;
C5_1 = Hy;
theta5_1_11 = atan2(S5_1, C5_1);

% segunda solucao carregando theta1_1 e theta2_1_1
theta4_2_11 = theta4_1_11 + pi;
S5_2 = -cos(theta4_2_11)*Hx + sin(theta4_2_11)*Hz;
C5_2 = Hy;
theta5_2_11 = atan2(S5_2, C5_2);

% ---

% primeira solucao carregando theta1_1 e theta2_2_1
Hz = ax*sin(theta1_1) - ay*cos(theta1_1);
Hx = az*sin(theta2_2_1 + theta3_12) + ax*cos(theta2_2_1 + theta3_12)*cos(theta1_1) + ay*cos(theta2_2_1 + theta3_12)*sin(theta1_1);
Hy = az*cos(theta2_2_1 + theta3_12) - ax*sin(theta2_2_1 + theta3_12)*cos(theta1_1) - ay*sin(theta2_2_1 + theta3_12)*sin(theta1_1);

theta4_1_12 = atan2(Hz, -Hx); 
S5_2 = -cos(theta4_1_12)*Hx + sin(theta4_1_12)*Hz;
C5_2 = Hy;
theta5_1_12 = atan2(S5_2, C5_2);

% segunda solucao carregando theta1_1 e theta2_2_1
theta4_2_12 = theta4_1_12 + pi;
S5_2 = -cos(theta4_2_12)*Hx + sin(theta4_2_12)*Hz;
C5_2 = Hy;
theta5_2_12 = atan2(S5_2, C5_2);

% ---

% primeira solucao carregando theta1_2 e theta2_1_2
Hz = ax*sin(theta1_2) - ay*cos(theta1_2);
Hx = az*sin(theta2_1_2 + theta3_21) + ax*cos(theta2_1_2 + theta3_21)*cos(theta1_2) + ay*cos(theta2_1_2 + theta3_21)*sin(theta1_2);
Hy = az*cos(theta2_1_2 + theta3_21) - ax*sin(theta2_1_2 + theta3_21)*cos(theta1_2) - ay*sin(theta2_1_2 + theta3_21)*sin(theta1_2);

theta4_1_21 = atan2(Hz, -Hx); 
S5_2 = -cos(theta4_1_21)*Hx + sin(theta4_1_21)*Hz;
C5_2 = Hy;
theta5_1_21 = atan2(S5_2, C5_2);

% segunda solucao carregando theta1_2 e theta2_1_2
theta4_2_21 = theta4_1_21 + pi;
S5_2 = -cos(theta4_2_21)*Hx + sin(theta4_2_21)*Hz;
C5_2 = Hy;
theta5_2_21 = atan2(S5_2, C5_2);

% ---

% primeira solucao carregando theta1_2 e theta2_2_2
Hz = ax*sin(theta1_2) - ay*cos(theta1_2);
Hx = az*sin(theta2_2_2 + theta3_22) + ax*cos(theta2_2_2 + theta3_22)*cos(theta1_2) + ay*cos(theta2_2_2 + theta3_22)*sin(theta1_2);
Hy = az*cos(theta2_2_2 + theta3_22) - ax*sin(theta2_2_2 + theta3_22)*cos(theta1_2) - ay*sin(theta2_2_2 + theta3_22)*sin(theta1_2);

theta4_1_22 = atan2(Hz, -Hx); 
S5_2 = -cos(theta4_1_22)*Hx + sin(theta4_1_22)*Hz;
C5_2 = Hy;
theta5_1_22 = atan2(S5_2, C5_2);

% segunda solucao carregando theta1_2 e theta2_2_2
theta4_2_22 = theta4_1_22 + pi;
S5_2 = -cos(theta4_2_22)*Hx + sin(theta4_2_22)*Hz;
C5_2 = Hy;
theta5_2_22 = atan2(S5_2, C5_2);

% ---

% t5
theta5 = pi/4;

% t6
theta6 = 0;

% ---
% Todas as solucoes

q1 = [theta1_1, theta2_1_1, theta3_11, theta4_1_11, theta5_1_11, theta6]; 
q2 = [theta1_1, theta2_2_1, theta3_12, theta4_1_12, theta5_1_12, theta6]; 
q3 = [theta1_2, theta2_1_2, theta3_21, theta4_1_21, theta5_1_21, theta6]; 
q4 = [theta1_2, theta2_2_2, theta3_22, theta4_1_22, theta5_1_22, theta6]; 

q5 = [theta1_1, theta2_1_1, theta3_11, theta4_2_11, theta5_2_11, theta6];
q6 = [theta1_1, theta2_2_1, theta3_12, theta4_2_12, theta5_2_12, theta6]; 
q7 = [theta1_2, theta2_1_2, theta3_21, theta4_2_21, theta5_2_21, theta6]; 
q8 = [theta1_2, theta2_2_2, theta3_22, theta4_2_22, theta5_2_22, theta6]; 
 
% Aqui escolhemos a solução que vamos plotar
q = q3;

% T05_val_dir = double(subs(T05, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, t1_val, t2_val, t3_val, t4_val, t5_val, t6_val}))
% T05_val_inv = double(subs(T05, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)}))

R01_val = subs(R01, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)});
R02_val = subs(R02, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)});
R03_val = subs(R03, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)});
R04_val = subs(R04, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)});
R05_val = subs(R05, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)});
R06_val = subs(R06, {D3, RL4, t1, t2, t3, t4, t5, t6}, {D3_val, RL4_val, q(1), q(2), q(3), q(4), q(5), q(6)});

figure
hold on
view([45 25])
grid
xlim([-50 50])
ylim([-50 50])
zlim([-50 50])

p0 = [0; 0; 0]; % Coordenadas da origem 

% Ligamento 0 - base inferior do robô
r0 = -5 * [0; 0; 1];   % Versor do ligamento 0 na base {0}
L0_1 = p0 + r0;             % Primeiro ponto do ligamento 0
L0_2 = p0;                  % Segundo ponto do ligamento 0
arm0_x = [L0_1(1) L0_2(1)];
arm0_y = [L0_1(2) L0_2(2)];
arm0_z = [L0_1(3) L0_2(3)];
plot3(arm0_x, arm0_y, arm0_z, 'LineWidth',3)

% Ligamento 1
r1 = R01_val * [0; 0; 1];     
L1_1 = L0_2; 
L1_2 = L0_2 + 10*r1; 
arm1_x = [L1_1(1) L1_2(1)];
arm1_y = [L1_1(2) L1_2(2)];
arm1_z = [L1_1(3) L1_2(3)];
plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',3)

% Ligamento 2
r2 = R02_val * [1; 0; 0];       
L2_1 = L1_2;
L2_2 = L2_1 + D3_val*r2;
arm2_x = [L2_1(1) L2_2(1)];
arm2_y = [L2_1(2) L2_2(2)];
arm2_z = [L2_1(3) L2_2(3)];
plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',3)

% Ligamento 3
r3 = R03_val * [0; 1; 0];       
L3_1 = L2_2;
L3_2 = L3_1 + RL4_val/2*r3;
arm3_x = [L3_1(1) L3_2(1)];
arm3_y = [L3_1(2) L3_2(2)];
arm3_z = [L3_1(3) L3_2(3)];
plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',3)

% Ligamento 4
r4 = R04_val * [0; 0; 1]; 
L4_1 = L3_2;
L4_2 = L4_1 + RL4_val/2*r4;
arm4_x = [L4_1(1) L4_2(1)];
arm4_y = [L4_1(2) L4_2(2)];
arm4_z = [L4_1(3) L4_2(3)];
plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',3)
 
% Ligamento 5
r5 = R05_val * [1; 0; 0]; 
L5_1 = L4_2;
L5_2 = L5_1 + 5*r5;
arm5_x = [L5_1(1) L5_2(1)];
arm5_y = [L5_1(2) L5_2(2)];
arm5_z = [L5_1(3) L5_2(3)];
plot3(arm5_x, arm5_y, arm5_z, 'LineWidth',3)