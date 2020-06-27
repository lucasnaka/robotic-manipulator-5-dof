clear all
close all
clc

%=========================================================================%
%                      Parametros do manipulador                          %
%=========================================================================%
%             i | alpha(i-1) | a(i-1) | d(i) | theta(i)                   %
%             1 |      0     |   0    |   0  | theta1                     %
%             2 |    90°     |   0    |   0  | theta2                     %
%             3 |      0     |  L2    |   0  | theta3 - pi/2              %
%             4 |   270°     |   0    |  L3  | theta4                     %
%             5 |    90°     |   0    |   0  | theta5                     %
%=========================================================================%

% t1 = theta1; t1p = theta1 ponto;
syms th1(t) th2(t) th3(t) th4(t) th5(t) L1 L2 L3 L4 T(alpha, a, d, theta) ...
     dth1(t) dth2(t) dth3(t) dth4(t) dth5(t) ddth1(t) ddth2(t) ddth3(t) ddth4(t) ddth5(t)

%% Funcao simbolica para gerar matriz T dados (alpha, a, d, theta)
T(alpha, a, d, theta) = [cos(theta),            -sin(theta),           0,           a;
                         sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
                         sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha), cos(alpha)*d
                         0,                     0,                      0,          1];

%% Aplicacao no robo de cinco juntas
L1 = 0.226; % [m]
L2 = 0.250; % [m]
L3 = 0.160 + 0.072; % [m]
L5 = 0.075; % [m]

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
% d4 = 0;

d5 = 0;

%% Matrizes T e R                     
T01 = T(0, 0, d1, th1);
T12 = T(alpha1, a1, d2, th2);
T23 = T(alpha2, a2, d3, th3);
T34 = T(alpha3, a3, d4, th4);
T45 = T(alpha4, a4, d5, th5);

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

% Origens dos sistemas de coordenadas
O01 = T01(1:3,4);
O12 = T12(1:3,4);
O23 = T23(1:3,4);
O34 = T34(1:3,4);
O45 = T45(1:3,4);

%% Calcula vetores velocidade (i+1)w(i+1) notado por w_(i+1)_(i+1) e (i+1)v(i+1) notado por v_(i+1)_(i+1)
v_0_0 = [0; 0; 0];
w_0_0 = [0; 0; 0];

w_1_1 = simplify(combine(R10*w_0_0 + [0; 0; dth1]));
v_1_1 = simplify(combine(R10*(v_0_0 + cross(w_0_0, O01))));

w_2_2 = simplify(combine(R21*w_1_1 + [0; 0; dth2]));
v_2_2 = simplify(combine(R21*(v_1_1 + cross(w_1_1, O12))));

w_3_3 = simplify(combine(R32*w_2_2 + [0; 0; dth3]));
v_3_3 = simplify(combine(R32*(v_2_2 + cross(w_2_2, O23))));

w_4_4 = simplify(combine(R43*w_3_3 + [0; 0; dth4]));
v_4_4 = simplify(combine(R43*(v_3_3 + cross(w_3_3, O34))));

w_5_5 = simplify(combine(R54*w_4_4 + [0; 0; dth5]));
v_5_5 = simplify(combine(R54*(v_4_4 + cross(w_4_4, O45))));

%% 
syms k(m, vc, omega, I) u(m, g, Oc, u_ref)

% Funcao simbolica para gerar energia cinética dados (m, vc, omega, I)
k = @(m, vc, omega, I) 1/2*m*vc.'*vc + 1/2*omega.'*I*omega;

%% Funcao simbolica para gerar energia potencial dados (m, g, Oc, u_ref)
u = @(m, g, Oc, u_ref) -m*[0; 0; -g].'*Oc + u_ref;

%%
syms Lc1 Lc2 Lc3 Lc4 Lc5 I1 I2 I3 I4 I5 m1 m2 m3 m4 m5 g

m1 = 8; % [Kg]
m2 = 4; % [Kg]
m3 = 4; % [Kg]
m4 = 2; % [Kg]
m5 = 2; % [Kg]

