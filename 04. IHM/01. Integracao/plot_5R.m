close all
clear
clc

%% Load data
load('clean_linksdata.mat')

%% Plot Theta = [t1, t2, t3, t4, t5]

t1 = 45;
t2 = 90;
t3 = 90;
t4 = 0;
t5 = 0;

L2 = 221.6;
L3 = 232.8;
T_01 = tmat(0, 0, 0, t1);
T_12 = tmat(90, 0, 0, t2);
T_23 = tmat(0, L2, 0, t3-90);
T_34 = tmat(270, 0, L3, t4);
T_45 = tmat(90, 0, 0, t5);

T_02 = T_01*T_12;
T_03 = T_02*T_23;
T_04 = T_03*T_34;
T_05 = T_04*T_45;

% Aplicação da matriz T_01
s_1M1B.V = (T_01*s_1M1B.V')';
s_2M1D.V = (T_01*s_2M1D.V')';
s_motor_2a.V = (T_01*s_motor_2a.V')';
s_motor_2b.V = (T_01*s_motor_2b.V')';

% Aplicação da matriz T_02
s_2M2HA.V = (T_02*s_2M2HA.V')';
s_2M2MA.V = (T_02*s_2M2MA.V')';
s_3M1D.V = (T_02*s_3M1D.V')';
s_motor_3.V = (T_02*s_motor_3.V')';

% Aplicação da matriz T_03
s_3M2C.V = (T_03*s_3M2C.V')';
s_3M2CC.V = (T_03*s_3M2CC.V')';

% Aplicação da matriz T_04
s_4M1D.V = (T_04*s_4M1D.V')';
s_motor_4.V = (T_04*s_motor_4.V')';

% Aplicação da matriz T_05
s_4M2B.V = (T_05*s_4M2B.V')';
s_4M2CB.V = (T_05*s_4M2CB.V')';
s_garra.V = (T_05*s_garra.V')';

%% 
dim = get(0,'ScreenSize');
fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-250,dim(4)-150],...
                'Name','5R',...
                'NumberTitle','off');
hold on
light
daspect([1 1 1])
view(45,25)
xlim([-650,650]),ylim([-500,500]),zlim([-300,500]);
xlabel('X'),ylabel('Y'),zlabel('Z')
grid on  


p_base = patch('faces', s_BASE.F, 'vertices', s_BASE.V(:,1:3));
% set(p_base, 'facec', [0.18,0.43,0.285]);
set(p_base, 'facec', [4, 64, 29]./255);
set(p_base, 'EdgeColor','none');

p_1M2A = patch('faces', s_1M2A.F, 'vertices', s_1M2A.V(:,1:3));
% set(p_1M2A, 'facec', [0.717,0.116,0.123]);
set(p_1M2A, 'facec', [9, 165, 77]./255);
set(p_1M2A, 'EdgeColor','none');

p_1M1B = patch('faces', s_1M1B.F, 'vertices', s_1M1B.V(:,1:3));
% set(p_1M1B, 'facec', [0.216,1,.583]);
set(p_1M1B, 'facec', [13, 242, 112]./255);
set(p_1M1B, 'EdgeColor','none');

p_2M1D = patch('faces', s_2M1D.F, 'vertices', s_2M1D.V(:,1:3));
% set(p_2M1D, 'facec', [0.306,0.733,1]);
set(p_2M1D, 'facec', [115, 247, 172]./255);
set(p_2M1D, 'EdgeColor','none');

p_motor_2a = patch('faces', s_motor_2a.F, 'vertices', s_motor_2a.V(:,1:3));
% set(p_motor_2a, 'facec', [0.18,0.43,0.285]);
set(p_motor_2a, 'facec', [211,211,211]./255);
set(p_motor_2a, 'EdgeColor','none');

p_motor_2b = patch('faces', s_motor_2b.F, 'vertices', s_motor_2b.V(:,1:3));
set(p_motor_2b, 'facec', [211,211,211]./255);
set(p_motor_2b, 'EdgeColor','none');

p_2M2HA = patch('faces', s_2M2HA.F, 'vertices', s_2M2HA.V(:,1:3));
set(p_2M2HA, 'facec', [183,30,31]./255);
set(p_2M2HA, 'EdgeColor','none');

p_2M2MA = patch('faces', s_2M2MA.F, 'vertices', s_2M2MA.V(:,1:3));
set(p_2M2MA, 'facec', [183,30,31]./255);
set(p_2M2MA, 'EdgeColor','none');

p_3M1D = patch('faces', s_3M1D.F, 'vertices', s_3M1D.V(:,1:3));
set(p_3M1D, 'facec', [232,102,102]./255);
set(p_3M1D, 'EdgeColor','none');

p_motor_3 = patch('faces', s_motor_3.F, 'vertices', s_motor_3.V(:,1:3));
set(p_motor_3, 'facec', [211,211,211]./255);
set(p_motor_3, 'EdgeColor','none');

p_3M2C = patch('faces', s_3M2C.F, 'vertices', s_3M2C.V(:,1:3));
set(p_3M2C, 'facec', [11,91,140]./255);
set(p_3M2C, 'EdgeColor','none');

p_3M2CC = patch('faces', s_3M2CC.F, 'vertices', s_3M2CC.V(:,1:3));
set(p_3M2CC, 'facec', [11,91,140]./255);
set(p_3M2CC, 'EdgeColor','none');

p_4M1D = patch('faces', s_4M1D.F, 'vertices', s_4M1D.V(:,1:3));
set(p_4M1D, 'facec', [78,187,255]./255);
set(p_4M1D, 'EdgeColor','none');

p_motor_4 = patch('faces', s_motor_4.F, 'vertices', s_motor_4.V(:,1:3));
set(p_motor_4, 'facec', [211,211,211]./255);
set(p_motor_4, 'EdgeColor','none');

p_4M2B = patch('faces', s_4M2B.F, 'vertices', s_4M2B.V(:,1:3));
set(p_4M2B, 'facec', [155,209,242]./255);
set(p_4M2B, 'EdgeColor','none');

p_4M2CB = patch('faces', s_4M2CB.F, 'vertices', s_4M2CB.V(:,1:3));
set(p_4M2CB, 'facec', [155,209,242]./255);
set(p_4M2CB, 'EdgeColor','none');

p_garra = patch('faces', s_garra.F, 'vertices', s_garra.V(:,1:3));
set(p_garra, 'facec', [244,245,238]./255);
set(p_garra, 'EdgeColor','none');

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