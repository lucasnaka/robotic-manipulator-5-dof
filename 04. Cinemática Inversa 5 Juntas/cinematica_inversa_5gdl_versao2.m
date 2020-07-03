close all
clear
clc

%=========================================================================%
%                          Cinematica Direta                              %
%=========================================================================%

offset3 = -pi/2;
Th = [-pi/3; 0; 0+offset3; pi/4; pi/2];

cinematica_direta;
T05_direta = T05;
T04_direta = T04;

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

ax = T05(1,3);
ay = T05(2,3);
az = T05(3,3);

ox = T05(1,2);
oy = T05(2,2);
oz = T05(3,2);

nx = T05(1,1);
ny = T05(2,1);
nz = T05(3,1);

px = T05(1,4)-eps;
py = T05(2,4);
pz = T05(3,4);

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

% Calculo de theta4 e theta5
%   So funciona bem nos seguintes casos: 
%       * theta3  = 0, para todos os outros thetas
%       * theta3 != 0, se theta4 = 0

c1 = cos(theta1);
s1 = sin(theta1);
c23 = cos(theta2 + theta3);

% Calculo de theta4
delta = 1e-6; % Para verificar igualdade ou nao em relacao a 0

t4_L = []; % Solucoes com sqrt positivas
t4_R = []; % Solucoes com sqrt negativas

flagAumentou4 = false; % Indica que o numero de solucoes aumentou 
flagSingular4 = false; % Indica uma configuracao singular do robo

for i = 1:size(c23,2) 
    if abs(c23(i)) < delta
        flagSingular4 = true;
        % Decide qual equacao vamos resolver (1 ou 2)
        X = c1(i)*c23(i);
        Y = s1(i);
        Z = ax;
        eq = 1;
        if abs(X) < delta && abs(Y) < delta
            eq = 2;
        end
        
        if eq == 1
            disp('Resolvendo equacao 1') % c1*c23*s4 + s1*c4 = ax
            if abs(X) < delta && abs(Y) > delta
                disp('caso i')
                C4 = Z/Y;
                t4_1 = atan2(-sqrt(1-C4^2), C4);
                t4_L = [t4_L t4_1];
                t4_2 = atan2(+sqrt(1-C4^2), C4);
                t4_R = [t4_R t4_2];
                flagAumentou4 = true;
            elseif abs(Y) < delta && abs(X) > delta
                disp('caso ii')
                S4 = Z/X;
                t4_1 = atan2(S4, sqrt(1-S4^2));
                t4_L = [t4_L t4_1];
                t4_2 = atan2(S4, -sqrt(1-S4^2));
                t4_R = [t4_R t4_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) < delta
                disp('caso iii')
                t4_1 = atan2(-Y, X);
                t4_L = [t4_L t4_1];
                t4_2 = t4_1 + pi;
                t4_R = [t4_R t4_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) > delta
                disp('caso iv')
            end
            
        elseif eq == 2
            disp('Resolvendo equacao 2') % s1*c23*s4 - c1*c4 = ay
            X = s1(i)*c23(i);
            Y = -c1(i);
            Z = ay;
            if abs(X) < delta && abs(Y) > delta
                disp('caso i')
                C4 = Z/Y;
                t4_1 = atan2(sqrt(1-C4^2), C4);
                t4_L = [t4_L t4_1];
                t4_2 = atan2(-sqrt(1-C4^2), C4);
                t4_R = [t4_R t4_2];
                flagAumentou4 = true;
            elseif abs(Y) < delta && abs(X) > delta
                disp('caso ii')
                S4 = Z/X;
                t4_1 = atan2(S4, sqrt(1-S4^2));
                t4_L = [t4_L t4_1];
                t4_2 = atan2(S4, -sqrt(1-S4^2));
                t4_R = [t4_R t4_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) < delta
                disp('caso iii')
                t4_1 = atan2(-Y, X);
                t4_L = [t4_L t4_1];
                t4_2 = t4_1 + pi;
                t4_R = [t4_R t4_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) > delta
                disp('caso iv')
            end
        end
        
        theta4 = [t4_L, t4_R];
    end
end

if(flagSingular4 == false)
    disp('Resolvendo sistema')
    X1 = c1 .* c23;
    X2 = s1 .* c23;
    Y1 = s1;
    Y2 = -c1;
    Z1 = ax;
    Z2 = ay;
    S4 = (Z1 .* Y2 - Z2 .* Y1) ./ (X1 .* Y2 - X2 .* Y1);
    C4 = (Z2 .* X1 - Z1 .* X2) ./ (X1 .* Y2 - X2 .* Y1);
