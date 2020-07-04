close all
clear
clc

%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%

offset3 = -pi/2;

% Exemplo cin inv so com o cotovelo para baixo (total = 2 solucoes)
% Th = [-pi/3; 0; pi/4+offset3; pi/4; pi/4]; 

% Exemplo cin inv com varias solucoes (total = 8 solucoes)
% Th = [-pi/3; 0; 0+offset3; 0; 0];

% Exemplo cin inv com o cotovelo para baixo e para cima (total = 4 solucoes)
% Th = [-pi/3; 0; pi/4+offset3; 0; 0];

% Exemplo cin inv usando t31 e t32 para resolucao de theta5 (total = 2 solucoes)
% Th = [pi/4; 0; pi/2+offset3; pi/4; 0];

Th = [-pi/3; 0; 0+offset3; pi/2; 0];

cinematica_direta;
T05_direta = T05;

figure(1)
plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)

%%
%=========================================================================%
%                                Pieper                                   %
%=========================================================================%

% Matriz definida pelo operador.
%      
% Robjetivo = [nx ox ax
%              ny oy ay
%              nz oz az]
% 
% nx = Robjetivo(1,1);
% ny = Robjetivo(2,1);
% nz = Robjetivo(3,1);
% 
% ox = Robjetivo(1,2);
% oy = Robjetivo(2,2);
% oz = Robjetivo(3,2);
% 
% ax = Robjetivo(1,3);
% ay = Robjetivo(2,3);
% az = Robjetivo(3,3);

nx = T05(1,1);
ny = T05(2,1);
nz = T05(3,1);

ox = T05(1,2);
oy = T05(2,2);
oz = T05(3,2);

ax = T05(1,3);
ay = T05(2,3);
az = T05(3,3);

px = T05(1,4)-eps;
py = T05(2,4);
pz = T05(3,4);

T05_objetivo = [nx ox ax px;
                ny oy ay py;
                nz oz az pz
                0   0  0  1];

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
theta3 = repmat(theta3,1,2);


% Calculo de theta2
a = L(2) - L(3)*S3;
b_1 = L(3)*C3_1;
b_2 = L(3)*C3_2;

theta2 = [atan2(a,b_1) - acos(pz/(sqrt(a^2 + b_1^2))), ...
          atan2(a,b_2) - acos(pz/(sqrt(a^2 + b_2^2))), ...
          atan2(a,b_1) + acos(pz/(sqrt(a^2 + b_1^2))), ...
          atan2(a,b_2) + acos(pz/(sqrt(a^2 + b_2^2)))];

      
% Calculo de theta1
g1 = L(2)*cos(theta2) - L(3)*sin(theta2 + theta3);

theta1 = atan2(py./g1, px./g1);


% Calculo de theta4
c1 = cos(theta1);
s1 = sin(theta1);
c23 = cos(theta2 + theta3);

delta = 1e-7; % Para verificar igualdade ou nao em relacao a 0

flagAumentou4 = false; % Indica que o numero de solucoes aumentou

det = c23;
verif = double(abs(det)) < delta;

if verif == 0 
    disp('Resolvendo sistema com t13 e t23 para encontrar theta4')
    X1 = c1 .* c23;
    X2 = s1 .* c23;
    Y1 = s1;
    Y2 = -c1;
    Z1 = ax;
    Z2 = ay;
    S4 = (Z1 .* Y2 - Z2 .* Y1) ./ (X1 .* Y2 - X2 .* Y1);
    C4 = (Z2 .* X1 - Z1 .* X2) ./ (X1 .* Y2 - X2 .* Y1);
    theta4 = atan2(S4,C4);
