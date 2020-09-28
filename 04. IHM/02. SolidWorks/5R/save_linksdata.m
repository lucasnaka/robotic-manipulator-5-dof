close all
clear
clc

s_1M2A = cad2struct("./STLs/1M2A_NOVO_ROBO.STL");
s_1M1B = cad2struct("./STLs/1M1B_NOVO_ROBO.STL");
s_2M1D = cad2struct("./STLs/2M1D_NOVO_ROBO.STL");
s_2M2HA = cad2struct("./STLs/2M2HA_NOVOROBO.STL");
s_2M2MA = cad2struct("./STLs/2M2MA_NOVOROBO.STL");
s_3M1D = cad2struct("./STLs/3M1D_NOVOROBO_60RPM.STL");
s_motor_60rpm = cad2struct("./STLs/motor 60rpm.STL");
s_BASE = cad2struct("./STLs/BASE_NOVO_ROBO.STL");
s_3M2C = cad2struct("./STLs/3M2C_ROBO_NOVO.STL");
s_3M2CC = cad2struct("./STLs/3M2CC_ROBO_NOVO.STL");
s_4M1D = cad2struct("./STLs/4M1D_ROBO_NOVO.STL");
s_4M2B = cad2struct("./STLs/4M2B.STL");
s_4M2CB = cad2struct("./STLs/4M2CB_NOVO_ROBO.STL");
s_garra = cad2struct("./STLs/GARRA ROBO_NOVO_FABIO_LEVE.STL");
s_motor_52rpm = cad2struct("./STLs/motor 52rpm.STL");

save('linksdata.mat', 's_1M2A', 's_1M1B', 's_2M1D', 's_2M2HA', 's_2M2MA', ...
     's_3M1D', 's_motor_60rpm', 's_BASE', 's_3M2C', 's_3M2CC', 's_4M1D', ...
     's_4M2B', 's_4M2CB', 's_garra', 's_motor_52rpm')