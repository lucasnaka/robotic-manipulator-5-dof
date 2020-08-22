function [ thetaSolucao ] = cinInversa(thetaAtual, T05_objetivo)

L = [0.226, 0.250, 0.160 + 0.072, 0.075]; % [m]

%=========================================================================%
%                                Pieper                                   %
%=========================================================================%

nx = T05_objetivo(1,1);
ny = T05_objetivo(2,1);
nz = T05_objetivo(3,1);

ox = T05_objetivo(1,2);
oy = T05_objetivo(2,2);
oz = T05_objetivo(3,2);

ax = T05_objetivo(1,3);
ay = T05_objetivo(2,3);
az = T05_objetivo(3,3);

px = T05_objetivo(1,4)-eps;
py = T05_objetivo(2,4);
pz = T05_objetivo(3,4);

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

% Verifica se o sistema nao e impossivel
det = c23;
verif = double(abs(det)) > delta;

if verif == true 
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
        if abs(X) < delta && abs(Y) < delta % 0*s5 + 0*c5 = ax -> indeterminado
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

% Acha qual sistema linear pode ser resolvido (det != 0)
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

% Verifica a coerencia das solucoes e elimina aquelas que sao
% inconsistentes com a fisica do robo
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


% Verifica qual solucao e a mais proxima (no sentido de distancia euclidiana)
thetaSolucao = all_q(1,:);
normMin = norm(all_q(1,:) - thetaAtual);
for i = 2:size(all_q, 1)  
    if norm(all_q(i,:) - thetaAtual) < normMin
        thetaSolucao = all_q(i,:);
        normMin = norm(all_q(i,:) - thetaAtual);
    end
end

end