Lc1 = L1/2; % [m]
Lc2 = L2/2; % [m]
Lc3 = L3/2; % [m]
Lc4 = L4/2; % [m]
Lc5 = L5/2; % [m]

I1 = [0.0456 0 0;
      0 0.0456 0;
      0 0 0.0231];
I2 = [0.0059 0 0;
      0 0.0246 0;
      0 0 0.0230];
I3 = [0.0059 0 0;
      0 0.0123 0;
      0 0 0.0107];
I4 = [0.0017 0 0;
      0 0.0017 0;
      0 0 0.0016];
I5 = [0.0017 0 0;
      0 0.0017 0;
      0 0 0.0016];

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
v_1_c1 = simplify(combine(v_1_1 + cross(w_1_1, O1C1)));
v_2_c2 = simplify(combine(v_2_2 + cross(w_2_2, O2C2)));
v_3_c3 = simplify(combine(v_3_3 + cross(w_3_3, O3C3)));
v_4_c4 = simplify(combine(v_4_4 + cross(w_4_4, O4C4)));
v_5_c5 = simplify(combine(v_5_5 + cross(w_5_5, O5C5)));

% Velocidades dos centros de massa de cada ligamento com relação ao
% referencial inercial {0}
v_0_c1 = simplify(combine(R01*v_1_c1));
v_0_c2 = simplify(combine(R02*v_2_c2));
v_0_c3 = simplify(combine(R03*v_3_c3));
v_0_c4 = simplify(combine(R04*v_4_c4));
v_0_c5 = simplify(combine(R05*v_5_c5));

% Energia cinetica para cada ligamento
k1 = k(m1, v_0_c1, w_1_1, I1);
k2 = k(m2, v_0_c2, w_2_2, I2);
k3 = k(m3, v_0_c3, w_3_3, I3);
k4 = k(m4, v_0_c4, w_4_4, I4);
k5 = k(m5, v_0_c5, w_5_5, I5);

% Energia cinetica do sistema
k = simplify(combine(k1 + k2 + k3 + k4 + k5));

% Energia potencial para cada ligamento
u1 = simplify(combine(u(m1, g, O0C1, 0)));
u2 = simplify(combine(u(m2, g, O0C2, 0)));
u3 = simplify(combine(u(m3, g, O0C3, 0)));
u4 = simplify(combine(u(m4, g, O0C4, 0)));
u5 = simplify(combine(u(m5, g, O0C5, 0)));

% Energia potencial do sistema
u = simplify(combine(u1 + u2 + u3 + u4 + u5));

% Lagrangiano
syms x

delk_deldth1 = subs(diff(subs(k, dth1(t), x), x), x, dth1(t));
delk_deldth2 = subs(diff(subs(k, dth2(t), x), x), x, dth2(t));
delk_deldth3 = subs(diff(subs(k, dth3(t), x), x), x, dth3(t));
delk_deldth4 = subs(diff(subs(k, dth4(t), x), x), x, dth4(t));
delk_deldth5 = subs(diff(subs(k, dth5(t), x), x), x, dth5(t));

delk_delth1 = subs(diff(subs(k, th1(t), x), x), x, th1(t));
delk_delth2 = subs(diff(subs(k, th2(t), x), x), x, th2(t));
delk_delth3 = subs(diff(subs(k, th3(t), x), x), x, th3(t));
delk_delth4 = subs(diff(subs(k, th4(t), x), x), x, th4(t));
delk_delth5 = subs(diff(subs(k, th5(t), x), x), x, th5(t));

delu_delth1 = subs(diff(subs(u, th1(t), x), x), x, th1(t));
delu_delth2 = subs(diff(subs(u, th2(t), x), x), x, th2(t));
delu_delth3 = subs(diff(subs(u, th3(t), x), x), x, th3(t));
delu_delth4 = subs(diff(subs(u, th4(t), x), x), x, th4(t));
delu_delth5 = subs(diff(subs(u, th5(t), x), x), x, th5(t));