%     S4 = (ax*c1 + ay*s1) ./ (c23);
%     C4 = (ax*s1.*c23 - ay*c1.*c23) ./ (c23);
    theta4 = atan2(S4,C4);
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

t5_L = []; % Solucoes com sqrt positivas
t5_R = []; % Solucoes com sqrt negativas

flagAumentou5 = false; % Indica que o numero de solucoes aumentou
flagSingular5 = false; % Indica uma configuracao singular do robo

for i = 1:size(c4,2)  
    if abs(c23(i)^2 + s23(i)^2 * c4(i)^2) < delta
        flagSingular5 = true;
        % Decide qual equacao vamos resolver (1 ou 2)
        X = c23(i);
        Y = s23(i) * c4(i);
        Z = nz;
        eq = 1;
        if abs(X) < delta && abs(Y) < delta
            eq = 2;
        end

        if eq == 1
            disp('Resolvendo equacao 1') % c23*s5 + s23*c4*c5 = nz
            if abs(X) < delta && abs(Y) > delta
                disp('caso i')
                C5 = Z/Y;
                t5_1 = atan2(sqrt(1-C5^2), C5);
                t5_L = [t5_L t5_1];
                t5_2 = atan2(-sqrt(1-C5^2), C5);
                t5_R = [t5_R t5_2];
                flagAumentou5 = true;
            elseif abs(Y) < delta && abs(X) > delta
                disp('caso ii')
                S5 = Z/X;
                t5_1 = atan2(S5, sqrt(1-S5^2));
                t5_L = [t5_L t5_1];
                t5_2 = atan2(S5, -sqrt(1-S5^2));
                t5_R = [t5_R t5_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) < delta
                disp('caso iii')
                t5_1 = atan2(-Y, X);
                t5_L = [t5_L t5_1];
                t5_2 = t5_1 + pi;
                t5_R = [t5_R t5_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) > delta
                disp('caso iv')
            end
            
        elseif eq == 2
            disp('Resolvendo equacao 2') % -s23*c4*s5 + c23*c5 = oz
            X = -s23(i) * c4(i);
            Y = c23(i);
            Z = oz;
            if abs(X) < delta && abs(Y) > delta
                disp('caso i')
                C5 = Z/Y;
                t5_1 = atan2(sqrt(1-C5^2), C5);
                t5_L = [t5_L t5_1];
                t5_2 = atan2(-sqrt(1-C5^2), C5);
                t5_R = [t5_R t5_2];
                flagAumentou5 = true;
            elseif abs(Y) < delta && abs(X) > delta
                disp('caso ii')
                S5 = Z/X;
                t5_1 = atan2(S5, sqrt(1-S5^2));
                t5_L = [t5_L t5_1];
                t5_2 = atan2(S5, -sqrt(1-S5^2));
                t5_R = [t5_R t5_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) < delta
                disp('caso iii')
                t5_1 = atan2(-Y, X);
                t5_L = [t5_L t5_1];
                t5_2 = t5_1 + pi;
                t5_R = [t5_R t5_2];
                flagAumentou4 = true;
            elseif abs(X) > delta && abs(Y) > delta && abs(Z) > delta
                disp('caso iv')
            end
        end
        
        theta5 = [t5_L, t5_R];
    end
end

if(flagSingular5 == false)
    disp('Resolvendo sistema')
    X1 = c23;
    X2 = -s23 .* c4;
    Y1 = s23 .* c4;
    Y2 = c23;
    Z1 = nz;
    Z2 = oz;
    S5 = (Z1 .* Y2 - Z2 .* Y1) ./ (X1 .* Y2 - X2 .* Y1);
    C5 = (Z2 .* X1 - Z1 .* X2) ./ (X1 .* Y2 - X2 .* Y1);
%     S5 = (nz*c23 - oz*s23.*c4) ./ (c23.^2 + s23.^2 .* c4.^2);
%     C5 = (oz*c23 + nz*s23.*c4) ./ (c23.^2 + s23.^2 .* c4.^2);
    theta5 = atan2(S5,C5);
end

if(flagAumentou5)
    theta1 = repmat(theta1, 1, 2);
    theta2 = repmat(theta2, 1, 2);
    theta3 = repmat(theta3, 1, 2);
    theta4 = repmat(theta4, 1, 2);
end

% Todas as solucoes ate o momento
all_q = [theta1; theta2; theta3; theta4; theta5].';
%% PLOT SOLUCOES
disp('CINEMATICA INVERSA')

figure(2)
for i=1:size(all_q,1)
    disp(strcat('q',int2str(i),' = '))
    disp(all_q(i,:))
    
    Th = all_q(i,:);
    cinematica_direta;
    
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