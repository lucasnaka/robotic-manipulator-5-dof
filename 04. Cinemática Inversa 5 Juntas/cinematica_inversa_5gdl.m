clear
clc

% i  alpha(i-1)    a(i-1)     d(i)     theta(i)
% 1    0            0           0       theta1
% 2   90�           0           0       theta2
% 3    0           L2           0       theta3
% 4   270�          0       L3+L4       theta4
% 5   90�           0           0       theta5

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
d4 = L3 + L4;

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

t1_val = 0;
t2_val = 0; % pi/2;
t3_val = 0; % -pi/2;
t4_val = 0;
t5_val = 0;

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
xlim([-0.6 0.8])
ylim([-0.6 0.8])
zlim([-0.2 0.8])

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
L1_2 = L1_1 + L1_val*r1; 
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
r5 = R05_val * [0; 1; 0]; 
L5_1 = L4_2;
L5_2 = L5_1 + L5_val*r5;
arm5_x = [L5_1(1) L5_2(1)];
arm5_y = [L5_1(2) L5_2(2)];
arm5_z = [L5_1(3) L5_2(3)];
plot3(arm5_x, arm5_y, arm5_z, 'LineWidth',3)

xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
zlabel('z','FontSize',16)

disp('Matriz T05')
disp(T05_val)

q = [t1_val, t2_val, t3_val, t4_val, t5_val];
disp('CINEMATICA DIRETA')
disp('q = ')
disp(q)

px = T05_val(1,4);
py = T05_val(2,4);
pz = T05_val(3,4);

ax = T05_val(1,3);
ay = T05_val(2,3);
az = T05_val(3,3);

ox = T05_val(1,2);
oy = T05_val(2,2);
oz = T05_val(3,2);

nx = T05_val(1,1);
ny = T05_val(2,1);
nz = T05_val(3,1);


%% PIEPER

L2 = L2_val;
L3 = L3_val;
L4 = L4_val;

% Calculo de theta3
r = px^2 + py^2 + pz^2;
S3 = (L2^2 + (L3+L4)^2 - r) / (2*L2*(L3+L4));
C3_1 = sqrt(1 - S3^2); 
C3_2 = -C3_1;
theta3_1 = atan2(S3, C3_1);
theta3_2 = atan2(S3, C3_2);

% Calculo de theta2
a = L2 - (L3+L4)*S3;
b_1 = (L3+L4)*C3_1;
b_2 = (L3+L4)*C3_2;

% theta2_1 = atan2(a,b_1) - acos(pz/(sqrt(a^2 + b_1^2)));
% theta2_2 = atan2(a,b_2) - acos(pz/(sqrt(a^2 + b_2^2)));
% theta2_3 = atan2(a,b_1) + acos(pz/(sqrt(a^2 + b_1^2)));
% theta2_4 = atan2(a,b_2) + acos(pz/(sqrt(a^2 + b_2^2)));

theta2_1 = 2*atan2(a + sqrt(a^2 - pz^2 + b_1^2), pz + b_1);
theta2_2 = 2*atan2(a + sqrt(a^2 - pz^2 + b_2^2), pz + b_2);
theta2_3 = 2*atan2(a - sqrt(a^2 - pz^2 + b_1^2), pz + b_1);
theta2_4 = 2*atan2(a - sqrt(a^2 - pz^2 + b_2^2), pz + b_2);

% Calculo de theta1
theta1 = atan2(py, px);

% Calculo de theta4
% Selecionando ax,ay,az = [0,0,1] na seguinte matriz de rotacao R05:
% Re = [nx, ox, ax; = [nx, ox, 0;
%       ny, oy, ay;    ny, oy, 0;
%       nz, pz, az];   nz, pz, 1];

% theta4_1 = pi/2;
% theta4_2 = -pi/2;
% theta4_1 = atan2(sqrt((ny*cos(theta1) - nx*sin(theta1))^2 + (oy*cos(theta1) - ox*sin(theta1))^2), -ay*cos(theta1) + ax*sin(theta1));
% theta4_2 = atan2(-sqrt((ny*cos(theta1) - nx*sin(theta1))^2 + (oy*cos(theta1) - ox*sin(theta1))^2), -ay*cos(theta1) + ax*sin(theta1));
theta4_1 = atan2(sqrt(az^2 + (ax*cos(theta1) - ay*sin(theta1))^2), ax*sin(theta1) - ay*cos(theta1));
theta4_2 = atan2(-sqrt(az^2 + (ax*cos(theta1) - ay*sin(theta1))^2), ax*sin(theta1) - ay*cos(theta1));
% Calculo de theta5
theta5 = atan2(oy*cos(theta1) - ox*sin(theta1), nx*sin(theta1) - ny*cos(theta1));

% Todas as solucoes ate o momento
q1 = double([theta1, theta2_1, theta3_1, theta4_1, theta5]);
q2 = double([theta1, theta2_1, theta3_1, theta4_2, theta5]);
q3 = double([theta1, theta2_2, theta3_2, theta4_1, theta5]);
q4 = double([theta1, theta2_2, theta3_2, theta4_2, theta5]);
q5 = double([theta1, theta2_3, theta3_1, theta4_1, theta5]);
q6 = double([theta1, theta2_3, theta3_1, theta4_2, theta5]);
q7 = double([theta1, theta2_4, theta3_2, theta4_1, theta5]);
q8 = double([theta1, theta2_4, theta3_2, theta4_2, theta5]);

all_q = [q1; q2; q3; q4; q5; q6; q7; q8];

%% PLOT SOLUCOES

disp('CINEMATICA INVERSA')

for i=1:length(all_q)
    disp(strcat('q',int2str(i),' = '))
    disp(all_q(i,:))
    
    R01_val = subs(R01, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R02_val = subs(R02, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R03_val = subs(R03, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R04_val = subs(R04, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
    R05_val = subs(R05, {L1, L2, L3, L4, t1, t2, t3, t4, t5}, {L1_val, L2_val, L3_val, L4_val, all_q(i,1), all_q(i,2), all_q(i,3), all_q(i,4), all_q(i,5)});
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
end