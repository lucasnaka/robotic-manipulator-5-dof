%% Cálculo da cinemática inversa pela solução de Pieper (Craig 3rd edition pág 114)

close all
clear 

syms a1 a2 a3 a4 alpha1 alpha2 alpha3 alpha4 d1 d2 d3 d4 t1 t2 t3 L1 L2 L3 L4

f1 = a3*cos(t3) + d4*sin(alpha3)*sin(t3) + a2;
f2 = a3*cos(alpha2)*sin(t3) - d4*sin(alpha3)*cos(alpha2)*cos(t3) - d4*sin(alpha2)*cos(alpha3) - d3*sin(alpha2);
f3 = a3*sin(alpha2)*sin(t3) - d4*sin(alpha3)*sin(alpha2)*cos(t3) + d4*cos(alpha2)*cos(alpha3) + d3*cos(alpha2);

g1 = simplify(cos(t2)*f1 - sin(t2)*f2 + a1);
g2 = simplify(sin(t2)*cos(alpha1)*f1 + cos(t2)*cos(alpha1)*f2 - sin(alpha1)*f3 - d2*sin(alpha1));
g3 = simplify(sin(t2)*sin(alpha1)*f1 + cos(t2)*sin(alpha1)*f2 + cos(alpha1)*f3 + d2*cos(alpha1) + d1);

% r = simplify(g1^2 + g2^2 + g3^2); % acho que não vamos usar esse, ele é redefinido abaixo

k1 = simplify(f1);
k2 = simplify(-f2);
k3 = simplify(f1^2 + f2^2 + f3^2 + a1^2 + d2^2 + 2*d2*f3);
k4 = simplify(f3*cos(alpha1) + d2*cos(alpha1));

r = simplify((k1*cos(t2) + k2*sin(t2))*2*a1 + k3);
z = simplify((k1*sin(t2) - k2*cos(t2))*sin(alpha1) + k4);

%% Aplicacao no robo de tres juntas

alpha1_robo = pi/2;
a1_robo = 0;
d1_robo = L1+L2;

alpha2_robo = 0;
a2_robo = L3;
d2_robo = 0;

alpha3_robo = 0;
a3_robo = L4;
d3_robo = 0;

d4_robo = 0;

r_robo = subs(r, {alpha1, a1, d1, alpha2, a2, d2, alpha3, a3, d3, d4}, {alpha1_robo, a1_robo, d1_robo, alpha2_robo, a2_robo, d2_robo, alpha3_robo, a3_robo, d3_robo, d4_robo});
z_robo = subs(z, {alpha1, a1, d1, alpha2, a2, d2, alpha3, a3, d3, d4}, {alpha1_robo, a1_robo, d1_robo, alpha2_robo, a2_robo, d2_robo, alpha3_robo, a3_robo, d3_robo, d4_robo});
g1_robo = subs(g1, {alpha1, a1, d1, alpha2, a2, d2, alpha3, a3, d3, d4}, {alpha1_robo, a1_robo, d1_robo, alpha2_robo, a2_robo, d2_robo, alpha3_robo, a3_robo, d3_robo, d4_robo});
g2_robo = subs(g2, {alpha1, a1, d1, alpha2, a2, d2, alpha3, a3, d3, d4}, {alpha1_robo, a1_robo, d1_robo, alpha2_robo, a2_robo, d2_robo, alpha3_robo, a3_robo, d3_robo, d4_robo});


%% Solução algébrica por redução polinomial

syms x y z u
% (Craig 4.35)
cos_theta = (1 - u^2)/(1 + u^2);
sin_theta = 2*u/(1 + u^2);

r_robo_u = subs(r_robo, {sin(t3), cos(t3)}, {sin_theta, cos_theta});       % Lembrete: a1 = 0 -> r = k3
eq_u_solution = x^2 + y^2 + z^2 == r_robo_u;                               % r = x^2 + y^2 + z^2
u_solutions = solve(eq_u_solution, u);

t3_solutions = atan(u_solutions)*2;                                        % u = tan(theta/2) -> theta = atan(u)*2

% (Craig 4.50)
z_robo_u = subs(z_robo, {sin(t2), cos(t2), t3}, {sin_theta, cos_theta, t3_solutions});
eq_t2_solution = z == z_robo_u;
t2_solutions_1 = solve(eq_t2_solution(1), u);
t2_solutions_2 = solve(eq_t2_solution(2), u);

% (Craig 4.46)
x_robo_u_1 = subs(cos(t1)*g1_robo - sin(t1)*g2_robo, {cos(t1), sin(t1), t2, t3}, {cos_theta, sin_theta, t2_solutions_1, t3_solutions(1)});
x_robo_u_2 = subs(cos(t1)*g1_robo - sin(t1)*g2_robo, {cos(t1), sin(t1), t2, t3}, {cos_theta, sin_theta, t2_solutions_2, t3_solutions(2)});
eq_t1_solutions_1_2 = x == x_robo_u_1;
eq_t1_solutions_3_4 = x == x_robo_u_2;
t1_solutions_1_2 = solve(eq_t1_solutions_1_2(1), u);
t1_solutions_3_4 = solve(eq_t1_solutions_1_2(2), u);
t1_solutions_5_6 = solve(eq_t1_solutions_3_4(1), u);
t1_solutions_7_8 = solve(eq_t1_solutions_3_4(2), u);

% Soluções:
% t3_solutions(1); t2_solutions_1(1); t1_solutions_1_2(1)
% t3_solutions(1); t2_solutions_1(1); t1_solutions_1_2(2)
% t3_solutions(1); t2_solutions_1(2); t1_solutions_3_4(1)
% t3_solutions(1); t2_solutions_1(2); t1_solutions_3_4(2)
% t3_solutions(2); t2_solutions_2(1); t1_solutions_5_6(1)
% t3_solutions(2); t2_solutions_2(1); t1_solutions_5_6(2)
% t3_solutions(2); t2_solutions_2(2); t1_solutions_7_8(1)
% t3_solutions(2); t2_solutions_2(2); t1_solutions_7_8(2)