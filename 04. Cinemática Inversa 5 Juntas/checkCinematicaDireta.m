function [ eliminate ] = checkCinematicaDireta( T05_obj, theta, delta )
    eliminate = false;
    
    c1 = cos(theta(1));
    s1 = sin(theta(1));
    c23 = cos(theta(2)+theta(3));
    s23 = sin(theta(2)+theta(3));
    c4 = cos(theta(4));
    s4 = sin(theta(4));
    c5 = cos(theta(5));
    s5 = sin(theta(5));
    
    t11 = -c5*(s1*s4-c4*c1*c23) - s5*c1*s23;
    t12 = s5*(s1*s4-c4*c1*c23) - c5*c1*s23;
    t13 = c4*s1 + s4*c1*c23;
    
    t21 = c5*(c1*s4 + c4*s1*c23) - s5*s1*s23;
    t22 = -s5*(c1*s4 + c4*s1*c23) - c5*s1*s23;
    t23 = -c1*c4 + s4*s1*c23;
    
    t31 = c23*s5 + s23*c4*c5;
    t32 = c23*c5 - s23*c4*s5;
    t33 = s23*s4;
    
    if (abs(t11 - T05_obj(1,1)) > delta || abs(t12 - T05_obj(1,2)) > delta || abs(t13 - T05_obj(1,3)) > delta || ...
        abs(t21 - T05_obj(2,1)) > delta || abs(t22 - T05_obj(2,2)) > delta || abs(t23 - T05_obj(2,3)) > delta || ...
        abs(t31 - T05_obj(3,1)) > delta || abs(t32 - T05_obj(3,2)) > delta || abs(t33 - T05_obj(3,3)) > delta)
            eliminate = true;
    end
end

