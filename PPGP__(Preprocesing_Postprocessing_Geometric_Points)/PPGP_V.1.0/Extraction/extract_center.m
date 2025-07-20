clc
close all
clear
dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years';
files = dir([dir_folder '/S*']);
data_pre_new=[];
data_post_new=[];

try
    for i=1:length(files)
        data_pre_new=[];
        data_post_new=[];
        sample = files(i).name;
        source_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
        source_post = [dir_folder '\' sample '\o3\' sample '.post.o3'];
        
        %     dest_pre = ['.\Test_3_Center_Meta_T_with_All_previous\' sample '.pre_center.ply'];
        %     dest_post = ['.\Test_3_Center_Meta_T_with_All_previous\' sample '.post_center.ply'];
        %     dest_pre_T = ['.\Test_3_Center_Meta_T_with_All_previous\' sample '.pre_center_T.ply'];
        %     dest_post_T = ['.\Test_3_Center_Meta_T_with_All_previous\' sample '.post_center_T.ply'];
        %
        dest_pre = [dir_folder '\' sample '\points-PLY\center\'  sample '.pre_center.ply'];
        dest_post = [dir_folder '\' sample '\points-PLY\center\' sample '.post_center.ply'];
        dest_pre_T = [dir_folder '\' sample '\T_R_ply\center\' sample '.pre_center_T.ply'];
        dest_post_T = [dir_folder '\' sample '\T_R_ply\center\' sample '.post_center_T.ply'];
        %
        Num_pre = o32Num3D(source_pre);
        Num3D_pre = axesvertebrescalc(Num_pre);
        Num3D_pre.axelist=sort(Num3D_pre.axelist);
        
        Num_post = o32Num3D(source_post);
        Num3D_post = axesvertebrescalc(Num_post);
        Num3D_post.axelist=sort(Num3D_post.axelist);
        
        pre_centroids=[];
        post_centroids=[];
        
        %     if length(Num3D_pre.axelist)>=1
        %extract the axes information
        [center_pre vect]=axesextract(Num3D_pre);
        center_pre=center_pre(:,7:23)';
        
        %         pcshow(center_pre)
        %         hold on;
        %         fnplt(cscvn(center_pre(:,:)'));
        
        curve_pre=fnplt(cscvn(center_pre(:,:)'));
        curve_pre=curve_pre';
        length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
        curve_pre=curve_pre/length_pre;
        center_norm_pre=center_pre/length_pre;
        
        % % % % %        direction=1
        % % % % %        trans_pre=zeros(16,3);
        % % % % %        for i=1:1:16
        % % % % %            trans_pre(i,:)=center_norm_pre(i+direction*1,:)-center_norm_pre(i,:);
        % % % % %        end
% %         x = [dir_folder '\' sample '\points-PLY\center\SJ0000110.post_center.ply'];
% %         y = [dir_folder '\' sample '\points-PLY\center\SJ0000110.pre_center.ply'];
% %         delete (x)
% %         delete (y)
        pcwrite(pointCloud(curve_pre), dest_pre);
        % % % % %        pcwrite(pointCloud(trans_pre), dest_pre_T);
        
        %     end
        
        %     if length(Num3D_post.axelist)>=1
        %extract the axes information
        [center_post vect]=axesextract(Num3D_post);
        center_post=center_post(:,7:23)';
        
        %        pcshow(center_post)
        %        hold on;
        %        fnplt(cscvn(center_post(:,:)'));
        
        
        curve_post=fnplt(cscvn(center_post(:,:)'));
        curve_post=curve_post';
        length_post=arclength(curve_post(:,1), curve_post(:,2), curve_post(:,3));
        curve_post=curve_post/length_post;
        center_norm_post=center_post/length_post;
        
        % % % % %        direction=1
        % % % % %        trans_post=zeros(16,3);
        % % % % %        for i=1:1:16
        % % % % %            trans_post(i,:)=center_norm_post(i+direction*1,:)-center_norm_post(i,:);
        % % % % %        end
        
        pcwrite(pointCloud(curve_post), dest_post);
        % % % % %        pcwrite(pointCloud(trans_post), dest_post_T);
        %     end
        
        disp(['job is done for sample=' sample]);
    end
   
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end



