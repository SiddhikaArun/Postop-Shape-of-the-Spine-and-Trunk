clc
close all
clear
dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\6-Test_Trunk\patients for train_10_ply';
files = dir([dir_folder '/S*']);
data_pre_new=[];
data_post_new=[];

sample ='1526327';
source_pre = [dir_folder '\' sample '.pre_trunk.ply'];
source_post = [dir_folder '\' sample '.post_trunk.ply'];

%     dest_pre = ['.\Test_1_Center_with_All_previous\' sample '.pre_center.ply'];
%     dest_post = ['.\Test_1_Center_with_All_previous\' sample '.post_center.ply'];

dest_pre = [dir_folder '\' sample '.pre_trunk_N.ply'];
dest_post = [dir_folder '\' sample '.post_trunk_N.ply'];

data_pre= pcread(source_pre);
data_post= pcread(source_post);

vec_pre=data_pre.Location;
vec_post=data_post.Location;

max_pre=max(vec_pre(:,:,:));
max_post=max(vec_post(:,:,:));

vec_pre_norm=vec_pre/max_pre(3);
vec_post_norm=vec_post/max_post(3);

% vec_pre_norm_x=vec_pre(:,1)/max_pre(1);
% vec_pre_norm_y=vec_pre(:,2)/max_pre(2);
% vec_pre_norm_z=vec_pre(:,3)/max_pre(3);
% vec_pre_norm =[vec_pre_norm_x, vec_pre_norm_y, vec_pre_norm_z];


pcwrite(pointCloud(vec_pre_norm(1:35000,:)), dest_pre)
pcwrite(pointCloud(vec_post_norm(1:35000,:)), dest_post)