tau1 = diff(delk_deldth1,t) - delk_delth1 + delu_delth1;
tau2 = diff(delk_deldth2,t) - delk_delth2 + delu_delth2;
tau3 = diff(delk_deldth3,t) - delk_delth3 + delu_delth3;
tau4 = diff(delk_deldth4,t) - delk_delth4 + delu_delth4;
tau5 = diff(delk_deldth5,t) - delk_delth5 + delu_delth5;

%%
tau1_subs = simplify(combine(subs(tau1, [diff(th1(t),t) diff(th2(t),t) diff(th3(t),t) diff(th4(t),t) diff(th5(t),t) ...
            diff(dth1(t),t) diff(dth2(t),t) diff(dth3(t),t) diff(dth4(t),t) diff(dth5(t),t)], ...
            [dth1 dth2 dth3 dth4 dth5 ddth1 ddth2 ddth3 ddth4 ddth5])));
tau2_subs = simplify(combine(subs(tau2, [diff(th1(t),t) diff(th2(t),t) diff(th3(t),t) diff(th4(t),t) diff(th5(t),t) ...
            diff(dth1(t),t) diff(dth2(t),t) diff(dth3(t),t) diff(dth4(t),t) diff(dth5(t),t)], ...
            [dth1 dth2 dth3 dth4 dth5 ddth1 ddth2 ddth3 ddth4 ddth5])));
tau3_subs = simplify(combine(subs(tau3, [diff(th1(t),t) diff(th2(t),t) diff(th3(t),t) diff(th4(t),t) diff(th5(t),t) ...
            diff(dth1(t),t) diff(dth2(t),t) diff(dth3(t),t) diff(dth4(t),t) diff(dth5(t),t)], ...
            [dth1 dth2 dth3 dth4 dth5 ddth1 ddth2 ddth3 ddth4 ddth5])));
tau4_subs = simplify(combine(subs(tau4, [diff(th1(t),t) diff(th2(t),t) diff(th3(t),t) diff(th4(t),t) diff(th5(t),t) ...
            diff(dth1(t),t) diff(dth2(t),t) diff(dth3(t),t) diff(dth4(t),t) diff(dth5(t),t)], ...
            [dth1 dth2 dth3 dth4 dth5 ddth1 ddth2 ddth3 ddth4 ddth5])));
tau5_subs = simplify(combine(subs(tau5, [diff(th1(t),t) diff(th2(t),t) diff(th3(t),t) diff(th4(t),t) diff(th5(t),t) ...
            diff(dth1(t),t) diff(dth2(t),t) diff(dth3(t),t) diff(dth4(t),t) diff(dth5(t),t)], ...
            [dth1 dth2 dth3 dth4 dth5 ddth1 ddth2 ddth3 ddth4 ddth5])));

%%
        
% Calculo da matriz M
tau1_subs_ddth1 = collect_multipied_by_term(tau1_subs, ddth1);
tau1_subs_ddth2 = collect_multipied_by_term(tau1_subs, ddth2);
tau1_subs_ddth3 = collect_multipied_by_term(tau1_subs, ddth3);
tau1_subs_ddth4 = collect_multipied_by_term(tau1_subs, ddth4);
tau1_subs_ddth5 = collect_multipied_by_term(tau1_subs, ddth5);

tau2_subs_ddth1 = collect_multipied_by_term(tau2_subs, ddth1);
tau2_subs_ddth2 = collect_multipied_by_term(tau2_subs, ddth2);
tau2_subs_ddth3 = collect_multipied_by_term(tau2_subs, ddth3);
tau2_subs_ddth4 = collect_multipied_by_term(tau2_subs, ddth4);
tau2_subs_ddth5 = collect_multipied_by_term(tau2_subs, ddth5);

tau3_subs_ddth1 = collect_multipied_by_term(tau3_subs, ddth1);
tau3_subs_ddth2 = collect_multipied_by_term(tau3_subs, ddth2);
tau3_subs_ddth3 = collect_multipied_by_term(tau3_subs, ddth3);
tau3_subs_ddth4 = collect_multipied_by_term(tau3_subs, ddth4);
tau3_subs_ddth5 = collect_multipied_by_term(tau3_subs, ddth5);

