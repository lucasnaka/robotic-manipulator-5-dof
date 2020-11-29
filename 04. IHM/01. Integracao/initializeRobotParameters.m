function initializeRobotParameters()
    clear all
    close all
    K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
%     K = 48.69;
    Jeff = 0.5;
    Beff = 50;
    %T = Jeff/Beff;
    r = 1./[231.22*4 139.138 139.138 231.22 231.22]; % Relacoes de engrenagem
    %r = 1./[231.22*4 139.138 139.138]; % Relacoes de engrenagem

    xi = 1;
    wn = 15; % chute // fazer o bode para tirar o wn
    Kd = (2*xi*wn*Jeff - Beff)/K;
    Kp = (wn^2*Jeff)/K;
    N = 3;

    Td = Kd/Kp;
    Ts = 1/100;
    
    % Non linearity parameters
    phi = 43.47;
    
    assignin('base', "K", K);
    assignin('base', "r", r);
    assignin('base', "Kd", Kd);
    assignin('base', "Kp", Kp);
    assignin('base', "N", N);
    assignin('base', "Td", Td);
    assignin('base', "Ts", Ts);
    assignin('base', "Jeff", Jeff);
    assignin('base', "Beff", Beff);
    assignin('base', "phi", phi);
end

