% Solve assignment 1, problem 2.3

%% Calculate angles between elements and global coor
angle_1 = 90; angle_2 = -atand(4/3); angle_3 = 0;

%% Define local stiffness
E = 200e9; % [Pa]
A = 10/10e6; %[m^2]
L = [4,sqrt((4^2)+(3^2)),3];
k = E*A./L;

K = Global_K_Asem(k,[angle_1,angle_2,angle_3],"triangle");

%% Setup subsystems
% Unknown displacements system
D_c = [0;0;0];
R_c = [0;-1000;0];

K_11 = zeros(3,3);
K_11(1,:) = [K(1,1),K(1,2),K(1,6)];
K_11(2,:) = [K(2,1),K(2,2),K(2,6)];
K_11(3,:) = [K(6,1),K(6,2),K(6,6)];

K_12 = zeros(3,3);
K_12(1,:) = K(1,3:5);
K_12(2,:) = K(2,3:5);
K_12(3,:) = K(6,3:5);

D = zeros(6,1);
D([1,2,6]) = K_11\(R_c-K_12*D_c);
D_x = D([1,2,6]);

% Unknown forces system
K_21 = zeros(3,3);
K_21(1,:) = [K(3,1),K(3,2),K(3,6)];
K_21(2,:) = [K(4,1),K(4,2),K(4,6)];
K_21(3,:) = [K(5,1),K(5,2),K(5,6)];

K_22 = zeros(3,3);
K_22(1,:) = K(3,3:5);
K_22(2,:) = K(4,3:5);
K_22(3,:) = K(5,3:5);

R = zeros(6,1);
R([3,4,5]) = K_21*D_x+K_22*D_c;
R(2)=-1000;

%% Plotting undeformed and deformed
% Plotting undeformed

Undeformed_point_x = [0,0,3,0];
Undeformed_point_y = [0,4,0,0];

%Draw
plot(Undeformed_point_x,Undeformed_point_y,'-ro', 'LineWidth', 2, 'MarkerSize',8)

xlim([-0.2 4.2])
ylim([-0.2 4.2])

hold on
Deformed_point_x = [0,0,3+D(1),0];
Deformed_point_y = [0,4+D(6),0+D(2),0];

%Draw
plot(Deformed_point_x,Deformed_point_y,'-bo', 'LineWidth', 2, 'MarkerSize',8)
title('Undeformed vs. Deformed');
xlabel('Length [m]');
ylabel('Length [m]');
legend('Undeformed', 'Deformed');
set(gca,'FontSize',14)
set(gcf,'color','white')



