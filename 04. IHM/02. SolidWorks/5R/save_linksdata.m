close all
clear
clc

filenames = ["1M2A_NOVO_ROBO.STL", "1M1B_NOVO_ROBO.STL", "2M1D_NOVO_ROBO.STL", "2M2HA_NOVOROBO.STL", "2M2MA_NOVOROBO.STL", "3M1D_NOVOROBO_60RPM.STL"];

s_1M2A = cad2struct(filenames(1));
s_1M1B = cad2struct(filenames(2));
s_2M1D = cad2struct(filenames(3));
s_2M2HA = cad2struct(filenames(4));
s_2M2MA = cad2struct(filenames(5));
s_3M1D = cad2struct(filenames(6));

save('linksdata.mat', 's_1M2A', 's_1M1B', 's_2M1D', 's_2M2HA', 's_2M2MA', 's_3M1D')