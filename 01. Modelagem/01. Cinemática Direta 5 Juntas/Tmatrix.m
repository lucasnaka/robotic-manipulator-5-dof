function [T] = Tmatrix(alpha, a, d, theta)
    alpha = alpha*pi/180;    %Note: alpha is in radians.
    theta = theta*pi/180;    %Note: theta is in radians.

    T = [cos(theta),            -sin(theta),           0,           a;
         sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
         sin(theta)*sin(alpha), cos(theta)*sin(alpha),  cos(alpha), cos(alpha)*d
         0,                     0,                      0,          1];
end

