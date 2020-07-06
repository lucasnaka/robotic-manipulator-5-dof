function plot_manipulador_from_forward_kinematic(R01, R02, R03, R05, L)
    hold on
    view([45 25])
    grid
    xlim([-0.6 0.6])
    ylim([-0.6 0.6])
    zlim([-0.6 0.6])

    p0 = [0; 0; 0]; % Coordenadas da origem 
    
    colorLigamento1 = 1/255*[153,198,228];
    colorLigamento2 = 1/255*[72,86,150];
    colorLigamento3 = 1/255*[153,198,228];
    colorLigamento4 = 1/255*[72,86,150];
    colorSistema5 = 1/255*[252,122,30];
    linewidthLigamento = 4.5; % 3
    linewidthSistema5 = 1; %1.2

    % Ligamento 1
    r1 = R01 * [0; 0; -1];     
    L1_1 = p0 + L(1)*r1; 
    L1_2 = p0; 
    arm1_x = [L1_1(1) L1_2(1)];
    arm1_y = [L1_1(2) L1_2(2)];
    arm1_z = [L1_1(3) L1_2(3)];
    plot3(arm1_x, arm1_y, arm1_z, 'LineWidth',linewidthLigamento, 'Color',colorLigamento1)
    
    % Ligamento 2
    r2 = R02 * [1; 0; 0];       
    L2_1 = L1_2;
    L2_2 = L2_1 + L(2)*r2;
    arm2_x = [L2_1(1) L2_2(1)];
    arm2_y = [L2_1(2) L2_2(2)];
    arm2_z = [L2_1(3) L2_2(3)];
    plot3(arm2_x, arm2_y, arm2_z, 'LineWidth',linewidthLigamento, 'Color',colorLigamento2)

    % Ligamento 3
    r3 = R03 * [0; 1; 0];       
    L3_1 = L2_2;
    L3_2 = L3_1 + L(3)*r3;
    arm3_x = [L3_1(1) L3_2(1)];
    arm3_y = [L3_1(2) L3_2(2)];
    arm3_z = [L3_1(3) L3_2(3)];
    plot3(arm3_x, arm3_y, arm3_z, 'LineWidth',linewidthLigamento, 'Color',colorLigamento3)

    % Ligamento 4
    r4 = R05 * [0; 1; 0]; 
    L4_1 = L3_2;
    L4_2 = L4_1 + L(4)*r4;
    arm4_x = [L4_1(1) L4_2(1)];
    arm4_y = [L4_1(2) L4_2(2)];
    arm4_z = [L4_1(3) L4_2(3)];
    plot3(arm4_x, arm4_y, arm4_z, 'LineWidth',linewidthLigamento, 'Color',colorLigamento4)
    
    h(1) = plot3(L1_2(1),L1_2(2),L1_2(3),'ok','MarkerFaceColor','k');
    h(2) = plot3(L2_2(1),L2_2(2),L2_2(3),'ok','MarkerFaceColor','k');
    h(3) = plot3(L3_2(1),L3_2(2),L3_2(3),'ok','MarkerFaceColor','k');
    uistack(h(1),'top');
    uistack(h(2),'top');
    uistack(h(3),'top');
    
%     % Plot da divisao do ligamento 3
%     center = L3_1' + L(3)/2*r3';
%     normal = r4';
%     radius = linewidthLigamento/400;
%     
%     t=0:0.01:2*pi;
%     v=null(normal);
%     points=repmat(center',1,size(t,2))+radius*(v(:,1)*cos(t)+v(:,2)*sin(t));
%     plot3(points(1,:),points(2,:),points(3,:),'k-');
    
    % Plot do sistema de coordenadas {5}
    X5 = [1; 0; 0];
    Y5 = [0; 1; 0];
    Z5 = [0; 0; 1];

    X = R05 * 0.1*X5;
    Y = R05 * 0.1*Y5;
    Z = R05 * 0.1*Z5;
    
    quiver3(L4_1(1),L4_1(2),L4_1(3),X(1),X(2),X(3), 'Color', colorSistema5, 'linewidth', linewidthSistema5);
    quiver3(L4_1(1),L4_1(2),L4_1(3),Y(1),Y(2),Y(3), 'Color', colorSistema5, 'linewidth', linewidthSistema5);
    quiver3(L4_1(1),L4_1(2),L4_1(3),Z(1),Z(2),Z(3), 'Color', colorSistema5, 'linewidth', linewidthSistema5);

    xlabel('x','FontSize',16)
    ylabel('y','FontSize',16)
    zlabel('z','FontSize',16)
end

