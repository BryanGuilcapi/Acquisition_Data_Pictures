%% Analisis Top
% 
% Version 1.1
% 1-Oct-2023
%
% SUMMARY 
% Follow the instruction to get the data from measurements
%
% A.L.I.C.E project
% CNR-ENEA 
% 
% Bryan Guilcapi 
%%
clear all
close all
clc

%%
filename=(input('Write the FILE Name to charge data:  ','s'));
load(filename);

start_ang=ang_mov(1,1);
maxmov_ang=min(ang_mov(1,:)); % Change here depend the moviment that you are applying
last_ang=ang_mov(1,end);

% pos_start=find(ang_mov(1,start_ang));
% pos_maxmov=find(1,maxmov_ang);
% pos_last=find(1,last_ang);

pos_start= find(ang_mov==start_ang);
pos_maxmov= find(ang_mov==maxmov_ang);
pos_last= 45;

t0=t(1,pos_start);
tmaxmov=t(1,pos_maxmov);
tend=t(1,pos_last);

% Define parameters of the arc.
xCenter = 0;
yCenter = 0; 
radius = 1;

%Posicion del vector
xnor=radius * cosd(45);
ynor=radius * sind(45);

% Define the angle theta 
theta1=270+start_ang;
theta2=270+maxmov_ang;
theta3=270+last_ang;

cte=1;

x1 = cte * radius * sind(abs(start_ang)); 
y1 = -radius * cosd(abs(start_ang)) ; 
% Now plot the points.

figure()
plot([0 x1],[0 y1],"LineWidth",1.5,"Color",'b','Marker','*');
%axis equal; 
grid on;
hold on


x2= cte * radius * sind(abs(maxmov_ang)); 
y2 = -radius * cosd(abs(maxmov_ang)) ; 
plot([0 x2],[0 y2],"LineWidth",1.5,"Color",'r','Marker','*');


x3= cte * radius * sind(abs(last_ang)); 
y3 = -radius * cosd(abs(last_ang)) ; 
plot([0 x3],[0 y3],"LineWidth",1.5,"Color",'k','Marker','*');


a=[-2 2];
b=a-a;
plot (a,b,LineStyle="--",Color=[0.4940, 0.1840, 0.5560],LineWidth=1.8);
plot (b,a,LineStyle="--",Color=[0.8500, 0.3250, 0.0980],LineWidth=1.8);
legend(['Initial position = ', num2str(start_ang) ,'°'], ...
    ['Max position = ', num2str(maxmov_ang) ,'°'], ...
    ['Final position = ', num2str(last_ang) ,'°'], ...
    'X-Axis Light direction','Y-Axis Polymer Direction');

title('$Moviment$','Interpreter','latex')
xlabel('X-Axis [norm] ','Interpreter','latex');
ylabel('Y-Axis [norm] ','Interpreter','latex');

gcf;
axis([-0.25 1.25 -1.25 0.25]);
hold off;

saveas(gcf,['Start_End_',filename,'.jpg'])


%% Analisis Pos Vs tiempo
mov=  ang_mov;
figure()
plot(t,mov,LineWidth=1.8);
title('$Pos ~ Vs ~ Time $','Interpreter','latex')
xlabel('Time ~[sec] ','Interpreter','latex');
ylabel('Angle ~[degree] ','Interpreter','latex');
grid on;
%saveas(gcf,'Pos_vs_Time_CNR CB-0_1 OD_filtro_1 6A.mat.jpg')
saveas(gcf,['Pos_VS_Time_',filename,'.jpg'])