tau4_subs_ddth1 = collect_multipied_by_term(tau4_subs, ddth1);
tau4_subs_ddth2 = collect_multipied_by_term(tau4_subs, ddth2);
tau4_subs_ddth3 = collect_multipied_by_term(tau4_subs, ddth3);
tau4_subs_ddth4 = collect_multipied_by_term(tau4_subs, ddth4);
tau4_subs_ddth5 = collect_multipied_by_term(tau4_subs, ddth5);

tau5_subs_ddth1 = collect_multipied_by_term(tau5_subs, ddth1);
tau5_subs_ddth2 = collect_multipied_by_term(tau5_subs, ddth2);
tau5_subs_ddth3 = collect_multipied_by_term(tau5_subs, ddth3);
tau5_subs_ddth4 = collect_multipied_by_term(tau5_subs, ddth4);
tau5_subs_ddth5 = collect_multipied_by_term(tau5_subs, ddth5);

M = [tau1_subs_ddth1 tau1_subs_ddth2 tau1_subs_ddth3 tau1_subs_ddth4 tau1_subs_ddth5;
     tau2_subs_ddth1 tau2_subs_ddth2 tau2_subs_ddth3 tau2_subs_ddth4 tau2_subs_ddth5;
     tau3_subs_ddth1 tau3_subs_ddth2 tau3_subs_ddth3 tau3_subs_ddth4 tau3_subs_ddth5;
     tau4_subs_ddth1 tau4_subs_ddth2 tau4_subs_ddth3 tau4_subs_ddth4 tau4_subs_ddth5;
     tau5_subs_ddth1 tau5_subs_ddth2 tau5_subs_ddth3 tau5_subs_ddth4 tau5_subs_ddth5];

M(:,1) = M(:,1)/ddth1;
M(:,2) = M(:,2)/ddth2;
M(:,3) = M(:,3)/ddth3;
M(:,4) = M(:,4)/ddth4;
M(:,5) = M(:,5)/ddth5;

M = simplify(combine(M));

% Calculo da matriz G
tau1_subs_g = collect_multipied_by_term(tau1_subs, g);
tau2_subs_g = collect_multipied_by_term(tau2_subs, g);
tau3_subs_g = collect_multipied_by_term(tau3_subs, g);
tau4_subs_g = collect_multipied_by_term(tau4_subs, g);
tau5_subs_g = collect_multipied_by_term(tau5_subs, g);

G = [tau1_subs_g;
     tau2_subs_g;
     tau3_subs_g;
     tau4_subs_g;
     tau5_subs_g];

G = simplify(combine(G));

% Calculo da matriz V
tau1_subs_v = children(collect(tau1_subs, [dth1 dth2 dth3 dth4 dth5]));
tau1_subs_v = sum(tau1_subs_v(1:length(tau1_subs_v)-1));
tau2_subs_v = children(collect(tau2_subs, [dth1 dth2 dth3 dth4 dth5]));
tau2_subs_v = sum(tau2_subs_v(1:length(tau2_subs_v)-1));
tau3_subs_v = children(collect(tau3_subs, [dth1 dth2 dth3 dth4 dth5]));
tau3_subs_v = sum(tau3_subs_v(1:length(tau3_subs_v)-1));
tau4_subs_v = children(collect(tau4_subs, [dth1 dth2 dth3 dth4 dth5]));
tau4_subs_v = sum(tau4_subs_v(1:length(tau4_subs_v)-1));
tau5_subs_v = children(collect(tau5_subs, [dth1 dth2 dth3 dth4 dth5]));
tau5_subs_v = sum(tau5_subs_v(1:length(tau5_subs_v)-1));

V = [tau1_subs_v;
     tau2_subs_v;
     tau3_subs_v;
     tau4_subs_v;
     tau5_subs_v];

V = simplify(combine(V));

function term = collect_multipied_by_term(tau_subs, term)
    term = children(collect(tau_subs, term));
    if length(term) == 2 % se tiver tamanho 2 significa que achou um termo multiplicado por ddth
        term = term(1); % termo multiplicado por ddth
    else
        term = 0;
    end
end