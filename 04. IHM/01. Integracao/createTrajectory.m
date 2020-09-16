function createTrajectory(SP_theta, Theta_final)
          
    % Arrange trajectory points in a vector
    traj_th1 = [SP_theta(1), Theta_final(1)];
    traj_th2 = [SP_theta(2), Theta_final(2)];
    traj_th3 = [SP_theta(3), Theta_final(3)];

    T = 5;

    % Update rate and evaluation time vector
    simulation_time = ((length(traj_th1)-1)*T);
    rate = 1/simulation_time;

    % Call high level function
    [t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
    [t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
    [t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);

    th_path = [t1' th1_path' th2_path' th3_path'];
    dth_path = [t1' dth1_path' dth2_path' dth3_path'];
    ddth_path = [t1' ddth1_path' ddth2_path' ddth3_path'];
    
    assignin('base', "SP_theta", SP_theta);
    assignin('base', "th_path", th_path);
    assignin('base', "dth_path", dth_path);
    assignin('base', "ddth_path", ddth_path);

end

