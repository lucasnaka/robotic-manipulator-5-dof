function [ cc ] = cubcoef( th0, thdot0, thf, thdotf, T )
%CUBCOEF 
%   Retorna um vetor de coeficientes do polinomio cubico
%   (ordem dos termos (potencias crescentes) contraria aquela usada pelo 
%    MATLAB para representar polinomios)

    a0 = th0;
    a1 = thdot0;
    a2 = 3/T^2*(thf - th0) - 2/T*thdot0 - 1/T*thdotf;
    a3 = -2/T^3*(thf - th0) + 1/T^2*(thdotf + thdot0);
    
    cc = [a0, a1, a2, a3];
    
end

