function [ t, th, dth, ddth ] = geraTrajetoria(traj_points, T, rate)
%GERATRAJETORIA funcao para geracao de trajetorias usando polinomios
%cubicos
% 
% Input: traj_points: pontos de trajetoria no espaco de juntas (uma junta) 
%             T     : intervalo temporal entre cada ponto
%           rate    : taxa de atualizacao dos pontos da trajetoria      
%
% Output:     t     : vetor de instantes temporais
%         trajetoria para a junta em questao (th  : posicao 
%                                             dth : velocidade 
%                                             ddth: aceleracao)

% Vectors of cubic coefficients (one segment per line)
cctot = trajectoryplanning(traj_points, T);

t_eval = rate:rate:T;

if size(cctot, 1) == 0   
    cc = cubcoef(traj_points(1), 0, traj_points(2), 0, T);
    a0 = cc(1);
    a1 = cc(2);
    a2 = cc(3);
    a3 = cc(4);
    
    th = a0 + a1*t_eval + a2*t_eval.^2 + a3*t_eval.^3;
    dth = a1 + 2*a2*t_eval + 3*a3*t_eval.^2;
    ddth = 2*a2 + 6*a3*t_eval;
    
    t = t_eval;
else
    t = [0];
    th = [traj_points(1)];
    dth = [0];
    ddth = [0];

    for k = 1:size(cctot, 1)
        a0 = cctot(k,1);
        a1 = cctot(k,2);
        a2 = cctot(k,3);
        a3 = cctot(k,4);

        tk = (k-1)*T+rate:rate:k*T;
        t = [t, tk];

        th = [th, a0 + a1*t_eval + a2*t_eval.^2 + a3*t_eval.^3];
        dth = [dth, a1 + 2*a2*t_eval + 3*a3*t_eval.^2];
        ddth = [ddth, 2*a2 + 6*a3*t_eval];
    end
end

end

