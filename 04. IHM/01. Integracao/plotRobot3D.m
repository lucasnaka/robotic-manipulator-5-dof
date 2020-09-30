function [links, ...
          x_realizado, y_realizado, z_realizado, ...
          x_desejado, y_desejado, z_desejado] = plotRobot3D(links, th1_realizado, th2_realizado, th3_realizado, ...
                                                            th4_realizado, th5_realizado, ...
                                                            th1_desejado, th2_desejado, th3_desejado, ...
                                                            th4_desejado, th5_desejado, ...
                                                            x_realizado, y_realizado, z_realizado, ...
                                                            x_desejado, y_desejado, z_desejado, robot_arm)    
    
    if robot_arm == "RRR"
        addpath(strcat(fileparts(pwd),'\02. SolidWorks\RRR'))
        load('linksdata.mat')
        
        s0.V = s0.V - [0 110 0 0];
        s1.V = s1.V - [0 110 0 0];
        s2.V = s2.V - [0 710 0 0];
        s3.V = s3.V - [0 1310 0 0];

        R = [cosd(-90) -sind(-90) 0 0;
             sind(-90)  cosd(-90) 0 0;
             0                  0 1 0;
             0 0 0 1];

        s1.V = (R*s1.V')';
        s2.V = (R*s2.V')';
        s3.V = (R*s3.V')';

        L0 = 110;
        L1 = 600;
        L2 = 600;
    elseif robot_arm == "5R"
%         addpath(strcat(fileparts(pwd),'\02. SolidWorks\5R'))
%         load('clean_linksdata.mat')
        
        L2 = 221.6;
        L3 = 232.8;
        T_01 = Tmatrix(0, 0, 0, th1_realizado);
        T_12 = Tmatrix(90, 0, 0, th2_realizado);
        T_23 = Tmatrix(0, L2, 0, th3_realizado-90);
        T_34 = Tmatrix(270, 0, L3, th4_realizado);
        T_45 = Tmatrix(90, 0, 0, th5_realizado);

        T_02 = T_01*T_12;
        T_03 = T_02*T_23;
        T_04 = T_03*T_34;
        T_05 = T_04*T_45;

%         s_BASE = links.s_BASE; % To put it in workspace and return in function
%         s_1M2A = links.s_1M2A; % To put it in workspace and return in function
        
        % Aplicação da matriz T_01
        links.s_1M1B.V = (T_01*links.s_1M1B.V')';
        links.s_2M1D.V = (T_01*links.s_2M1D.V')';
        links.s_motor_2a.V = (T_01*links.s_motor_2a.V')';
        links.s_motor_2b.V = (T_01*links.s_motor_2b.V')';

        % Aplicação da matriz T_02
        links.s_2M2HA.V = (T_02*links.s_2M2HA.V')';
        links.s_2M2MA.V = (T_02*links.s_2M2MA.V')';
        links.s_3M1D.V = (T_02*links.s_3M1D.V')';
        links.s_motor_3.V = (T_02*links.s_motor_3.V')';

        % Aplicação da matriz T_03
        links.s_3M2C.V = (T_03*links.s_3M2C.V')';
        links.s_3M2CC.V = (T_03*links.s_3M2CC.V')';

        % Aplicação da matriz T_04
        links.s_4M1D.V = (T_04*links.s_4M1D.V')';
        links.s_motor_4.V = (T_04*links.s_motor_4.V')';

        % Aplicação da matriz T_05
        links.s_4M2B.V = (T_05*links.s_4M2B.V')';
        links.s_4M2CB.V = (T_05*links.s_4M2CB.V')';
        links.s_garra.V = (T_05*links.s_garra.V')';
        
        x_realizado = [x_realizado T_05(1,4)];
        y_realizado = [y_realizado T_05(2,4)];
        z_realizado = [z_realizado T_05(3,4)];
        
        % Desejado
        T_01_d = Tmatrix(0, 0, 0, th1_desejado);
        T_12_d = Tmatrix(90, 0, 0, th2_desejado);
        T_23_d = Tmatrix(0, L2, 0, th3_desejado-90);
        T_34_d = Tmatrix(270, 0, L3, th4_desejado);
        T_45_d = Tmatrix(90, 0, 0, th5_desejado);

        T_02_d = T_01_d*T_12_d;
        T_03_d = T_02_d*T_23_d;
        T_04_d = T_03_d*T_34_d;
        T_05_d = T_04_d*T_45_d;

        x_desejado = [x_desejado T_05_d(1,4)];
        y_desejado = [y_desejado T_05_d(2,4)];
        z_desejado = [z_desejado T_05_d(3,4)]; 
    end                
end

