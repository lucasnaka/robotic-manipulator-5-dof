function plotGraphics(Thr, Thd, dThr, dThd, ddThr, ddThd, x_realizado, y_realizado, z_realizado, ...
                      x_desejado, y_desejado, z_desejado, control_effort, ...
                      angular_position_error, V, G, tal_motor, tal_res, tout, ...
                      angular_position_plot_bool, angular_velocity_plot_bool, ...
                      angular_acceleration_plot_bool, control_effort_plot_bool, ...
                      angular_position_error_plot_bool, centrifugal_coriolis_plot_bool, ...
                      gravitational_plot_bool, tal_motor_plot_bool, tal_res_plot_bool, ...
                      cartesian_path_plot_bool)
                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Plot Angular Position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if angular_position_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_angular_position(Thr(:,1), Thd(:,1), tout, 1, 'b')
%         hold on
        subplot(5,1,2)
        plot_angular_position(Thr(:,2), Thd(:,2), tout, 2, 'r')
%         hold on
        subplot(5,1,3)
        plot_angular_position(Thr(:,3), Thd(:,3), tout, 3, 'm')
%         hold on
        subplot(5,1,4)
        plot_angular_position(Thr(:,4), Thd(:,4), tout, 4, 'g')
%         hold on
        subplot(5,1,5)
        plot_angular_position(Thr(:,5), Thd(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Plot Angular Velocity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if angular_velocity_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_angular_velocity(dThr(:,1), dThd(:,1), tout, 1, 'b')
%         hold on
        subplot(5,1,2)
        plot_angular_velocity(dThr(:,2), dThd(:,2), tout, 2, 'r')
%         hold on
        subplot(5,1,3)
        plot_angular_velocity(dThr(:,3), dThd(:,3), tout, 3, 'm')
%         hold on
        subplot(5,1,4)
        plot_angular_velocity(dThr(:,4), dThd(:,4), tout, 4, 'g')
%         hold on
        subplot(5,1,5)
        plot_angular_velocity(dThr(:,5), dThd(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Plot Angular Acceleration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if angular_acceleration_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_angular_acceleration(ddThr(:,1), ddThd(:,1), tout, 1, 'b')
%         hold on
        subplot(5,1,2)
        plot_angular_acceleration(ddThr(:,2), ddThd(:,2), tout, 2, 'r')
%         hold on
        subplot(5,1,3)
        plot_angular_acceleration(ddThr(:,3), ddThd(:,3), tout, 3, 'm')
%         hold on
        subplot(5,1,4)
        plot_angular_acceleration(ddThr(:,4), ddThd(:,4), tout, 4, 'g')
%         hold on
        subplot(5,1,5)
        plot_angular_acceleration(ddThr(:,5), ddThd(:,5), tout, 5, 'c')
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Plot Control Effort
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if control_effort_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_control_effort(control_effort(:,1), tout, 1, 'b')
        subplot(5,1,2)
        plot_control_effort(control_effort(:,2), tout, 2, 'r')
        subplot(5,1,3)
        plot_control_effort(control_effort(:,3), tout, 3, 'm')
        subplot(5,1,4)
        plot_control_effort(control_effort(:,4), tout, 4, 'g')
        subplot(5,1,5)
        plot_control_effort(control_effort(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Plot Angular Position Error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if angular_position_error_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_angular_position_error(angular_position_error(:,1), tout, 1, 'b')
        subplot(5,1,2)
        plot_angular_position_error(angular_position_error(:,2), tout, 2, 'r')
        subplot(5,1,3)
        plot_angular_position_error(angular_position_error(:,3), tout, 3, 'm')
        subplot(5,1,4)
        plot_angular_position_error(angular_position_error(:,4), tout, 4, 'g')
        subplot(5,1,5)
        plot_angular_position_error(angular_position_error(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  Plot Centrifugal and Coriolis Forces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if centrifugal_coriolis_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_centrifugal_coriolis(V(:,1), tout, 1, 'b')
        subplot(5,1,2)
        plot_centrifugal_coriolis(V(:,2), tout, 2, 'r')
        subplot(5,1,3)
        plot_centrifugal_coriolis(V(:,3), tout, 3, 'm')
        subplot(5,1,4)
        plot_centrifugal_coriolis(V(:,4), tout, 4, 'g')
        subplot(5,1,5)
        plot_centrifugal_coriolis(V(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Plot Gravitational Forces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if gravitational_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_gravitational(G(:,1), tout, 1, 'b')
        subplot(5,1,2)
        plot_gravitational(G(:,2), tout, 2, 'r')
        subplot(5,1,3)
        plot_gravitational(G(:,3), tout, 3, 'm')
        subplot(5,1,4)
        plot_gravitational(G(:,4), tout, 4, 'g')
        subplot(5,1,5)
        plot_gravitational(G(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Plot Gravitational Forces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if tal_motor_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_motor_torque(tal_motor(:,1), tout, 1, 'b')
        subplot(5,1,2)
        plot_motor_torque(tal_motor(:,2), tout, 2, 'r')
        subplot(5,1,3)
        plot_motor_torque(tal_motor(:,3), tout, 3, 'm')
        subplot(5,1,4)
        plot_motor_torque(tal_motor(:,4), tout, 4, 'g')
        subplot(5,1,5)
        plot_motor_torque(tal_motor(:,5), tout, 5, 'c')
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Plot Gravitational Forces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if tal_res_plot_bool == 1
        figure;
        subplot(5,1,1)
        plot_resultant_torque(tal_res(:,1), tout, 1, 'b')
        subplot(5,1,2)
        plot_resultant_torque(tal_res(:,2), tout, 2, 'r')
        subplot(5,1,3)
        plot_resultant_torque(tal_res(:,3), tout, 3, 'm')
        subplot(5,1,4)
        plot_resultant_torque(tal_res(:,4), tout, 4, 'g')
        subplot(5,1,5)
        plot_resultant_torque(tal_res(:,5), tout, 5, 'c')
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Plot Cartesian Path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if cartesian_path_plot_bool == 1
        figure;
        % Plot desired trajectory
        plot3(x_realizado, y_realizado, z_realizado, 'r-');

        % Plot desired trajectory
        hold on
        plot3(x_desejado, y_desejado, z_desejado, 'b-');
        xlabel('X [mm]')
        ylabel('Y [mm]')
        zlabel('Z [mm]')
        legend('Realizado', 'Desejado', 'Interpreter', 'latex','FontSize',8);
        set(gca,'FontSize',8)
        grid on
        xlim([-650,650]), ylim([-500,500]), zlim([-300,500]);
    end
                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Functions to Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plot_angular_position(thr, thd, tout, joint_number, color)
        plot(tout,thr,color,tout,thd,strcat('--',color));
        title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('Posição [º]')
        legend(strcat('$\theta_{',int2str(joint_number),'r}$'), strcat( ...
             '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end

    function plot_angular_velocity(thr, thd, tout, joint_number, color)
        plot(tout,thr,color,tout,thd,strcat('--',color));
        title(strcat('Velocidade angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('Velocidade [º/s]')
        legend(strcat('$\dot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
             '$\dot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end

    function plot_angular_acceleration(thr, thd, tout, joint_number, color)
        plot(tout,thr,color,tout,thd,strcat('--',color));
        title(strcat('Aceleração angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('Aceleração [º/s^2]')
        legend(strcat('$\ddot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
             '$\ddot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end

    function plot_control_effort(control_effort, tout, joint_number, color)
        plot(tout,control_effort,color);
        title(strcat('Esforço de Controle na junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('Tensão (V)')
        legend('V_1', 'V_2', 'V_3', 'V_4', 'V_5', 'FontSize', 11);
        set(gca,'FontSize',8)
    end

    function plot_angular_position_error(angular_position_error, tout, joint_number, color)
        plot(tout,angular_position_error,color);
        title(strcat('Erro da Posição angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('Ângulo (º)')
        legend('e_1', 'e_2', 'e_3', 'e_4', 'e_5', 'FontSize', 11);
        set(gca,'FontSize',8)
    end

    function plot_centrifugal_coriolis(V, tout, joint_number, color)
        plot(tout,V,color);
        title(strcat('Força Cetrífuga e de Coriolis da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('[N.m]')
%         legend(strcat('$\ddot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
%              '$\ddot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end

    function plot_gravitational(G, tout, joint_number, color)
        plot(tout,G,color);
        title(strcat('Força Gravitacional da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('[N.m]')
        set(gca,'FontSize',8)
    end

    function plot_motor_torque(tal_motor, tout, joint_number, color)
        plot(tout,tal_motor,color);
        title(strcat('Torque do motor na junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('[N.m]')
        set(gca,'FontSize',8)
    end

    function plot_resultant_torque(tal_res, tout, joint_number, color)
        plot(tout,tal_res,color);
        title(strcat('Torque resultante na junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo [s]')
        ylabel('[N.m]')
        set(gca,'FontSize',8)
    end
end

