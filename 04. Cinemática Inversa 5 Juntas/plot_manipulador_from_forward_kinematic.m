function plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)
    hold on
    view([45 25])
    grid
    xlim([-0.7 0.7])
    ylim([-0.7 0.7])
    zlim([-0.7 0.7])

    p0 = [0; 0; 0]; % Coordenadas da origem 

    % Ligamento 1
    r1 = R01 * [0; 0; -1];     
    L1_1 = p0 + L(1)*r1; 
    L1_2 = p0; 
    arm1_x = [L1_1(1) L1_2(1)];
    arm1_y = [L1_1(2) L1_2(2)];
    arm1_z = [L1_1(3) L1_2(3)];
    plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',3)

    % Ligamento 2
    r2 = R02 * [1; 0; 0];       
    L2_1 = L1_2;
    L2_2 = L2_1 + L(2)*r2;
    arm2_x = [L2_1(1) L2_2(1)];
    arm2_y = [L2_1(2) L2_2(2)];
    arm2_z = [L2_1(3) L2_2(3)];
    plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',3)

    % Ligamento 3
    r3 = R03 * [0; 1; 0];       
    L3_1 = L2_2;
    L3_2 = L3_1 + L(3)*r3;
    arm3_x = [L3_1(1) L3_2(1)];
    arm3_y = [L3_1(2) L3_2(2)];
    arm3_z = [L3_1(3) L3_2(3)];
    plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',3)

    % Ligamento 4
    r4 = R05 * [0; 1; 0]; 
    L4_1 = L3_2;
    L4_2 = L4_1 + L(4)*r4;
    arm4_x = [L4_1(1) L4_2(1)];
    arm4_y = [L4_1(2) L4_2(2)];
    arm4_z = [L4_1(3) L4_2(3)];
    plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',3)

    xlabel('x','FontSize',16)
    ylabel('y','FontSize',16)
    zlabel('z','FontSize',16)
end

