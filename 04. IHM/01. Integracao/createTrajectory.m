function [th1_path, th2_path, th3_path] = createTrajectory(SP_theta, Theta_final)
    T = 40;

    traj_th1 = [SP_theta(1), Theta_final(1)];
    traj_th2 = [SP_theta(2), Theta_final(2)];
    traj_th3 = [SP_theta(3), Theta_final(3)];
    
    rate = 1/1000;

    [t1, th1_path, dth1_path, ddth1_path] = geraTrajetoria(traj_th1, T, rate);
    [t2, th2_path, dth2_path, ddth2_path] = geraTrajetoria(traj_th2, T, rate);
    [t3, th3_path, dth3_path, ddth3_path] = geraTrajetoria(traj_th3, T, rate);

end

