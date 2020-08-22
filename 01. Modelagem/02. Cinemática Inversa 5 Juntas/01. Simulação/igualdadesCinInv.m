%=========================================================================%
%                     Iguldades Cinematica Inversa                        %
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

close all
clear
clc

syms nx ny nz ox oy oz ax ay az px py pz gamma beta

%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%

cinematica_direta_simbolica;

%=========================================================================%
%                     Definicao Matriz Objetivo                           %
%=========================================================================%

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

T05_obj = [nx, ox, ax, px;
           ny, oy, ay, py;
           nz, oz, az, pz;
           0,  0,  0,  1];

%=========================================================================%
%                        Igualdades Matriciais                            %
%=========================================================================%

% Equacao 1
LHS1 = simplify(combine(inv(T01)*T05_obj));
RHS1 = simplify(combine(T12*T23*T34*T45));

% Equacao 2
LHS2 = simplify(combine(inv(T12)*inv(T01)*T05_obj));
RHS2 = simplify(combine(T23*T34*T45));

% Equacao 3
LHS3 = simplify(combine(inv(T23)*inv(T12)*inv(T01)*T05_obj));
RHS3 = simplify(combine(T34*T45));

% Equacao 4
LHS4 = simplify(combine(inv(T34)*inv(T23)*inv(T12)*inv(T01)*T05_obj));
RHS4 = simplify(combine(T45));