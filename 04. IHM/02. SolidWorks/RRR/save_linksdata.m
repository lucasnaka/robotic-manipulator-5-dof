close all
clear
clc

filenames = ["montage - Base-1.STL", "montage - Part2-1.STL", "montage - Part3-2.STL", "montage - Part4-1.STL"];

s0 = cad2struct(filenames(1));
s1 = cad2struct(filenames(2));
s2 = cad2struct(filenames(3));
s3 = cad2struct(filenames(4));

save('linksdata.mat', 's0', 's1', 's2', 's3')