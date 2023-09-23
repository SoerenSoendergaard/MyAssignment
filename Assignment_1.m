% FEM assignment 1

clear;close all

% I have this data regarding a structure of aligned bar elements
k = 40e3; % stiffness N/m


NrElements = 3;
NrNodes = NrElements +1;
NrFreedooms = 3;

%% Create stiffness matrix
K = zeros(NrNodes);

% Plug in the first element 
i=1;
K(i,i) = k; K(i,i+1) = -k; K(i+1,i) = -k; K(i+1,i+1) = k;

% Plug in the second element
i=2;
K(i,i) = k+K(i,i); K(i,i+1) = -k+K(i,i+1); K(i+1,i) = -k+K(i+1,i); K(i+1,i+1) = k+K(i+1,i+1);

% And the third
i=3;
K(i,i) = k+K(i,i); K(i,i+1) = -k+K(i,i+1); K(i+1,i) = -k+K(i+1,i); K(i+1,i+1) = k+K(i+1,i+1);

%% Define load vector
R = [0;560;560;280];

% Divide the structual equation into 2 matrix equations
D = zeros(4,1);

%% Solve for displacements
D(2:end) = K(2:end,2:end)\R(2:end);


%% Plotting

Undeformed_Points = [0,7,14,21];
Deformed_Points = [0,7+D(2),14+D(3)...
    ,21+D(4)];

y = ones(1,length(Undeformed_Points));
plot(Undeformed_Points, y, '-or', 'LineWidth', 2, 'MarkerSize', 8,'MarkerFaceColor', 'r');
hold on
y=y*2;
plot(Deformed_Points,y,'-ob', 'LineWidth', 2, 'MarkerSize', 8,'MarkerFaceColor', 'b')
ylim([0 4])

% Add labels and legend
xlabel('Length [m]');
legend('Undeformed', 'Deformed');

% Customize the y-axis ticks and labels
yticks([1 2]);
yticklabels({'Undeformed', 'Deformed'});

% Customize the appearance
grid on;
title('Undeformed vs. Deformed');
set(gca,'FontSize',14)
set(gcf,'color','white')

hold off

%% Calculate strains
L_element = 7;
E = 210e9; % [Pa]
eps_1 = (D(2)-D(1))/L_element;
eps_2 = (D(3)-D(2))/L_element;
eps_3 = (D(4)-D(3))/L_element;

%% Calculate stress

Stress_1 = (E*eps_1)/10^6 % Recalculate to MPa
Stress_2 = (E*eps_2)/10^6 % Recalculate to MPa
Stress_3 = (E*eps_3)/10^6 % Recalculate to MPa

%% Do stress plot

% Define stress for y-axis


% Plot deformed configuration with stress
figure
plot(Deformed_Points,y,'-ob', 'LineWidth', 2, 'MarkerSize', 8,'MarkerFaceColor', 'b')
% Customize the y-axis ticks and labels
yticks([2]);
ylabel({'Deformed'; 'structure'});
set(gca,'FontSize',14)
set(gcf,'color','white')

hold on
yyaxis right
Stress = [Stress_1, Stress_1,Stress_2,Stress_2, Stress_3,Stress_3,0];
x = [Deformed_Points(1), Deformed_Points(2), Deformed_Points(2), ...
    Deformed_Points(3),Deformed_Points(3),Deformed_Points(4),Deformed_Points(4)];

plot(x,Stress,'-o','LineWidth', 2, 'MarkerSize', 8)
ylabel('Stress [MPa]')

ylim([-0.1 1200])
legend('Structur','Stress')
title('Stress over the length of the structure')
xlabel('Length [m]')



