close all
clear
clc

filenames = ["montage - Base-1.STL", "montage - Part2-1.STL", "montage - Part3-2.STL", "montage - Part4-1.STL"];

s0 = cad2struct(filenames(1));
s1 = cad2struct(filenames(2));
s2 = cad2struct(filenames(3));
s3 = cad2struct(filenames(4));

save('linksdata.mat', 's0', 's1', 's2', 's3')

% for i = 1:length(filenames)
%     filename = filenames(i);
%     
%     cad2mat(strcat(char(filename),'.STL'))
%     load(strcat(char(filename),'.mat'))
% 
%     dim = get(0,'ScreenSize');
%     fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-100],...
%                 'Name',' Hook Graphical Demo',...
%                 'NumberTitle','off');
% 
%     hold on
% 
%     light
%     daspect([1 1 1])
%     view(135,25)
%     xlabel('X'),ylabel('Y'),zlabel('Z')
%     grid on
% 
%     p1 = patch('faces', s.F, 'vertices', s.V);
%     set(p1, 'facec', [0.717,0.116,0.123]);
% end

