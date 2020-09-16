function [Th_realizado, Th_desejado] = plot_angular_positions_RRR(SP_theta, Theta_final)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here

    %%
    %=========================================================================%
    %                       Geracao de Trajetoria                             %
    %=========================================================================%
    T = 40;

    assignin('base', 'SP_theta', SP_theta);
    
    traj_th1 = [SP_theta(1), Theta_final(1)];
    traj_th2 = [SP_theta(2), Theta_final(2)];
    traj_th3 = [SP_theta(3), Theta_final(3)];

    simulation_time = ((length(traj_th1)-1)*T);
    rate = 1/1000;

    [t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
    [t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
    [t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);

    th_path = [t1' th1_path' th2_path' th3_path'];
    dth_path = [t1' dth1_path' dth2_path' dth3_path'];
    ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path'];
    
    assignin('base', "th_path", th_path);
    assignin('base', "dth_path", dth_path);
    assignin('base', "ddth_path", ddth_path);

    %%
    %=========================================================================%
    %                               Controle                                  %
    %=========================================================================%
    K = (90/12)*(2*pi/60); % Motor de 90 rpm para 12 V
    Jeff = 0.5;
    Beff = 50;
    T = Jeff/Beff;
    r = 1./[231.22*4 139.138 139.138]; % Relacoes de engrenagem

    xi = 1;
    wn = 15; % chute // fazer o bode para tirar o wn
    Kd = (2*xi*wn*Jeff - Beff)/K;
    Kp = (wn^2*Jeff)/K;
    N = 3;

    Td = Kd/Kp;
    Ts = 1/100;

    sim('ControleFF_trajetoria_D_integrado_RRR', simulation_time)

    %% 
    %=========================================================================%
    %                                Plots                                    %
    %=========================================================================%
%     figure;
%     subplot(5,1,1)
%     plot_angular_position_ff(Thr.signals.values(:,1), Thd_path.signals.values(:,1), Thr.time, 1, 'b')

    Th_realizado = Thr.signals.values;
    Th_desejado = Thd_path.signals.values;
end

