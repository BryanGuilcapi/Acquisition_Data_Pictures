%% Analisis Lateral Picture
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


time_analysis=str2double(input('Select your time analysis: 0.5 (1/2s) , 1 (1s):  ','s'));   %% 15 para 0.5sec  y 30 para 1sec


% Num_ana=Number_pictures/time_analysis;


%% Choose the window to analyse

Im = Mat_Images{1,2};
% image(Im)             %% DESCOMENTAR PARA VER LLA VENTANA QUE SE QUIERE  ANALIZAR
% axis image;

%% Select the dimenssion   
    Y_pixels=250:450;                 % Y dimension
    X_pixels=150:350;                 % X Dimension
    y_dis=length(Y_pixels);
    x_dis=length(X_pixels);
    Im2=Im(Y_pixels,X_pixels,:); % Los : representan los colores de 1 a 3  
    figure()
    imagesc(rgb2gray(Im2));
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
    
    Im=Mat_Images{1,i};
    %reading the frame by 1 seconds
    %            Y         X
    Im2=Im(Y_pixels,X_pixels,:);  % Los : representan los colores de 1 a 3  , Escoger cuadrado
   %imagesc(rgb2ntsc(Im2));
   imagesc((Im2));
    
%% %% Change the Filter enhancement
% shadow_lab = rgb2lab(Im2);
% max_luminosity = 100;
% L = shadow_lab(:,:,1)/max_luminosity;
% 
% shadow_imadjust = shadow_lab;
% shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity;
% shadow_imadjust = lab2rgb(shadow_imadjust);
% 
% shadow_histeq = shadow_lab;
% shadow_histeq(:,:,1) = histeq(L)*max_luminosity;
% shadow_histeq = lab2rgb(shadow_histeq);
% 
% shadow_adapthisteq = shadow_lab;
% shadow_adapthisteq(:,:,1) = adapthisteq(L)*max_luminosity;
% shadow_adapthisteq = lab2rgb(shadow_adapthisteq);
% 
% figure
% montage({Im2,shadow_imadjust,shadow_histeq,shadow_adapthisteq},"Size",[1 4])
% title("Original Image and Enhanced Images using " + ...
%     "imadjust, histeq, and adapthisteq")

%%


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

Tot_mov=ang_mov(1,1)+abs(min(ang_mov(1,:)))


savedata;
%% Para cambiar a formato TXT
%FileData = load(filename);
%csvwrite('Dati.txt', FileData.final_data); % Cambiar de nombre cada vez que se quiera salvar

