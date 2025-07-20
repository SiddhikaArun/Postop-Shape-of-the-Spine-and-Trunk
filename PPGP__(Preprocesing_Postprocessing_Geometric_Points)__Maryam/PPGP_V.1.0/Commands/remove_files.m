clc
close all
clear

dir_folder_source='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\4-More than 2 years';
files = dir([dir_folder_source '\S*']);

try
    for i=1:length(files)
        sample = files(i).name;
        
%         source_pre_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.*'];
%         source_pre_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.pre_center_without_normalized_transfo_R.ply'];
%         source_post_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.post_center_without_normalized_transfo_T.ply'];
%         source_post_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.post_center_without_normalized_transfo_R.ply'];   
      
%         source_pre = [dir_folder_source '\' sample '.pre_trunk_N.ply'];
%         source_post = [dir_folder_source '\' sample '.post_trunk_N.ply'];

%         source_pre = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.pre_normalized_LCN.ply'];
%         source_post = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.post_normalized_LCN.ply'];

%         delete(source_pre);
%         delete(source_post);

%         delete(source_pre_T);
%         delete(source_pre_R);
%         delete(source_post_T);
%         delete(source_post_R);
    
        disp(['job is done for sample=' sample]);
        
    end
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end
