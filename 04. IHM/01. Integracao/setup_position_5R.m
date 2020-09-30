close all
clear
clc

%% Load data
load('linksdata.mat')

s_motor_2a = s_motor_60rpm;
s_motor_2b = s_motor_60rpm;
s_motor_3 = s_motor_60rpm;
s_motor_4 = s_motor_52rpm;

%% Setup data
Rx_neg = [1       0          0   0;
          0 cosd(-90) -sind(-90) 0;
          0 sind(-90)  cosd(-90) 0;
          0       0         0    1];

Rx_pos = [1       0        0   0;
          0 cosd(90) -sind(90) 0;
          0 sind(90)  cosd(90) 0;
          0       0         0  1];

Ry_neg = [cosd(-90) 0 -sind(-90) 0;
                0  1        0  0;
          sind(-90) 0  cosd(-90) 0;
                0  0        0  1];
            
Ry_pos = [cosd(90) 0 -sind(90) 0;
                0  1        0  0;
          sind(90) 0  cosd(90) 0;
                0  0        0  1];

Rz_neg = [cosd(-90) -sind(-90) 0 0;
          sind(-90)  cosd(-90) 0 0;
                 0          0  1 0;
                 0          0  0 1];
             
Rz_pos = [cosd(+90) -sind(+90) 0 0;
          sind(+90)  cosd(+90) 0 0;
                 0          0  1 0;
                 0          0  0 1];
              
% Rotação
s_BASE.V = (Rz_pos*Rx_pos*s_BASE.V')';
s_1M2A.V = (Rz_pos*Rx_pos*s_1M2A.V')';
s_1M1B.V = (Rz_pos*Rx_pos*s_1M1B.V')';
s_2M1D.V = (Rz_pos*Rx_pos*s_2M1D.V')';
s_motor_2a.V = (Rz_neg*s_motor_2a.V')';
s_motor_2b.V = (Rz_pos*s_motor_2b.V')';
s_2M2HA.V = (Ry_pos*Rz_neg*s_2M2HA.V')';
s_2M2MA.V = (Ry_pos*Rz_pos*s_2M2MA.V')';
s_3M1D.V = (Rx_neg*Rz_neg*s_3M1D.V')';
s_motor_3.V = (Rx_neg*Rz_neg*s_motor_3.V')';
s_3M2C.V = (Rz_neg*Rx_pos*s_3M2C.V')';
s_3M2CC.V = (Rz_neg*Rx_neg*s_3M2CC.V')';
s_4M1D.V = (Rx_pos*s_4M1D.V')';
s_motor_4.V = (Rz_neg*s_motor_4.V')';
s_4M2B.V = (Rx_pos*s_4M2B.V')';
s_4M2CB.V = (Ry_pos*Ry_pos*Rx_pos*s_4M2CB.V')';
s_garra.V = (Rx_neg*Rz_neg*s_garra.V')';

% Translação
s_BASE.V = s_BASE.V - [81, 81, 140+22.5+72+59, 0];
s_1M2A.V = s_1M2A.V - [81, 81, 140+22.5+72, 0];
s_1M1B.V = s_1M1B.V - [81, 81, 140+22.5, 0];
s_2M1D.V = s_2M1D.V - [80, 80, 140, 0];
s_motor_2a.V = s_motor_2a.V - [19, 29.5, 120.8, 0];
s_motor_2b.V = s_motor_2b.V - [-19, -29.5, 120.8, 0];
s_2M2HA.V = s_2M2HA.V  - [-78.52, -59.95, 0, 0];
s_2M2MA.V = s_2M2MA.V  - [-78.52, 59.95, 0, 0];
s_3M1D.V = s_3M1D.V  - [-76.373, 56.26, 70.11, 0];
s_motor_3.V = s_motor_3.V - [-89.5, 19, 0, 0];
s_3M2C.V = s_3M2C.V - [-47.5, -137, 0, 0];
s_3M2CC.V = s_3M2CC.V - [47.5, -137, 0, 0];
s_4M1D.V = s_4M1D.V - [50, -45.81, 95.8, 0]; 
s_motor_4.V = s_motor_4.V - [11, -16, 69.1, 0];
s_4M2B.V = s_4M2B.V - [35, -39.3, 0, 0];
s_4M2CB.V = s_4M2CB.V - [-35, -39.3, 0, 0];
s_garra.V = s_garra.V - [25.05, -0.6, 30, 0];

save('clean_linksdata.mat', 's_BASE', 's_1M2A', 's_1M1B', 's_2M1D', 's_2M2HA', 's_2M2MA', ...
     's_3M1D', 's_motor_2a', 's_motor_2b', 's_motor_3', 's_motor_4', 's_3M2C', 's_3M2CC', ...
     's_4M1D', 's_4M2B', 's_4M2CB', 's_garra')
