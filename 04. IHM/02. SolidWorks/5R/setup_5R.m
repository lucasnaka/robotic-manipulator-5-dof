close all
clear
clc

%% Load data
load('linksdata.mat')

%% Setup data
Rx = [1       0        0   0;
      0 cosd(90) -sind(90) 0;
      0 sind(90)  cosd(90) 0;
      0       0         0  1];

Ry = [cosd(90) 0 -sind(90) 0;
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

% Rotação 1: deixa as peças na orientação correta para montagem
s_1M2A.V = (Rx*s_1M2A.V')';
s_1M1B.V = (Rx*s_1M1B.V')';
s_2M1D.V = (Rx*s_2M1D.V')';
s_2M2HA.V = (s_2M2HA.V')';
s_2M2HA.V = (Rx*Rz_neg*s_2M2HA.V')';
s_2M2MA.V = (Rx*Rz_pos*s_2M2MA.V')';
s_3M1D.V = s_3M1D.V;

% Translação: posiciona as peças para encaixe 
s_1M2A.V = s_1M2A.V - [81, -81, 140+22.5+72, 0];
s_1M1B.V = s_1M1B.V - [81, -81, 140+22.5, 0];
s_2M1D.V = s_2M1D.V - [80, -80, 140, 0];
s_2M2HA.V = s_2M2HA.V  - [0, -79, -60, 0];
s_2M2MA.V = s_2M2MA.V  - [0, -79, 60, 0];
s_3M1D.V = s_3M1D.V  - [69.9, -76.85, 56.32, 0];

% Rotação 2: orienta robo ao longo do eixo X (p/ Th = [0,0,0,0,0])
s_1M2A.V = (Rz_neg*s_1M2A.V')';
s_1M1B.V = (Rz_neg*s_1M1B.V')';
s_2M1D.V = (Rz_neg*s_2M1D.V')';
s_2M2HA.V = (Rz_neg*s_2M2HA.V')';
s_2M2MA.V = (Rz_neg*s_2M2MA.V')';
s_3M1D.V = (Rz_neg*s_3M1D.V')';

%% Plot Theta = [0, 0, 0, 0, 0]

dim = get(0,'ScreenSize');
fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-100],...
                'Name','5R',...
                'NumberTitle','off');
hold on
light
daspect([1 1 1])
view(45,25)
xlim([-300,300]),ylim([-300,300]),zlim([-250,400]);
xlabel('X'),ylabel('Y'),zlabel('Z')
grid on

p0 = patch('faces', s_1M2A.F, 'vertices', s_1M2A.V(:,1:3));
set(p0, 'facec', [0.717,0.116,0.123]);
set(p0, 'EdgeColor','none');

p1 = patch('faces', s_1M1B.F, 'vertices', s_1M1B.V(:,1:3));
set(p1, 'facec', [0.216,1,.583]);
set(p1, 'EdgeColor','none');

p2 = patch('faces', s_2M1D.F, 'vertices', s_2M1D.V(:,1:3));
set(p2, 'facec', [0.306,0.733,1]);
set(p2, 'EdgeColor','none');

p3 = patch('faces', s_2M2HA.F, 'vertices', s_2M2HA.V(:,1:3));
set(p3, 'facec', [1,0.542,0.493]);
set(p3, 'EdgeColor','none');

p4 = patch('faces', s_2M2MA.F, 'vertices', s_2M2MA.V(:,1:3));
set(p4, 'facec', [0.717,0.116,0.123]);
set(p4, 'EdgeColor','none');

p5 = patch('faces', s_3M1D.F, 'vertices', s_3M1D.V(:,1:3));
set(p5, 'facec', [0.216,1,.583]);
set(p5, 'EdgeColor','none');



%% Plot Theta = [t1, t2, t3, t4, t5]

t1 = 0;
t2 = 45;

T_01 = tmat(0, 0, 0, t1);
T_12 = tmat(90, 0, 0, t2);

T_02 = T_01*T_12;

s_1M2A.V = s_1M2A.V;
s_1M1B.V = s_1M1B.V;
s_2M1D.V = (T_01*s_2M1D.V')';
s_2M2HA.V = (T_02*s_2M2HA.V')';
s_2M2MA.V = (T_02*s_2M2MA.V')';
s_3M1D.V = (T_02*s_3M1D.V')';


dim = get(0,'ScreenSize');
fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-100],...
                'Name','5R',...
                'NumberTitle','off');
hold on
light
daspect([1 1 1])
view(45,25)
xlim([-300,300]),ylim([-300,300]),zlim([-250,400]);
xlabel('X'),ylabel('Y'),zlabel('Z')
grid on

p0 = patch('faces', s_1M2A.F, 'vertices', s_1M2A.V(:,1:3));
set(p0, 'facec', [0.717,0.116,0.123]);
set(p0, 'EdgeColor','none');

p1 = patch('faces', s_1M1B.F, 'vertices', s_1M1B.V(:,1:3));
set(p1, 'facec', [0.216,1,.583]);
set(p1, 'EdgeColor','none');

p2 = patch('faces', s_2M1D.F, 'vertices', s_2M1D.V(:,1:3));
set(p2, 'facec', [0.306,0.733,1]);
set(p2, 'EdgeColor','none');

p3 = patch('faces', s_2M2HA.F, 'vertices', s_2M2HA.V(:,1:3));
set(p3, 'facec', [1,0.542,0.493]);
set(p3, 'EdgeColor','none');

p4 = patch('faces', s_2M2MA.F, 'vertices', s_2M2MA.V(:,1:3));
set(p4, 'facec', [0.717,0.116,0.123]);
set(p4, 'EdgeColor','none');

p5 = patch('faces', s_3M1D.F, 'vertices', s_3M1D.V(:,1:3));
set(p5, 'facec', [0.216,1,.583]);
set(p5, 'EdgeColor','none');



function T = tmat(alpha, a, d, theta)
    % tmat(alpha, a, d, theta) (T-Matrix used in Robotics)
    % The homogeneous transformation called the "T-MATRIX"
    % as used in the Kinematic Equations for robotic type
    % systems (or equivalent).
    %
    % This is equation 3.6 in Craig's "Introduction to Robotics."
    % alpha, a, d, theta are the Denavit-Hartenberg parameters.
    %
    % (NOTE: ALL ANGLES MUST BE IN DEGREES.)
    %
    alpha = alpha*pi/180;    %Note: alpha is in radians.
    theta = theta*pi/180;    %Note: theta is in radians.
    c = cos(theta);
    s = sin(theta);
    ca = cos(alpha);
    sa = sin(alpha);
    T = [c -s 0 a; s*ca c*ca -sa -sa*d; s*sa c*sa ca ca*d; 0 0 0 1];
end