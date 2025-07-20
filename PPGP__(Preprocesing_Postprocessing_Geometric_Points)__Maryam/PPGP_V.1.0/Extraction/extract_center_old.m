clc
close all
clear
dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-2-Data for Prediction of Spine\AIS-PreparedData\4-More than 2 years';
files = dir([dir_folder '/S*']);
data_pre_new=[];
data_post_new=[];

for i=1:length(files)
    data_pre_new=[];
    data_post_new=[];
    sample = files(i).name;
    source_pre = [dir_folder '\' sample '\points-PLY\' sample '.pre.ply'];
    source_post = [dir_folder '\' sample '\points-PLY\' sample '.post.ply'];
    
%     dest_pre = ['.\Test_1_Center_with_All_previous\' sample '.pre_center.ply'];
%     dest_post = ['.\Test_1_Center_with_All_previous\' sample '.post_center.ply'];
    
    dest_pre = [dir_folder '\' sample '\points-PLY\'  sample '.pre_center.ply'];
    dest_post = [dir_folder '\' sample '\points-PLY\' sample '.post_center.ply'];
    
    data_pre= pcread(source_pre);
    data_post= pcread(source_post);
    
    j=1;
    for k=6:6:101
        x_post = data_post.Location(j:k,1);
        x_pre = data_pre.Location(j:k,1);
        x_pre = mean(x_pre);
        x_post = mean(x_post);
        
        y_post = data_post.Location(j:k,2);
        y_pre = data_pre.Location(j:k,2);
        y_pre = mean(y_pre);
        y_post = mean(y_post);
        
        z_post = data_post.Location(j:k,3);
        z_pre = data_pre.Location(j:k,3);
        z_pre = mean(z_pre);
        z_post = mean(z_post);
        j=j+6;
        
       center_pre= [x_pre,y_pre,z_pre];
       data_pre_new = [data_pre_new; center_pre]
       
       center_post= [x_post,y_post,z_post];
       data_post_new = [data_post_new; center_post]
    end
    
 
%    pcshow(data_pre_new)
%    hold on;
%    fnplt(cscvn(data_pre_new(:,:)'));
   %hold off;
  
   line_pre=fnplt(cscvn(data_pre_new(:,:)'));
   line_pre=line_pre';
   length=arclength(line_pre(:,1), line_pre(:,2), line_pre(:,3));
   line_pre=line_pre/length;
   
   
%    pcshow(line_pre)
%    hold on;
%    fnplt(cscvn(line_pre(:,:)'));
   %hold off;
%    line_pre(:,3)= line_pre(:,3)/(max(line_pre(:,3))+length);
%    line_pre(:,2)= line_pre(:,2)/length;
%    line_pre(:,1)= line_pre(:,1)/length;
   
   line_post=fnplt(cscvn(data_post_new(:,:)'));
   line_post=line_post';
   length=arclength(line_post(:,1), line_post(:,2), line_post(:,3));
   line_post=line_post/length;
   
%    line_post(:,3)= line_post(:,3)/(max(line_post(:,3))+length);
%    line_post(:,2)= line_post(:,2)/length;
%    line_post(:,1)= line_post(:,1)/length;
   
   pcwrite(pointCloud(line_pre), dest_pre)
   pcwrite(pointCloud(line_post), dest_post)

   
end