else   
    t4_L = []; % Solucoes com sqrt positivas
    t4_R = []; % Solucoes com sqrt negativas
    
    for i = 1:size(c23,2) 
        % Decide qual equacao vamos resolver (t13 ou t23)
        X = c1(i)*c23(i);
        Y = s1(i);
        Z = ax;
        eq = 't13';
        if abs(X) < delta && abs(Y) < delta
            X = s1(i)*c23(i);
            Y = -c1(i);
            Z = ay;
            eq = 't23';
        end
        
        if abs(X) < delta && abs(Y) > delta
            disp(['Resolvendo equacao com ' eq ' para encontrar theta4 (caso i)'])
            C4 = Z/Y;
            t4_1 = atan2(sqrt(1-C4^2), C4);
            t4_L = [t4_L t4_1];
            t4_2 = atan2(-sqrt(1-C4^2), C4);
            t4_R = [t4_R t4_2];
        elseif abs(Y) < delta && abs(X) > delta
            disp(['Resolvendo equacao com ' eq ' para encontrar theta4 (caso ii)'])
            S4 = Z/X;
            t4_1 = atan2(S4, +sqrt(1-S4^2));
            t4_L = [t4_L t4_1];
            t4_2 = atan2(S4, -sqrt(1-S4^2));
            t4_R = [t4_R t4_2];
        elseif abs(X) > delta && abs(Y) > delta && abs(Z) < delta
            disp(['Resolvendo equacao com ' eq ' para encontrar theta4 (caso iii)'])
            t4_1 = atan2(-Y, X);
            t4_L = [t4_L t4_1];
            t4_2 = t4_1 + pi;
            t4_R = [t4_R t4_2];
        end
    end
    flagAumentou4 = true;
    theta4 = [t4_L, t4_R];
end

if(flagAumentou4)
    theta1 = repmat(theta1, 1, 2);
    theta2 = repmat(theta2, 1, 2);
    theta3 = repmat(theta3, 1, 2);
end


% Calculo de theta5
c1 = cos(theta1);
s1 = sin(theta1);
c23 = cos(theta2 + theta3);
s23 = sin(theta2 + theta3);
c4 = cos(theta4);
s4 = sin(theta4);

% Achamos qual sistema linear podemos resolver
det1 = c1.^2.*s23.^2 + (s1.*s4 - c4.*c1.*c23).^2;
verif1 = double(det1) > delta;

det2 = s1.^2.*s23.^2 + (c1.*s4 - c4.*s1.*c23).^2;
verif2 = double(det2) > delta;

det3 = c23.^2 + s23.^2 .* c4.^2;
verif3 = double(det3) > delta;

if verif1 == 1
    disp('Resolvendo sistema com t11 e t12 para encontrar theta5')
    X1 = -c1 .* s23;
    X2 = (s1 .* s4 - c4 .* c1 .* c23);
    Y1 = -(s1 .* s4 - c4 .* c1 .* c23);
    Y2 = -c1 .* s23;
    Z1 = nx;
    Z2 = ox;
    S5 = (Z1 * Y2 - Z2 * Y1) ./ (X1 .* Y2 - X2 .* Y1);
    C5 = (Z2 * X1 - Z1 * X2) ./ (X1 .* Y2 - X2 .* Y1);
elseif verif2 == 1
    disp('Resolvendo sistema com t21 e t22 para encontrar theta5')
    X1 = -s1 .* s23;
    X2 = -(c1 .* s4 + c4 .* s1 .* c23);
    Y1 = (c1 .* s4 + c4 .* s1 .* c23);
    Y2 = -s1 .* s23;
    Z1 = ny;
    Z2 = oy;
    S5 = (Z1 * Y2 - Z2 * Y1) ./ (X1 .* Y2 - X2 .* Y1);
    C5 = (Z2 * X1 - Z1 * X2) ./ (X1 .* Y2 - X2 .* Y1);
