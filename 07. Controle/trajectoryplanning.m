function [ cctot ] = trajectoryplanning( traj_points, T )
%TRAJECTORYPLANNING Summary of this function goes here
%   Input : traj_points = vetor contendo pontos (init, intermeds, final)
%           T = tempo de cada segmento
%   Output: cctot = vetor de coefs a cada trecho da trajetoria (a cada linha)

    cctot = [];

    traj_dots = zeros(size(traj_points));
    for k = 2:length(traj_points)-1
        slope1 = (traj_points(k) - traj_points(k-1)) / T;
        slope2 = (traj_points(k+1) - traj_points(k)) / T;
        
        if (slope1*slope2 < 0)
            traj_dots(k) = 0;
        else
            traj_dots(k) = (slope1 + slope2) / 2;
        end
        
        cctot = [cctot; cubcoef(traj_points(k-1), traj_dots(k-1), traj_points(k), traj_dots(k), T)];
    end

     cctot = [cctot; cubcoef(traj_points(k), traj_dots(k), traj_points(k+1), traj_dots(k+1), T)];
end
