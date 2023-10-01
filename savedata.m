%% Save data analysis
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
% folder='C:\Users\Opto\Desktop\Silvia\';
% datenum=num2str(today);
% mkdir(folder,datenum);

[filename directory] = uiputfile({'*.mat','matrix';'*.*','All Files' },'Select output file')
    [filepath,name,ext] = fileparts(filename)
    %fileNr = 1;
        filePath = strcat(directory, name, ext);
        %fid = fopen(filePath, 'w');
        %fprintf(fid, 'Integration Time (usec): %d\n', integrationTime);
        %fclose(fid);
        %dlmwrite(filePath, data(:,:,fileNr), 'delimiter', '\t', 'newline', 'pc', '-append');

save(filePath,'t','A', 'ang_mov','Mx','My','Valy_center','Valx_center','Time_experiment','TimeLag','final_data','Tabla_Data','Tot_mov','Number_pictures','Tot_mov_bacward')


                 
                 %PRINT HIGH QUALITY FIGURE
                 
 set(gcf,'PaperPositionMode','auto')
 print(figure(1),'-dtiff','-r300',[fileparts(filePath),'\',filename '.jpg'])
% 
saveas(figure(1),[fileparts(filePath),'\',filename '.jpg'])
