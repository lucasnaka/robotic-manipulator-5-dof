close all
clear
clc

load('linksdata.mat')

s0.V(:,1:3) = s0.V(:,1:3) - [0 110 0];
s1.V(:,1:3) = s1.V(:,1:3) - [0 110 0];
s2.V(:,1:3) = s2.V(:,1:3) - [0 710 0];
s3.V(:,1:3) = s3.V(:,1:3) - [0 1310 0];

R = [cosd(-90), -sind(-90), 0;
     sind(-90),  cosd(-90), 0;
             0,          0, 1];

s1.V(:,1:3) = (R*s1.V(:,1:3)')';
s2.V(:,1:3) = (R*s2.V(:,1:3)')';
s3.V(:,1:3) = (R*s3.V(:,1:3)')';

dim = get(0,'ScreenSize');
fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-100],...
                'Name','RRR',...
                'NumberTitle','off');
hold on
light
daspect([1 1 1])
view(135,25)
xlabel('X'),ylabel('Y'),zlabel('Z')
grid on

p0 = patch('faces', s0.F, 'vertices', s0.V(:,1:3));
set(p0, 'facec', [0.717,0.116,0.123]);
set(p0, 'EdgeColor','none');
p1 = patch('faces', s1.F, 'vertices', s1.V(:,1:3));
set(p1, 'facec', [0.216,1,.583]);
set(p1, 'EdgeColor','none');
p2 = patch('faces', s2.F, 'vertices', s2.V(:,1:3));
set(p2, 'facec', [0.306,0.733,1]);
set(p2, 'EdgeColor','none');
p3 = patch('faces', s3.F, 'vertices', s3.V(:,1:3));
set(p3, 'facec', [1,0.542,0.493]);
set(p3, 'EdgeColor','none');

t1 = 0;
t2 = 0;
t3 = 0;

% L = ??
L1 = 600;
L2 = 600;

T_01 = tmat(0, 0, 0, t1);
T_12 = tmat(0, L1, 0, t2);
T_23 = tmat(0, L2, 0, t3);

T_02 = T_01*T_12;
T_03 = T_02*T_23;

Link1 = (T_01*s1.V')';
Link2 = (T_02*s2.V')';
Link3 = (T_03*s3.V')';

dim = get(0,'ScreenSize');
fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-100],...
                'Name','RRR',...
                'NumberTitle','off');
hold on
light
daspect([1 1 1])
view(135,25)
xlabel('X'),ylabel('Y'),zlabel('Z')
grid on

p0 = patch('faces', s0.F, 'vertices', s0.V(:,1:3));
set(p0, 'facec', [0.717,0.116,0.123]);
set(p0, 'EdgeColor','none');
p1 = patch('faces', s1.F, 'vertices', Link1(:,1:3));
set(p1, 'facec', [0.216,1,.583]);
set(p1, 'EdgeColor','none');
p2 = patch('faces', s2.F, 'vertices', Link2(:,1:3));
set(p2, 'facec', [0.306,0.733,1]);
set(p2, 'EdgeColor','none');
p3 = patch('faces', s3.F, 'vertices', Link3(:,1:3));
set(p3, 'facec', [1,0.542,0.493]);
set(p3, 'EdgeColor','none');


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