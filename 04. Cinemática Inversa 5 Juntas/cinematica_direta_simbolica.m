%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%
%                      Parametros do manipulador                          %
%=========================================================================%
%             i | alpha(i-1) | a(i-1) | d(i) | theta(i)                   %
%             1 |      0     |   0    |   0  | theta1                     %
%             2 |    90�     |   0    |   0  | theta2                     %
%             3 |      0     |  L2    |   0  | theta3 - pi/2              %
%             4 |   270�     |   0    |  L3  | theta4                     %
%             5 |    90�     |   0    |   0  | theta5                     %
%=========================================================================%

syms L1 L2 L3 L4 t1 t2 t3 t4 t5 

loadT;

Th = [t1; t2; t3; t4; t5];
L = [L1; L2; L3; L4];

alpha = [0, pi/2, 0, 3*pi/2, pi/2];
a = [0, 0, L(2), 0, 0];
d = [0, 0, 0, L(3), 0];

T01 = T(alpha(1), a(1), d(1), Th(1));          % Transforma de {1} para {0}
T12 = T(alpha(2), a(2), d(2), Th(2));          % Transforma de {2} para {1}
T23 = T(alpha(3), a(3), d(3), Th(3));          % Transforma de {3} para {2}
T34 = T(alpha(4), a(4), d(4), Th(4));          % Transforma de {4} para {3}
T45 = T(alpha(5), a(5), d(5), Th(5));          % Transforma de {5} para {4}

T02 = simplify(T01*T12);                                 % Transforma de {2} para {0}
T03 = simplify(T01*T12*T23);                             % Transforma de {3} para {0}
T04 = simplify(T01*T12*T23*T34);                         % Transforma de {4} para {0}
T05 = simplify(T01*T12*T23*T34*T45);                     % Transforma de {5} para {0}

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

R02 = R01*R12;                                  % Rotaciona de {2} para {0}
R03 = R01*R12*R23;                              % Rotaciona de {3} para {0}
R04 = R01*R12*R23*R34;                          % Rotaciona de {4} para {0}
R05 = R01*R12*R23*R34*R45;                      % Rotaciona de {5} para {0}

disp('From script cinematica_direta.m:')
disp('T05 Matrix')
disp(T05)