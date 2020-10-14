function [Theta] = cinematica_inversa(px, py, pz, alpha, beta, Theta_atual, L)

%   - (px, py, pz) = posição da origem dos sistemas 4 e 5
%   -     alpha    = rotação da garra em relação ao eixo Z5
%   -     beta     = rotação da garra em relação ao eixo Z4

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

% theta4
theta4 = repmat(beta,1,4);

% theta5
theta5 = [];
for i = 1:4
    if theta1(i) < pi/2 && theta1(i) > -pi/2
        theta5 = [theta5, alpha];
    else
        theta5 = [theta5, -alpha];
    end
end

% Escolha da solução a partir da posição atual - minimização energética
Theta = [theta1(1), theta2(1), theta3(1), theta4(1), theta5(1)];
dist_min = norm(Theta - Theta_atual);

for i = 2:4
    Theta_iter = [theta1(i), theta2(i), theta3(i), theta4(i), theta5(i)];
    dist = norm(Theta_iter - Theta_atual);
    
    if dist < dist_min
        Theta = Theta_iter;
        dist_min = dist;
    end
end

end

