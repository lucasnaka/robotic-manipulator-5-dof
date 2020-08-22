clear 
clc

%% Solucao segundo os slides da Sapienza (a partir do slide 21)
% Input : x, y, z (posicao da origem de {4} relativa a {0})
% Output: t1_sol, t2_sol, t3_sol (possiveis solucoes) para t1, t2 e t3

% Valores numericos 
L1_val = 50;
L2_val = 50;
L3_val = 50;
L4_val = 20;

x = 0; 
y = 0;
z = 170;

c3 =  (x^2+y^2+(z-(L1_val+L2_val))^2 - L3_val^2 - L4_val^2) / (2*L3_val*L4_val);
s3 = sqrt(1-c3^2);
t3_sol = [atan2(s3,c3), atan2(-s3,c3)]

t1_sol = [atan2(y,x), atan2(-y,-x)]
c1 = cos(t1_sol(1));
c11 = cos(t1_sol(2));
s1 = sin(t1_sol(1));
s11 = sin(t1_sol(1));

A1 = [L2_val+L3_val*c3, -L3_val*s3; L3_val*s3, L2_val + L3_val*c3]; 
b1 = [c1*x + s1*y; z - (L1_val+L2_val)];
q21 = A1\b1;

A2 = [L2_val+L3_val*c3, -L3_val*s3; L3_val*s3, L2_val + L3_val*c3]; 
b2 = [c11*x + s11*y; z - (L1_val+L2_val)];
q22 = A2\b2;

A3 = [L2_val+L3_val*c3, L3_val*s3; -L3_val*s3, L2_val + L3_val*c3]; 
b3 = [c1*x + s1*y; z - (L1_val+L2_val)];
q23 = A3\b3;

A4 = [L2_val+L3_val*c3, L3_val*s3; -L3_val*s3, L2_val + L3_val*c3]; 
b4 = [c11*x + s11*y; z - (L1_val+L2_val)];
q24 = A4\b4;

t2_sol = [atan2(q21(2),q21(1)), atan2(q22(2),q22(1)), atan2(q23(2),q23(1)), atan2(q24(2),q24(1))]
