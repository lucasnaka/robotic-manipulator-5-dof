function [link0,link1,link2,link3] = plotRobot3D()
    addpath(strcat(fileparts(pwd),'\02. SolidWorks\RRR'))
    load('linksdata.mat')

    link0 = s0;
    link1 = s1;
    link2 = s2;
    link3 = s3;
    
%     t1 = 0;
%     t2 = 30;
%     t3 = 0;
% 
%     L1 = 0;
%     L2 = 0;
% 
%     T_01 = Tmatrix(0, 0, 0, t1);
%     T_12 = Tmatrix(0, L1, 0, t2);
%     T_23 = Tmatrix(0, L2, 0, t3);
% 
%     T_02 = T_01*T_12;
%     T_03 = T_02*T_23;
% 
%     Link1 = (T_01*s1.V')';
%     Link2 = (T_02*s2.V')';
%     Link3 = (T_03*s3.V')';
% 
% 
%     dim = get(0,'ScreenSize');
%     fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-100],...
%                     'Name',' Hook Graphical Demo',...
%                     'NumberTitle','off');
%     hold on
%     light
%     daspect([1 1 1])
%     view(135,25)
%     xlabel('X'),ylabel('Y'),zlabel('Z')
%     grid on
% 
%     p0 = patch('faces', s0.F, 'vertices', s0.V(:,1:3));
%     set(p0, 'facec', [0.717,0.116,0.123]);
%     set(p0, 'EdgeColor','none');
%     p1 = patch('faces', s1.F, 'vertices', Link1(:,1:3));
%     set(p1, 'facec', [0.216,1,.583]);
%     set(p1, 'EdgeColor','none');
%     p2 = patch('faces', s2.F, 'vertices', Link2(:,1:3));
%     set(p2, 'facec', [0.306,0.733,1]);
%     set(p2, 'EdgeColor','none');
%     p3 = patch('faces', s3.F, 'vertices', Link3(:,1:3));
%     set(p3, 'facec', [1,0.542,0.493]);
%     set(p3, 'EdgeColor','none');
    
end