elseif verif3 == 1
    disp('Resolvendo sistema com t31 e t32 para encontrar theta5')
    X1 = c23;
    X2 = -s23 .* c4;
    Y1 = s23 .* c4;
    Y2 = c23;
    Z1 = nz;
    Z2 = oz;
    S5 = (Z1 * Y2 - Z2 * Y1) ./ (X1 .* Y2 - X2 .* Y1);
    C5 = (Z2 * X1 - Z1 * X2) ./ (X1 .* Y2 - X2 .* Y1);
end
theta5 = atan2(S5,C5);

% Todas as solucoes ate o momento
all_q = [theta1; theta2; theta3; theta4; theta5].';

% Verificamos a coerencia das solucoes e eliminamos aquelas que sao inconsistentes com a realidade
eliminateIndex = [];
for i = 1:size(all_q, 1)    
    Th = all_q(i,:);
    
    cinematica_direta;
    
    eliminate = checkCinematicaDireta(T05_objetivo, Th, delta);
    
    if eliminate == true
        eliminateIndex = [eliminateIndex, i];
    end
end
% Elimina as solucoes incoerentes e iguala a zero os numeros muito pequenos
all_q(eliminateIndex,:) = [];
all_q(double(abs(all_q)) < delta) = 0;

%% PLOT SOLUCOES
disp('CINEMATICA INVERSA')

figure(2)
for i=1:size(all_q,1)    
    Th = all_q(i,:);
    cinematica_direta;
    
    fprintf(strcat('\nq',int2str(i),' = ',mat2str(double(all_q(i,:))),'\n'));
    
    disp('Da cinematica inversa (calculado):')
    disp(vpa(T05))
    
    disp('Da cinematica direta (objetivo):');
    disp(vpa(T05_direta))
    
    subplot(size(all_q,1)/2,2,i)
    plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)
end


%% Verificacao da orientacao
% R05_obj = [nx, ox, ax;
%            ny, oy  ay;
%            nz, oz, az];  
% 
% % {0}
% X = [1; 0; 0];
% Y = [0; 1; 0];
% Z = [0; 0; 1];
% 
% % {5} objetivo
% X5obj = R05_obj' * 1.2*X;
% Y5obj = R05_obj' * 1.2*Y;
% Z5obj = R05_obj' * 1.2*Z;
% 
% % {5} obtido
% X5 = R05' * 1.4*X;
% Y5 = R05' * 1.4*Y;
% Z5 = R05' * 1.4*Z;
% 
% figure(3)
% view([45 25])
% grid
% xlim([-2 2])
% ylim([-2 2])
% zlim([-2 2])
% hold on
% 
% quiver3(0,0,0,X(1),X(2),X(3), 'Color', 'b', 'linewidth', 1.2);
% quiver3(0,0,0,Y(1),Y(2),Y(3), 'Color', 'b', 'linewidth', 1.2);
% h1 = quiver3(0,0,0,Z(1),Z(2),Z(3), 'Color', 'b', 'linewidth', 1.2);
% 
% quiver3(0,0,0,X5obj(1),X5obj(2),X5obj(3), 'Color', 'r', 'linewidth', 1.2);
% quiver3(0,0,0,Y5obj(1),Y5obj(2),Y5obj(3), 'Color', 'r', 'linewidth', 1.2);
% h2 = quiver3(0,0,0,Z5obj(1),Z5obj(2),Z5obj(3), 'Color', 'r', 'linewidth', 1.2);
% 
% quiver3(0,0,0,X5(1),X5(2),X5(3), 'Color', 'g', 'linewidth', 1.2);
% quiver3(0,0,0,Y5(1),Y5(2),Y5(3), 'Color', 'g', 'linewidth', 1.2);
% h3 = quiver3(0,0,0,Z5(1),Z5(2),Z5(3), 'Color', 'g', 'linewidth', 1.2);
% 
% hold off
% 
% legend([h1, h2, h3], '\{0\}', '\{5\} desejado', '\{5\} obtido')
% 
% xlabel('x','FontSize',16)
% ylabel('y','FontSize',16)
% zlabel('z','FontSize',16)