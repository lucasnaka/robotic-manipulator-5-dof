function [s0, s1, s2, s3, ...
          link0, link1, link2, link3, ...
          x_realizado, y_realizado, z_realizado, ...
          x_desejado, y_desejado, z_desejado] = plotRobot3D(th1_realizado, th2_realizado, th3_realizado, ...
                                                            th1_desejado, th2_desejado, th3_desejado, ...
                                                            x_realizado, y_realizado, z_realizado, ...
                                                            x_desejado, y_desejado, z_desejado)
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

    % Realizado
    T01 = Tmatrix(0, 0, 0, th1_realizado);
    T12 = Tmatrix(0, L1, 0, th2_realizado);
    T23 = Tmatrix(0, L2, 0, th3_realizado);

    T02 = T01*T12;
    T03 = T02*T23;
    
    link0 = s0;
    link1 = (T01*s1.V')';
    link2 = (T02*s2.V')';
    link3 = (T03*s3.V')';
            
    x_realizado = [x_realizado T03(1,4)];
    y_realizado = [y_realizado T03(2,4)];
    z_realizado = [z_realizado T03(3,4)+253.6];

    % Desejado
    T01_d = Tmatrix(0, 0, 0, th1_desejado);
    T12_d = Tmatrix(0, L1, 0, th2_desejado);
    T23_d = Tmatrix(0, L2, 0, th3_desejado);

    T02_d = T01_d*T12_d;
    T03_d = T02_d*T23_d;
    
    x_desejado = [x_desejado T03_d(1,4)];
    y_desejado = [y_desejado T03_d(2,4)];
    z_desejado = [z_desejado T03_d(3,4)+253.6];    
                
end

