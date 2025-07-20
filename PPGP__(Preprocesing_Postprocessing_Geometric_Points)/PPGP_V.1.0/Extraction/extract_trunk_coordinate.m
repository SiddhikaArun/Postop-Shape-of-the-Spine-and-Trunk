clc
close all
clear
sdir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\FV-Mesh_Ola_49';
ddir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-3-Prediction of Postoperative Shape of Trunk\PLY-42';

data_pre_new=[];
data_post_new=[];

s_sample ='2100551_27';
source_pre = [sdir_folder '\' s_sample '_Preop_Analyse.mat'];
source_post = [sdir_folder '\' s_sample '_Postop_Analyse.mat'];
d_sample ='2100551';
dest_pre = [ddir_folder '\' d_sample '.pre_trunk_N.ply'];
dest_post = [ddir_folder '\' d_sample '.post_trunk_N.ply'];

%% Pre
load(source_pre);
coord_pre= FV.Coord(:,:);
connect_pre= FV.Connect(:,:);

max_pre=max(coord_pre(:,:,:));
coord_pre_norm=coord_pre/max_pre(3);

% coord_pre_norm_x=coord_pre(:,1)/max_pre(1);
% coord_pre_norm_y=coord_pre(:,2)/max_pre(2);
% coord_pre_norm_z=coord_pre(:,3)/max_pre(3);
% coord_pre_norm =[coord_pre_norm_x, coord_pre_norm_y, coord_pre_norm_z];

%% Post
load(source_post);
coord_post= FV.Coord(:,:);
connect_post= FV.Connect(:,:);

max_post=max(coord_post(:,:,:));
coord_post_norm=coord_post/max_post(3);

pcwrite(pointCloud(coord_pre_norm(1:35000,:)), dest_pre)
pcwrite(pointCloud(coord_post_norm(1:35000,:)), dest_post)





