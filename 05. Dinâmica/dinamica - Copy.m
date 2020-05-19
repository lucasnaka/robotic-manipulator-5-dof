clear
clc

% i  alpha(i-1)    a(i-1)     d(i)     theta(i)
% 1    0            0           0       theta1
% 2   90°           0           0       theta2
% 3    0           L2           0       theta3
% 4   270°          0           0       theta4
% 5   90°           0           0       theta5

% t1 = theta1; t1p = theta1 ponto;
syms t1 t2 t3 t4 t5 L1 L2 L3 L4 T(alpha, a, d, theta) t1p t2p t3p t4p t5p

t1p = diff(t1)

%% Funcao simbolica para gerar matriz T dados (alpha, a, d, theta)
T = @(alpha, a, d, theta) [cos(theta),            -sin(theta),           0,           a;
                          sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
                          sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha), cos(alpha)*d
                          0,                     0,                      0,          1];

%% Aplicacao no robo de cinco juntas

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
d4 = 0;

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

%% 
syms k(m, vc, omega, I) u(m, g, Oc, u_ref)

% Funcao simbolica para gerar energia cinética dados (m, vc, omega, I)
k = @(m, vc, omega, I) 1/2*m*vc.'*vc + 1/2*omega.'*I*omega;

%% Funcao simbolica para gerar energia potencial dados (m, g, Oc, u_ref)
u = @(m, g, Oc, u_ref) -m*[0; 0; -g].'*Oc + u_ref;

%%
syms Lc1 Lc2 Lc3 Lc4 Lc5 I1 I2 I3 I4 I5 m1 m2 m3 m4 m5 g

% Posicoes dos centro de massa com relacao ao referencial da junta do
% ligamento analisado
O1C1 = [0; 0; -Lc1];
O2C2 = [Lc2; 0; 0];
O3C3 = [0; Lc3; 0];
O4C4 = [0; 0; Lc4];
O5C5 = [0; Lc5; 0];

% Posicoes dos centro de massa com relacao ao referencial inercial {0}
O0C1 = R01*O1C1;
O0C2 = R02*O2C2;
O0C3 = R03*O3C3;
O0C4 = R04*O4C4;
O0C5 = R05*O5C5;

% Velocidades dos centros de massa de cada ligamento
v_1_c1 = v_1_1 + cross(w_1_1, O1C1);
v_2_c2 = v_2_2 + cross(w_2_2, O2C2);
v_3_c3 = v_3_3 + cross(w_3_3, O3C3);
v_4_c4 = v_4_4 + cross(w_4_4, O4C4);
v_5_c5 = v_5_5 + cross(w_5_5, O5C5);

% Velocidades dos centros de massa de cada ligamento com relação ao
% referencial inercial {0}
v_0_c1 = R01*v_1_c1;
v_0_c2 = R02*v_2_c2;
v_0_c3 = R03*v_3_c3;
v_0_c4 = R04*v_4_c4;
v_0_c5 = R05*v_5_c5;

% Energia cinetica para cada ligamento
k1 = k(m1, v_0_c1, w_1_1, I1);
k2 = k(m2, v_0_c2, w_2_2, I2);
k3 = k(m3, v_0_c3, w_3_3, I3);
k4 = k(m4, v_0_c4, w_4_4, I4);
k5 = k(m5, v_0_c5, w_5_5, I5);

% Energia cinetica do sistema
k = k1 + k2 + k3 + k4 + k5;

% Energia potencial para cada ligamento
u1 = u(m1, g, O0C1, 0);
u2 = u(m2, g, O0C2, 0);
u3 = u(m3, g, O0C3, 0);
u4 = u(m4, g, O0C4, 0);
u5 = u(m5, g, O0C5, 0);

% Energia potencial do sistema
u = u1 + u2 + u3 + u4 + u5;

% Lagrangiano
