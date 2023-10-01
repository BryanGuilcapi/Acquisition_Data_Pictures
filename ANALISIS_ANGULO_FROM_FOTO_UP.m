%% Analisis Up Picture
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
%
%% ANALISIS POSICIÓN
clear all
close all
clc

%% Load Video
disp('*******************************************************');
disp('*******************************************************');
disp('**                                                   **');
disp('**  Programa para analizar la Posición del Polimero  **');
disp('**                                                   **');
disp('*******************************************************');
disp('*******************************************************');

disp('   ');
disp('   ');
disp('Follow the instructions');
disp('   ');
disp('   ');

name_file=(input('Write the FILE Name to charge data:  ','s'));
load(name_file);

Time_experiment=TimeTable(1,end);
Number_pictures=A(1,end);


disp('*******************************************************');
disp('**  Your data are charged                            **');
disp('**                                                   **');
disp(['** Your  Time experiment was = ', num2str(Time_experiment) ,' seconds']);
disp(['** Your  Total number of pictures are  = ', num2str(Number_pictures) ,' images']);
disp(['** Your  Time lag for each peacture was = ', num2str(TimeLag) ,' seconds']);


time_analysis=0.25;

%% Choose the window to analyse

 Im = Mat_Images{1,9};
 %image(Im) %% DESCOMENTAR PARA VER LLA VENTANA QUE SE QUIERE  ANALIZAR
 %axis image;


 %% Select the dimenssion   
    X_pixels=200:500;                 % Y dimension
    Y_pixels=100:400;                 % X Dimension
    y_dis=length(Y_pixels);
    x_dis=length(X_pixels);
    Im2=Im(Y_pixels,X_pixels,:); % Los : representan los colores de 1 a 3  
    figure()
    imagesc(rgb2gray(Im2))
    title('Choose the  origen center','FontSize',18);
    axis image;    
    [Pt]=ginput;  
    Valy_center=(Pt(1,2));  %Dato de corte en X  Selección Manual
    Valx_center=(Pt(1,1));  %Dato de corte en X  Selección Manual
    close all;

    %% Data aquisition

Mx = zeros(1,Number_pictures);
My = zeros(1,Number_pictures);
ang_mov= zeros(1,Number_pictures);
n=1;
t=0;
j=0;

for i=int64(1:1:Number_pictures) %Trabajando en frames enteros
    
    Im=Mat_Images{1,n};
    %reading the frame by 1 seconds
    %            Y         X
    Im2=Im(Y_pixels,X_pixels,:);  % Los : representan los colores de 1 a 3  , Escoger cuadrado
    %imagesc(rgb2ntsc(Im2));
    imagesc((Im2));

    title([' Chose the max point at Time ', num2str(t) ,' seconds'],'FontSize',18);
    [Pt]=ginput;
    My(1,n)=(Pt(1,2));         % Guardo la posición en X
    Mx(1,n)=(Pt(1,1));         % Guardo la posicion en Y
    close all;                      % Cierro la primera figura para empezar la próxima
    ang_mov(1,n)=atand((Valx_center-Mx(1,n))/(Valy_center-My(1,n)));
    n=n+1;
    t=t+time_analysis;
    
end

%% Plot Moviment

h=1;
t=0;

figure ()
txt1= 'origin';
plot(Valx_center,Valy_center,"Marker",".","MarkerSize",15,'DisplayName',txt1);
xlim([0 x_dis]);
ylim([0 y_dis]);
ax=gca;
ax.XDir = 'normal';
ax.YDir = 'reverse';
hold on;
plot([0, 601],[Valy_center,Valy_center],"Color",'k')
plot([Valx_center,Valx_center],[0, 381],"Color",'k')



for i=int64(1:1:Number_pictures)
    txt = ['time = ',num2str(t), ' -> angle = ',num2str(ang_mov(h:h))];
    plot(Mx(1,h),My(1,h),"Marker",".","MarkerSize",15,'DisplayName',txt);
    title('$Moviment$','Interpreter','latex')
    xlabel('$\ Position~Pixel~X  $','Interpreter','latex');
    ylabel('$\ Position~Pixel~Y $','Interpreter','latex');
    pause(0.1)
    h=h+1;
    t=t+TimeLag;

end
 %legend show

t=0:TimeLag:Time_experiment;  %-sec_medido; % Definimos los segundos de paso

final_data = zeros(2,Number_pictures);
final_data(1,:)=t;
final_data(2,:)=ang_mov;
final_data=final_data';

Tabla_Data=table(t',ang_mov','VariableNames',{'Time[s]','Degree[º]'})



%% Calculo del angulo total

Tot_mov=abs(max(ang_mov(1,:)))-ang_mov(1,1)
Tot_mov_bacward=abs(max(ang_mov(1,:)))-ang_mov(1,end)
savedata;
