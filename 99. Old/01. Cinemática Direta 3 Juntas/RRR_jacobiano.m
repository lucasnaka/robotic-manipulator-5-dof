clear
clc

% t1 = theta1; t1p = theta1 ponto;
syms t1 t2 t3 L1 L2 L3 L4 T(alpha, a, d, theta) t1p t2p t3p

%% Funcao simbolica para gerar matriz T dados (alpha, a, d, theta)
T(alpha, a, d, theta) = [cos(theta),            -sin(theta),           0,           a;
                         sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
                         sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha), cos(alpha)*d
                         0,                     0,                      0,          1];

%% Matrizes T e R                     
T01 = T(0, 0, L1+L2, t1);
T12 = T(pi/2, 0, 0, t2);
T23 = T(0, L3, 0, t3);
T34 = T(0, L4, 0, 0);

T02 = simplify(T01*T12);         % Transforma de {2} para {0}
T03 = simplify(T01*T12*T23);     % Transforma de {3} para {0}
T04 = simplify(T01*T12*T23*T34); % Transforma de {4} para {0}

R01 = T01(1:3,1:3);
R12 = T12(1:3,1:3);
R23 = T23(1:3,1:3);
R34 = T34(1:3,1:3);

R10 = R01.';
R21 = R12.';
R32 = R23.';
R43 = R34.';

R02 = simplify(R01*R12);         % Rotaciona de {2} para {0}
R03 = simplify(R01*R12*R23);     % Rotaciona de {3} para {0}
R04 = simplify(R01*R12*R23*R34); % Rotaciona de {4} para {0}

% Origens dos sistemas de coordenadas
O01 = T01(1:3,4);
O12 = T12(1:3,4);
O23 = T23(1:3,4);
O34 = T34(1:3,4);

%% Calcula vetores velocidade (i+1)w(i+1) notado por w_(i+1)_(i+1) e (i+1)v(i+1) notado por v_(i+1)_(i+1)
v_0_0 = [0; 0; 0];
w_0_0 = [0; 0; 0];

w_1_1 = R10*w_0_0 + [0; 0; t1p];
v_1_1 = R10*(v_0_0 + cross(w_0_0, O01));

w_2_2 = R21*w_1_1 + [0; 0; t2p];
v_2_2 = R21*(v_1_1 + cross(w_1_1, O12));

w_3_3 = R32*w_2_2 + [0; 0; t3p];
v_3_3 = R32*(v_2_2 + cross(w_2_2, O23));

w_4_4 = R43*w_3_3 + [0; 0; 0];
v_4_4 = R43*(v_3_3 + cross(w_3_3, O34));

%% Calcula vetores velocidade (0)w(n) notado por w_0_n e (0)v(n) notado por v_0_n
w_0_4 = R04*w_4_4; % w de {4} expressa em {0} = rotacao de {4} pra {0} * w de {4} expressa em {4}
v_0_4 = R04*v_4_4; % v de {4} expressa em {0} = rotacao de {4} pra {0} * v de {4} expressa em {4}

%% Calcula jacobiano J_0 -> [v_4_0; w_4_0] = J * [t1p; t2p; t3p]
J = [diff(v_0_4, t1p), diff(v_0_4, t2p), diff(v_0_4, t3p);
     diff(w_0_4, t1p), diff(w_0_4, t2p), diff(w_0_4, t3p)];

 
%% Animação 3D do robo

% Valores numéricos L
L1_val = 50;
L2_val = 50;
L3_val = 50;
L4_val = 20;

figure
view([45 25])

for t3_val = -pi/2:.2:pi/2
    for t2_val = 0:0.2:pi/2
        for t1_val = 0:.4:2*pi
            % Substituicao dos valores numericos nas matrizes
            T01_val = subs(T01, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});
            T02_val = subs(T02, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});
            T03_val = subs(T03, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});
            T04_val = subs(T04, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});

            O01_val = subs(O01, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});
            O12_val = subs(O12, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});
            O23_val = subs(O23, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});
            O34_val = subs(O34, {L1, L2, L3, L4, t1, t2, t3}, {L1_val, L2_val, L3_val, L4_val, t1_val, t2_val, t3_val});

            P0 = [0; 0; 0; 1];         % Origem sistema
            P1 = [O01_val; 1];         % Origem de {1} em relacao a {0}
            P2 = T01_val*[O12_val; 1]; % Origem de {2} em relacao a {0}
            P3 = T02_val*[O23_val; 1]; % Origem de {3} em relacao a {0}
            P4 = T03_val*[O34_val; 1]; % Origem de {4} em relacao a {0}

            % Ligamento 01
            arm0_x = [P0(1) P1(1)];
            arm0_y = [P0(2) P1(2)];
            arm0_z = [P0(3) P1(3)];
            
            % Ligamento 12
            arm1_x = [P1(1) P2(1)];
            arm1_y = [P1(2) P2(2)];
            arm1_z = [P1(3) P2(3)];
            
            % Ligamento 23
            arm2_x = [P2(1) P3(1)];
            arm2_y = [P2(2) P3(2)];
            arm2_z = [P2(3) P3(3)];
            
            % Ligamento 34
            arm3_x = [P3(1) P4(1)];
            arm3_y = [P3(2) P4(2)];
            arm3_z = [P3(3) P4(3)];
    
            plot3(arm0_x, arm0_y, arm0_z, 'LineWidth',3)
            hold on
            plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',3)
            plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',3)
            plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',3)
            axis([-100 100 -100 100 0 200])
            grid on
            hold off
            pause(0.02);
        end
    end
end

%% Usando robotics toolbox
% 
% L1 = 100;
% L2 = 100;
% L3 = 100;
% L4 = 80;
% 
% % Link = Link([theta d a alpha])
% L(1) = Link([0 L1+L2 0 0]);
% L(2) = Link([0 0 0 pi/2]);
% L(3) = Link([0 0 L3 0]);
% L(4) = Link([0 0 L4 0]);
% 
% Robot = SerialLink(L);
% Robot.name = 'WallE';
% 
% q1 = 0; 
% 
% deltaQ = 0.05;
% 
% figure
% xlim([-100 100])
% q2 = 0; q3 = 0; q4 = 0;
% for q = 0:deltaQ:pi
%             q2 = q2 + deltaQ;
%             q3 = q3 + deltaQ;
%             q4 = q4 + deltaQ;
%             Robot.plot([q1, q2, q3, q4])
% end
% 
% Robot.fkine([q1, q2, q3, q4]);