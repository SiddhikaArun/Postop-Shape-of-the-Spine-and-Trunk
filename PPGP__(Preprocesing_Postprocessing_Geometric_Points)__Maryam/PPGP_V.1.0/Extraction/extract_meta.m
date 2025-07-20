clc
clear
close all
addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
%%%%%% obj2
dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years';
files = dir([dir_folder '/S*']);
excel_file='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\Data_Patinets_230_v2';
[meta_num,meta_txt]=xlsread(excel_file,'Candidats','A2:Q230');
%%%%%% obj3
% dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\FV-Mesh_Ola_49';
% dir_folder_trunk='D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk';
% files = dir([dir_folder '/*.mat']);
% excel_file='D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\Data_Patinets_66_trunk';
% [meta_num,meta_txt]=xlsread(excel_file,'Candidats','A2:S230');
%%%%%%
%% determine the type of data that will be used for training the network
type="rigid"; % landmarks, rigid, center, trunk
% newFile=1;
    
for i=1:length(files)
    sample = files(i).name;
% %     %%% Obj3
% %     number = sscanf(sample, '%d_%d')
% %     sample = num2str(number(1))
    %%%
    if type =="landmarks"
        dest_file= [dir_folder '\' sample '\points-PLY\per_vertebra\' sample '.meta_landmarks.ply'];
        num=108;
    elseif type =="rigid"
        dest_file= [dir_folder '\' sample '\T_R_ply\' sample '.meta_T.ply'];
        num=48; % num=24;
    elseif type =="center"
        dest_file= [dir_folder '\' sample '\points-PLY\center\' sample '.meta_center.ply']; 
        num=102;
    elseif type =="trunk"
        dest_file= [dir_folder_trunk '\PLY\' sample '.meta.ply'];
        num=35000;
    end

%%%%%%%  Obj2 
    id = find(contains(meta_txt(:,:),sample));
    if string(meta_txt(id,1))==sample
        sex=meta_num(id,1);
        age=meta_num(id,3);
        height=meta_num(id,5);
        weight=meta_num(id,7);
        MBI=meta_num(id,9);
        surgeon=meta_num(id,12);
        meta_vec=[sex,age,height,weight,MBI,surgeon];
%%%%%% Obj3
% %     id = find(meta_num(:,1)== number(1));
% %     if string(meta_num(id,1))==sample
% %         sex=meta_num(id,7);
% %         age=meta_num(id,9);
% %         height=meta_num(id,11);
% %         weight=meta_num(id,13);
% %         MBI=meta_num(id,15);
% %         surgeon=meta_num(id,18);
% %         meta_vec=[sex,age,height,weight,MBI,surgeon];
        
        try
%             if (newFile==1)
%                 edit dest_file;
%             end
            write_ply(dest_file,meta_vec,num);
            disp(['job is done for sample=' sample]);
        catch e
            fprintf(1,'There was an error! The message was:\n%s',e.message);
            disp(sample);
            fprintf(1,'chech data with ID=%s',sample);
        end
       
    end
    
end