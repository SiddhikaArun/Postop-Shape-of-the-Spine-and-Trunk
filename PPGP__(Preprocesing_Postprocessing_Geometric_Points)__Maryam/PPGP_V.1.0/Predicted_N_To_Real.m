clc
clear
close all

sample= 'SJ0001333';
folder_address='3-Between 1 year and 2 years';

% source_pre_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.pre_center.ply'];
% source_post_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.post_center.ply']; %%4_1000
% source_predicted_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.predicted_2_CNN_Undirect_Cycle_without_N.ply'];

sample_pre = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\o3\' sample '.pre.o3'];
predicted_t = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\T_R_Ply\' sample '.predicted_2_T_descend_CNN_Undirect_Cycle.ply'];
predicted_r = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\T_R_Ply\' sample '.predicted_2_R_descend_CNN_Undirect_Cycle.ply'];

% source_pre_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.pre_without_normalize_center.ply'];
% source_post_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.post_without_normalize_center.ply']; %%4_1000
% source_predicted_center = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\' folder_address '\' sample '\points-PLY\center\' sample '.predicted_1_CNN_Undirect.ply'];

% Data_predicted_post_N_2 = ['.\' sample '\points-PLY\' sample '.post_predicted_centers_15_1.ply'];
% Data_predicted_post_N_3 = ['.\' sample '\points-PLY\' sample '.post_predicted_centers_17_1.ply'];

% Data_predicted_post_N_1 = ['.\' sample '\points-PLY\' sample '.post_predicted_centers_all.ply'];
% Data_predicted_post_N_2 = ['.\' sample '\points-PLY\' sample '.post_predicted_centers_15_1.ply'];
% Data_predicted_post_N_3 = ['.\' sample '\points-PLY\' sample '.post_predicted_centers_17_1.ply'];

% data_post_center=pcread(source_post_center);
% data_pre_center=pcread(source_pre_center);
% data_predicted_center=pcread(source_predicted_center);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% read predicted t
t_= pcread(predicted_t);
t_vector_=t_.Location();

%% read predicted r
r_= pcread(predicted_r);
r_vector_=r_.Location();
r_mat_ = zeros(24,3,3);
%r_mat_post = zeros(16,3,3);
%for i = 1:23
for i = 1:24
    r = rvect2rmat(r_vector_(i,:));
    r_mat_(i,:,:) = reshape(r,1,3,3);
end

%% compute transfo for t and r
%% read pre
dir=1;
NumPre =o32Num3D(sample_pre);
Num3D_Pre = axesvertebrescalc(NumPre);
newtransfo = rigidtransfocalc(Num3D_Pre,0,0,dir);
% newtransfo.abstrans = t_vector_post';
% newtransfo.absrmat = r_mat_post;

oldtransfo=newtransfo;

newtransfo.trans = t_vector_';
newtransfo.rmat = r_mat_;

% newtransfo_post = rigidtransfocalc(Num3D_Post,0,0,dir);

if dir==1
    newtransfo.transfolist=Num3D_Pre.axelist((Num3D_Pre.axelist(1:end-1)-Num3D_Pre.axelist(2:end)==-1).*(1:length(Num3D_Pre.axelist(1:end-1))));
    newtransfo.transfolist=sort(newtransfo.transfolist,'ascend');
    newtransfo.dir=1;
end
if dir==-1
    newtransfo.transfolist=Num3D_Pre.axelist((Num3D_Pre.axelist(1:end-1)-Num3D_Pre.axelist(2:end)==-1).*(1:length(Num3D_Pre.axelist(1:end-1))))+1;
    newtransfo.transfolist=sort(newtransfo.transfolist,'descend');
    %newtransfo.dir=-1;
end
    
t_vector_abs = zeros(3,24);
r_vector_abs = zeros(24,3,3);
if dir==1
    id=7;
else
    id=24;
end

vec_abst=newtransfo.abstrans(:,id);
newtransfo.abstrans=t_vector_abs;
newtransfo.abstrans(:,id)=vec_abst;
% newtransfo.absrmat=newtransfo_post.absrmat;
%newtransfo.absrmat=r_mat_;
vec_absr=newtransfo.absrmat(id,:,:);
newtransfo.absrmat=r_vector_abs;
newtransfo.absrmat(id,:,:)=vec_absr;

%% calling transfo2Num3D...> rebuildNum3D
newNum3D = transfo2Num3D(Num3D_Pre,newtransfo);

[data_predicted_center_rigid vect_rigid]=axesextract(newNum3D);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
% x_pre = data_pre_center.Location(:,1);
% y_pre = data_pre_center.Location(:,2);
% z_pre = data_pre_center.Location(:,3);
% 
% x_post = data_post.Location(:,1);
% y_post = data_post.Location(:,2);
% z_post = data_post.Location(:,3);


% x_mean = mean(data_pre.Location(:,1));
% x_std = std(data_pre.Location(:,1));
% y_mean = mean(data_pre.Location(:,2));
% y_std = std(data_pre.Location(:,2));
% z_mean = mean(data_pre.Location(:,3));
% z_std = std(data_pre.Location(:,3));
% 
% x_predicted_post = data_post_predicted.Location(:,1) * x_std + x_mean;
% y_predicted_post = data_post_predicted.Location(:,2) * y_std + y_mean;
% z_predicted_post = data_post_predicted.Location(:,3) * z_std + z_mean

% x_predicted_post = data_post_predicted_1.Location(:,1) * (max(x_post)-min(x_post))+ min(x_post);
% y_predicted_post = data_post_predicted_1.Location(:,2) * (max(y_post)-min(y_post))+ min(y_post);
% z_predicted_post = data_post_predicted_1.Location(:,3) * (max(z_post)-min(z_post))+ min(z_post);

% x_pre_real =data_pre_norm.Location(:,1) * (max(x_pre)-min(x_pre))+ min(x_pre);
% y_pre_real =data_pre_norm.Location(:,2) * (max(y_pre)-min(y_pre))+ min(y_pre);
% z_pre_real =data_pre_norm.Location(:,3) * (max(z_pre)-min(z_pre))+ min(z_pre);


% Rec_Predict_rev=[x_predicted_post,y_predicted_post,z_predicted_post];
% Rec_pre_real=[x_pre_real, y_pre_real, z_pre_real]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % %Drawing Pre shape
% % pointscolor_pre=uint8(zeros(data_pre_center.Count,3)); %data_pre_center
% % pointscolor_pre(:,1)=0;
% % pointscolor_pre(:,2)=0;
% % pointscolor_pre(:,3)=255;
% % data_pre_center.Color=pointscolor_pre; %data_pre_center %data_pre_norm
% % pcshow(data_pre_center); %data_pre_center
% % hold on;
% % 
% % 
% % %Drawing Post shape
% % pointscolor_post=uint8(zeros(data_post_center.Count,3));  %data_post_center %data_post_norm
% % pointscolor_post(:,1)=255;
% % pointscolor_post(:,2)=0;
% % pointscolor_post(:,3)=0;
% % data_post_center.Color=pointscolor_post; %data_post_center %data_post_norm
% % pcshow(data_post_center); %data_post_center %data_post_norm
% % hold on;
% % 
% % %Drawing Predicted With Noise Only shape
% % % pointscolor_1=uint8(zeros(data_predicted_center.Count,3));
% % % pointscolor_1(:,1)=255;
% % % pointscolor_1(:,2)=255;
% % % pointscolor_1(:,3)=51;
% % % data_predicted_center.Color=pointscolor_1;
% % % pcshow(data_predicted_center);
% % hold on;
% % 
% % %spl = spline(data_predicted_center.Location(:,1),data_predicted_center.Location(:,2),data_predicted_center.Location(:,3));
% % smotthed_data_predicted_center=smoothdata(data_predicted_center.Location,'rlowess');
% % points=pointCloud(smotthed_data_predicted_center);
% % pointscolor=uint8(zeros(points.Count,3));
% % %pointscolor=uint8(zeros(data_predicted_center.Count,3));
% % pointscolor(:,1)=255;
% % pointscolor(:,2)=255;
% % pointscolor(:,3)=51;
% % points.Color=pointscolor;
% % pcshow(points);
% % % data_predicted_center.Color=pointscolor;
% % % pcshow(data_predicted_center);
% % hold on;
% % L=legend('\color{blue}Preoperative Shape','\color{red}Real Postoperative Shape','\color{yellow}Predicted Postoperative Shape');
% % set(L,'FontSize',11);


curve_pre=fnplt(cscvn(data_predicted_center_rigid(:,:)));
points=pointCloud(curve_pre');
pointscolor=uint8(zeros(points.Count,3));
%pointscolor=uint8(zeros(data_predicted_center.Count,3));
pointscolor(:,1)=255;
pointscolor(:,2)=255;
pointscolor(:,3)=51;
points.Color=pointscolor;
pcshow(points);
% data_predicted_center.Color=pointscolor;
% pcshow(data_predicted_center);
hold on;
L=legend('\color{blue}preoperative shape','\color{red}real postoperative shape','\color{yellow}predicted postoperative shape');

% %Drawing Predicted With Meta+Noise Only shape
% pointscolor_2=uint8(zeros(data_post_predicted_2.Count,3));
% pointscolor_2(:,1)=255;
% pointscolor_2(:,2)=0;
% pointscolor_2(:,3)=255;
% data_post_predicted_2.Color=pointscolor_2;
% pcshow(data_post_predicted_2);
% 
% %Drawing Predicted With Meta Only shape
% pointscolor_3=uint8(zeros(data_post_predicted_3.Count,3));
% pointscolor_3(:,1)=0;
% pointscolor_3(:,2)=0;
% pointscolor_3(:,3)=255;
% data_post_predicted_3.Color=pointscolor_3;
% pcshow(data_post_predicted_3);

% ShowSpine3D(data_post_center.Location);
% %ShowSpine3D(data_post_norm.Location);
% %ShowSpine3D(data_pre_norm.Location);
% 
% ShowSpine3D(Rec_Predict_rev(:,:));
% pcshow(Rec_Predict_rev)

% ShowSpine3D(data_post_center.Location);
% pcshow(data_post)
% 
% ShowSpine3D(data_pre.Location);
% pcshow(data_pre)

