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
dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\FV-Mesh_Ola_49';
files = dir([dir_folder '\*.mat']);

for i=1:length(files)
    sample = files(i).name;
    number = sscanf(sample, '%d_%d')
    sample = num2str(number(1))
    dest_file_pre_T= ['D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\PLY-41\' sample '.pre_T.ply'];
    dest_file_pre_R= ['D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\PLY-41\' sample '.pre_R.ply'];
    dest_file_post_T= ['D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\PLY-41\' sample '.post_T.ply'];
    dest_file_post_R= ['D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\PLY-41\' sample '.post_R.ply'];
    num=24;
    meta_vec=['1','1','1'];
    
    try
        %             if (newFile==1)
        %               edit dest_file_T;
        %             end
        write_ply_test(dest_file_pre_T,meta_vec,num);
        write_ply_test(dest_file_pre_R,meta_vec,num);
        write_ply_test(dest_file_post_T,meta_vec,num);
        write_ply_test(dest_file_post_R,meta_vec,num);
        disp(['job is done for sample=' sample]);
    catch e
        fprintf(1,'There was an error! The message was:\n%s',e.message);
        disp(sample);
        fprintf(1,'chech data with ID=%s',sample);
    end
    
end
