%% Save Data
% 
% Version 1.1
% 1-Oct-2023
%
% SUMMARY 
% It save the data matrix that you measured
%
% A.L.I.C.E project
% CNR-ENEA 
% 
% Bryan Guilcapi 
%%

[filename directory] = uiputfile({'*.mat','matrix';'*.*','All Files' },'Select output file')
    [filepath,name,ext] = fileparts(filename)
    %fileNr = 1;
        filePath = strcat(directory, name, ext);
        %fid = fopen(filePath, 'w');
        %fprintf(fid, 'Integration Time (usec): %d\n', integrationTime);
        %fclose(fid);
        %dlmwrite(filePath, data(:,:,fileNr), 'delimiter', '\t', 'newline', 'pc', '-append');

save(filePath,'cam','Mat_Images','TimeTable','A','TimeLag')


                 
                 %PRINT HIGH QUALITY FIGURE
                 
%set(gcf,'PaperPositionMode','auto')
%print(figure(1),'-dtiff','-r300',[fileparts(filePath),'\',filename '.jpg'])
% 
%saveas(figure(1),[fileparts(filePath),'\',filename '.jpg'])
