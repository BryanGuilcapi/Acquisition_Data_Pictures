%% Aquisition
% 
% Version 1.2
% 1-Oct-2023
%
% SUMMARY 
% Follow the instruction to capture the pictures
%
% A.L.I.C.E project
% CNR-ENEA 
% 
% Bryan Guilcapi 
%
%%
clear A Mat_Images TimeTable TimeLag

Time = str2double(input('Total time of measurement [60 s]?:   ','s'));
TimeLag=str2double(input('Time lag: how long between consecutive acquisitions (example: 1 secs, minimum is 0.25 secs)?:   ','s')); 


format long
NumberOfPicture=round((Time/TimeLag));
memory=NumberOfPicture*0.0143;
input(['Be aware that memory required is:  ',num2str(memory),'MB,  press Enter to continue or (Ctr + c) to end'],'s');


[dim s]=size(Time);
A=zeros(dim, NumberOfPicture);
A=1:1:NumberOfPicture+1;
h_waitbar = waitbar(0,'Acquiring...','CreateCancelBtn','delete(gcbf)');
TimeTable=zeros(1, NumberOfPicture);
TimeTable=0:TimeLag:Time;
 k=1;
 counter=1;
 time_serv=0;

 tic
 for j=1:round(NumberOfPicture)+1
      
    im=snapshot(cam);
    %A(:,j)=imwrite(im);

    Mat_Images{counter}=im;
    counter=counter+1;

if time_serv==1      %DEFINE THE SECOND TO OPEN THE WALL
s=servo(a,'D13');
writePosition(s, 0.5); %% Move the wall up
end
if time_serv==6      %DEFINE THE SECOND TO CLOSE THE WALL
%s=servo(a,'D13');
writePosition(s, 0.0); %% Move the wall down
end

    if ~ishandle(h_waitbar)
        disp('Stopped by User');
        break
    else
        waitbar(j/round(NumberOfPicture), h_waitbar, ['Acquiring... ', num2str(j),' picture of ' num2str(NumberOfPicture+1),' total imag.']);
    end
        pause(TimeLag)
  
        time_serv=time_serv+TimeLag;

 end
delete(h_waitbar);
toc
savedata_acquisition;

disp('  ');
disp('+++++++++++++++++++++++++++++++');
disp('!Your Caracterization is done !');
disp('+++++++++++++++++++++++++++++++');
disp('  ');


