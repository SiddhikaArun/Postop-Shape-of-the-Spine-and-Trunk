clc
close all
clear

dir_folder_source='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years\';
dir_folder_des='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\9-Test_7files per patines-Landmarks_Rigid\3-Between 1 year and 2 years\landmarks_Rigid_ascend_LCN';
files = dir([dir_folder_source '/S*']);
temp='ascend_'; % temp='ascend_' OR temp='descend_' OR temp=''
type_normalization='LCN'; %'LCN' 'lengh_curve_norm'; %'MSN' 'mean_std_norm';
try
    for i=1:length(files)
        sample = files(i).name;
%             source_pre = [dir_folder_source '\' sample '\points-PLY\center\' sample '.pre_center.ply'];
%             source_post = [dir_folder_source '\' sample '\points-PLY\center\' sample '.post_center.ply'];
        %     source_meta = [dir_folder_source '\' sample '\points-PLY\' sample '.meta_center.ply'];
        %     source_pre_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.pre_center_T.ply'];
        %     source_pre_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.pre_R.ply'];
        %     source_post_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.post_center_T.ply'];
        %     source_post_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.post_R.ply'];
        
        source_pre = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.pre_normalized_' type_normalization '.ply'];
        source_post = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.post_normalized_' type_normalization '.ply'];
        source_meta = [dir_folder_source '\' sample '\points-PLY\per_vertebra\' sample '.meta_landmarks.ply'];
%         source_meta = [dir_folder_source '\' sample '\T_R_ply\' sample '.meta_T.ply'];
%         source_pre_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.'  temp 'pre_center_normalized_transfo_T.ply'];
%         source_pre_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.'  temp 'pre_center_normalized_transfo_R.ply'];
%         source_post_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.' temp 'post_center_normalized_transfo_T.ply'];
%         source_post_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.' temp 'post_center_normalized_transfo_R.ply'];
%         source_pre_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.'  temp 'pre_center_normalized_' type_normalization '_transfo_T.ply'];
%         source_pre_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.'  temp 'pre_center_normalized_' type_normalization '_transfo_R.ply'];
%         source_post_T = [dir_folder_source '\' sample '\T_R_ply\' sample '.' temp 'post_center_normalized_' type_normalization '_transfo_T.ply'];
%         source_post_R = [dir_folder_source '\' sample '\T_R_ply\' sample '.' temp 'post_center_normalized_' type_normalization '_transfo_R.ply'];
        
        
        st1=copyfile(source_pre,dir_folder_des);
        st2=copyfile(source_post,dir_folder_des);
        st3=copyfile(source_meta,dir_folder_des);
%         st4=copyfile(source_pre_T,dir_folder_des);
%         st5=copyfile(source_pre_R,dir_folder_des);
%         st6=copyfile(source_post_T,dir_folder_des);
%         st7=copyfile(source_post_R,dir_folder_des);
        disp(['job is done for sample=' sample]);
        
    end
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end
