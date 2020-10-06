function plotGraphics(Thr, Thd, dThr, dThd, ddThr, ddThd, control_effort, angular_position_error, tout, ...
                      angular_position_plot_bool, angular_velocity_plot_bool, ...
                      angular_acceleration_plot_bool, control_effort_plot_bool, ...
                      angular_position_error_plot_bool)
                  
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
        % subplot(2,1,2)
        plot(tout,control_effort(:,1),'b',tout,control_effort(:,2),'r', ...
             tout,control_effort(:,3),'m',tout,control_effort(:,4),'g', ...
             tout,control_effort(:,5),'c');
        % title('Tensão de controle')
        grid('on')
        xlabel('Tempo (s)');  ylabel('Tensão (V)')
        legend('V_1', 'V_2', 'V_3', 'V_4', 'V_5', 'FontSize', 11)
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Plot Angular Position Error
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if angular_position_error_plot_bool == 1
        figure;
        % subplot(2,1,1)
        plot(tout,angular_position_error(:,1),'b',tout,angular_position_error(:,2),'r', ...
             tout,angular_position_error(:,3),'m',tout,angular_position_error(:,4),'g', ...
             tout,angular_position_error(:,5),'c');
        % title('Erro')
        grid('on')
        xlabel('Tempo (s)'); ylabel('Ângulo (º)')
        legend('e_1', 'e_2', 'e_3', 'e_4', 'e_5', 'FontSize', 11);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Functions to Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plot_angular_position(thr, thd, tout, joint_number, color)
        plot(tout,thr,color,tout,thd,strcat('--',color));
        title(strcat('Posição angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo (s)')
        ylabel('Posição (º)')
        legend(strcat('$\theta_{',int2str(joint_number),'r}$'), strcat( ...
             '$\theta^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end

    function plot_angular_velocity(thr, thd, tout, joint_number, color)
        plot(tout,thr,color,tout,thd,strcat('--',color));
        title(strcat('Velocidade angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo (s)')
        ylabel('Velocidade (º/s)')
        legend(strcat('$\dot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
             '$\dot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end

    function plot_angular_acceleration(thr, thd, tout, joint_number, color)
        plot(tout,thr,color,tout,thd,strcat('--',color));
        title(strcat('Aceleração angular da junta',{' '},int2str(joint_number)))
        grid('on')
        xlabel('Tempo (s)')
        ylabel('Aceleração (º/s^2)')
        legend(strcat('$\ddot{\theta}_{',int2str(joint_number),'r}$'), strcat( ...
             '$\ddot{\theta}^d_', int2str(joint_number),'$'), 'Interpreter', 'latex','FontSize',12);
        set(gca,'FontSize',8)
    end
end

