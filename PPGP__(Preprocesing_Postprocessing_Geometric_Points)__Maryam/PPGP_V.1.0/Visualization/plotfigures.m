clc
close all
clear
files = dir('D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years\/S*');

for i=1:length(files)
    sample = files(i).name;
    
    source_pre = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years\' sample '\points-PLY\center\' sample '.pre_center.ply'];
    source_post = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years\' sample '\points-PLY\center\' sample '.post_center.ply'];
    
    data_pre= pcread(source_pre);
    data_post= pcread(source_post);
    
    
    pointscolor=uint8(zeros(data_pre.Count,3));
    pointscolor(:,1)=255;
    pointscolor(:,2)=255;
    pointscolor(:,3)=51;
    data_pre.Color=pointscolor;
    
%     pcshow(data_pre)
%     hold on;
%     fnplt(cscvn(data_pre.Location(:,:)'));
% %     figure;
% %     plot3(data_post.Location(:,1),data_post.Location(:,2),data_post.Location(:,3),'Color','r')
% %     hold on;
% %     plot3(data_pre.Location(:,1),data_pre.Location(:,2),data_pre.Location(:,3),'Color','b')
   
    
    pointscolor_post=uint8(zeros(data_post.Count,3));
    pointscolor_post(:,1)=51;
    pointscolor_post(:,2)=0;
    pointscolor_post(:,3)=51;
    data_post.Color=pointscolor_post;
   
    pcshow(data_post)
    hold on;
    pcshow(data_pre)
    fnplt(cscvn(data_pre.Location(:,:)'));
    fnplt(cscvn(data_post.Location(:,:)'));
    
    %hold off;
    
end