% Open Ports
% 
% Version 1.1
% 1-Oct-2023
%
% SUMMARY 
% It allows the external conections with the computer
% in this case Arduino, Servo & external camera.
%
% A.L.I.C.E project
% CNR-ENEA 
% 
% Bryan Guilcapi 
%
%%
clc
clear all
close all

%% Open Arduino y Servo COMS
a=arduino('/dev/cu.usbmodem2017_2_251','Uno','Libraries','Servo');
%a=arduino("/dev/cu.usbmodem1101","Mega2560","Libraries","Servo");

s=servo(a,'D13');
pause(1);
writePosition(s, 0.0); %0deg (0.0 = 0°    0.5=90°    1=180°)

%% Open Camera conection

camList=webcamlist
%cam = webcam("GENERAL WEBCAM")
%cam = webcam("HD camera ")
%cam = webcam("Cámara de iPhone 12 Pro Max Bryan")
cam = webcam("Cámara FaceTime HD")

%serialportlist("all")