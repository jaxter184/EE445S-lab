% This script will walk through the creation of a new STM32CubeIDE project.
% Click Run at the top or type 'lab_setup' in the command window

%%
talthrough_dma_zip = [pwd filesep 'talkthrough.zip'];    
prompt = 'Choose a name for your project';
project_name = inputdlg({prompt}, '445S Project Setup', [1,60], {'lab1'});
uiwait(msgbox({...
   'Choose an example project to start from.',...
   'Select a .zip file or use the default ''talkthrough.zip''',},...
   'Choose template project'));
[template_zip, zip_path] = uigetfile('talkthrough.zip',...
   'Choose template project');
uiwait(msgbox('Choose the STM32CubeIDE workspace to extract into.',...
   'Choose workspace'));
workspace_dir = uigetdir('workspace','Choose workspace');
unzip([zip_path filesep template_zip],workspace_dir);
old_dir = [workspace_dir filesep, 'RENAME_ME'];
new_dir = [workspace_dir filesep, project_name{1}];
movefile(old_dir, new_dir);
project_file = [new_dir filesep '.project'];
fid = fopen(project_file,'r'); text_data = char(fread(fid)'); fclose(fid);
ind1 = strfind(text_data,'<name>')+6; ind1 = ind1(1);
ind2 = strfind(text_data,'</name>')-1; ind2 = ind2(1);
text_data(ind1:ind2) = [];
text_data = [text_data(1:ind1-1) project_name{1} text_data((ind1):end)];
fid = fopen(project_file,'w'); fwrite(fid,text_data,'char'); fclose(fid);
uiwait(msgbox({...
    ['Project created in: '...
      newline newline...
      workspace_dir filesep project_name{1} newline] ,...
     'Open the STM32CubeIDE and import the project to continue',...
     '(File -> Import... --> General/Existing Projects Into Workspace)'},...
     'Project Created'));