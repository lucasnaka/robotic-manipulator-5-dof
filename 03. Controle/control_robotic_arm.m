function [th_realizado, th_desejado, dth_realizado, dth_desejado, ddth_realizado, ddth_desejado, ...
          esforco_controle, theta_erro, G, V, tal_res, tal_motor, tout] = control_robotic_arm(T, trajectory)
    
      addpath(strcat(fileparts(fileparts(pwd)),'\03. Controle'))
      
    % Check if Simulink model is open
%     if slreportgen.utils.isModelLoaded('ControleFF_trajetoria_D_integrado')
%         open_system('ControleFF_trajetoria_D_integrado')
%     end
    
%     set_param('ControleFF_trajetoria_D_integrado','StartTime','0','StopTime',num2str(T))
%     sim('ControleFF_trajetoria_D_integrado')
    
    set_param('ControleFF_D_NL','StartTime','0','StopTime',num2str(T))
    set_param('ControleFF_D_NL/Dinâmica do robô/Int_Thr', 'InitialCondition', mat2str(pi/180*[trajectory(1,1), trajectory(2,1), trajectory(3,1), trajectory(4,1), trajectory(5,1)]));
    sim('ControleFF_D_NL')
    
    th_realizado = Thr.signals.values;
    th_desejado = Thd_path.signals.values;
    dth_realizado = dThr.signals.values;
    dth_desejado = dThd_path.signals.values;
    ddth_realizado = ddThr.signals.values;
    ddth_desejado = ddThd_path.signals.values;
    esforco_controle = Vcontrole.signals.values;
    theta_erro = erro.signals.values;
    G = G.signals.values;
    V = V.signals.values;
    tal_res = tal_res.signals.values;
    tal_motor = tal_motor.signals.values;
    tout = tout;
    
end

