function createTrajectory(trajectory, T)
%     
%     traj_th1 = str2num(trajectory{1});
%     traj_th2 = str2num(trajectory{2});
%     traj_th3 = str2num(trajectory{3});
%     traj_th4 = str2num(trajectory{4});
%     traj_th5 = str2num(trajectory{5});
    
    SP_theta = [trajectory(1,1) trajectory(2,1) trajectory(3,1) trajectory(4,1) trajectory(5,1)];
    
    % Arrange trajectory points in a vector
%     traj_th1 = [SP_theta(1), Theta_final(1)];
%     traj_th2 = [SP_theta(2), Theta_final(2)];
%     traj_th3 = [SP_theta(3), Theta_final(3)];
%     traj_th4 = [SP_theta(4), Theta_final(4)];
%     traj_th5 = [SP_theta(5), Theta_final(5)];

    % Update rate and evaluation time vector
    simulation_time = ((size(trajectory, 2) - 1)*T);
    rate = 1/simulation_time;

    % Call high level function
    [t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(trajectory(1,:), T, rate);
    [t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(trajectory(2,:), T, rate);
    [t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(trajectory(3,:), T, rate);
    [t4, th4_path, dth4_path, ddth4_path] = geraTrajetoria(trajectory(4,:), T, rate);
    [t5, th5_path, dth5_path, ddth5_path] = geraTrajetoria(trajectory(5,:), T, rate);

    th_path = [t1' th1_path' th2_path' th3_path' th4_path' th5_path'];
    dth_path = [t1' dth1_path' dth2_path' dth3_path' dth4_path' dth5_path'];
    ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path' ddth4_path' ddth5_path'];
    
    assignin('base', "SP_theta", SP_theta);
    assignin('base', "th_path", th_path);
    assignin('base', "dth_path", dth_path);
    assignin('base', "ddth_path", ddth_path);

end

