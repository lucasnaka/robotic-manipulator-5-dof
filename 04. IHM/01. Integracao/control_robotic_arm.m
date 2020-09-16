function [th_realizado, th_desejado] = control_robotic_arm(T)
    % sim('ControlePD_ind')
    set_param('ControleFF_trajetoria_D_integrado_RRR','StartTime','0','StopTime',num2str(T))
    sim('ControleFF_trajetoria_D_integrado_RRR')
    
    th_realizado = Thr.signals.values;
    th_desejado = Thd_path.signals.values;
    
end

