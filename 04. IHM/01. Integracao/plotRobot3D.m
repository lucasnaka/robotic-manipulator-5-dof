function [s0, s1, s2, s3, link0,link1,link2,link3] = plotRobot3D(t1, t2, t3)
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

    T_01 = Tmatrix(0, 0, 0, t1);
    T_12 = Tmatrix(0, L1, 0, t2);
    T_23 = Tmatrix(0, L2, 0, t3);

    T_02 = T_01*T_12;
    T_03 = T_02*T_23;

    link0 = s0;
    link1 = (T_01*s1.V')';
    link2 = (T_02*s2.V')';
    link3 = (T_03*s3.V')';
            
end

