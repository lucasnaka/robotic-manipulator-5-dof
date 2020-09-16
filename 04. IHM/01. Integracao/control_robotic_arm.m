function [th_realizado, th_desejado] = control_robotic_arm()
    % sim('ControlePD_ind')
    sim('ControleFF_trajetoria_D_integrado_RRR')
    
    th_realizado = Thr.signals.values;
    th_desejado = Thd_path.signals.values;
    
end

