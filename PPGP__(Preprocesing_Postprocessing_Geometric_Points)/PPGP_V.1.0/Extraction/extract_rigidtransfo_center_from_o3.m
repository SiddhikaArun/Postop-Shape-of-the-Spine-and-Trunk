%% Extracting R and T from input data O3 %%%%%%%%%%%%%%%%
clc
close all
clear

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'

dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\1-Less than 6 months';
files = dir([dir_folder '\S*']);
direction=1; 
if direction==1
   dir_='ascend';
else
   dir_='descend';
end

type_normalization='MSN'; %'LCN' 'lengh_curve_norm'; %'MSN' 'mean_std_norm';

try
    for i=1:length(files)
        sample = files(i).name;
%         x = [dir_folder '\' sample '\T_R_ply\SJ0000110.post_normalized_T.ply'];
%         y = [dir_folder '\' sample '\T_R_ply\SJ0000110.post_R.ply'];
%         z = [dir_folder '\' sample '\T_R_ply\SJ0000110.pre_normalized_T.ply'];
%         e = [dir_folder '\' sample '\T_R_ply\SJ0000110.pre_R.ply'];
%         delete (x)
%         delete (y)
%         delete (z)
%         delete (e)
        %%
        sample_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
        sample_post = [dir_folder '\' sample '\o3\' sample '.post.o3'];
        
        %% with normalization
        dest_pre_norm_T = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_pre_center_normalized_' type_normalization '_transfo_T.ply'];
        dest_pre_norm_R = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_pre_center_normalized_' type_normalization '_transfo_R.ply'];
        
        dest_post_norm_T = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_post_center_normalized_' type_normalization '_transfo_T.ply'];
        dest_post_norm_R = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_post_center_normalized_' type_normalization '_transfo_R.ply'];
       
        %% without normalization
        dest_pre_T = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_pre_center_without_normalized_transfo_T.ply'];
        dest_pre_R = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_pre_center_without_normalized_transfo_R.ply'];
        
        dest_post_T = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_post_center_without_normalized_transfo_T.ply'];
        dest_post_R = [dir_folder '\' sample '\T_R_ply\' sample '.' dir_ '_post_center_without_normalized_transfo_R.ply'];
        
        %% pre
        
        Num_pre = o32Num3D(sample_pre);
        Num3D_pre = axesvertebrescalc(Num_pre); %% subtract from ref is done inside this file.
        transfo_pre = rigidtransfocalc(Num3D_pre,0,0,direction);
        transfo_pre.trans = zeros(3,24);
        transfo_pre.rvect = zeros(3,24);
        transfo_pre_norm = transfo_pre;
        
        
        [center_pre vect]=axesextract(Num3D_pre);
        center_pre=center_pre(:,7:24)'; % center_pre=center_pre(:,7:24)' ?????
        %center_pre=center_pre(:,:)';
        if strcmp(type_normalization,'LCN')
            curve_pre=fnplt(cscvn(center_pre(:,:)'));
            curve_pre=curve_pre';
            length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));
            center_pre_normalized=center_pre/length_pre;
            center_pre_normalized=[[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];center_pre_normalized];
        end
        if strcmp(type_normalization,'MSN')
                mean_x= mean(center_pre(:,1));
                mean_y= mean(center_pre(:,2));
                mean_z= mean(center_pre(:,3));
                std_x= std(center_pre(:,1));
                std_y= std(center_pre(:,2));
                std_z= std(center_pre(:,3));
                x_norm_pre=(abs(center_pre(:,1)-mean_x))/std_x;
                y_norm_pre=(abs(center_pre(:,2)-mean_y))/std_y;
                z_norm_pre=(abs(center_pre(:,3)-mean_z))/std_z;
                center_pre_normalized=[x_norm_pre,y_norm_pre,z_norm_pre];
                center_pre_normalized=[[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];center_pre_normalized];
                center_pre_normalized_= normalize(center_pre);
        end
        center_pre=[[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];center_pre];
        
        if direction==1
            transfo_pre_norm.transfolist=Num3D_pre.axelist((Num3D_pre.axelist(1:end-1)-Num3D_pre.axelist(2:end)==-1).*(1:length(Num3D_pre.axelist(1:end-1))));
            transfo_pre_norm.transfolist=sort(transfo_pre_norm.transfolist,'ascend');
            %j=1;
        end
        if direction==-1
            transfo_pre_norm.transfolist=Num3D_pre.axelist((Num3D_pre.axelist(1:end-1)-Num3D_pre.axelist(2:end)==-1).*(1:length(Num3D_pre.axelist(1:end-1))))+1;
            transfo_pre_norm.transfolist=sort(transfo_pre_norm.transfolist,'descend');
            %j=size(center_pre_normalized,1);
        end

        % trans_pre=zeros(16,3);
        % for i=1:1:16
        %     trans_pre(i,:)=center_pre_normalized(i+direction*1,:)-center_pre_normalized(i,:);
        % end
        %j=1; 
        
        for i=transfo_pre_norm.transfolist
            % Calcutation of the translation vector
%             if j==17 %(j==17)?????
%                 transfo_pre_norm.trans(:,i)=[0 0 0];
% %                 transfo_pre.trans(:,i)=[0 0 0];
%             else
            transfo_pre_norm.trans(:,i)=center_pre_normalized(i+direction*1,:)-center_pre_normalized(i,:);
            transfo_pre.trans(:,i)=center_pre(i+direction*1,:)-center_pre(i,:);
%             end
            % Calculation of the rotation matrix input -> output
            R=Challismethod(reshape(vect(i,:,:),3,3),reshape(vect(i+direction*1,:,:),3,3));
            
            transfo_pre_norm.rmat(i,:,:)=reshape(R,1,3,3);
            % Calculation of the rotation vector input -> output
            [transfo_pre_norm.rvect(:,i) transfo_pre_norm.rangle(i) transfo_pre_norm.raxe(:,i)]=rmat2rvect(R);
            transfo_pre.rvect(:,i)=transfo_pre_norm.rvect(:,i);
%             transfo_pre.rmat(i,:,:)=reshape(R,1,3,3);
%             % Calculation of the rotation vector input -> output
%             [transfo_pre.rvect(:,i) transfo_pre.rangle(i) transfo_pre.raxe(:,i)]=rmat2rvect(R);
            %j=j+1;
        end
        
        %we apply here the inverse absolute rotation matrice in order to have the
        %translation vector in the local axes.
        for j=transfo_pre_norm.transfolist
            transfo_pre_norm.trans(:,j)=(reshape(transfo_pre_norm.absrmat(j,:,:),3,3)^(-1))*transfo_pre_norm.trans(:,j);
            transfo_pre.trans(:,j)=(reshape(transfo_pre.absrmat(j,:,:),3,3)^(-1))*transfo_pre.trans(:,j);
            %if absolute translations-----------------------------------------
        end
        
%         for j=transfo.transfolist
%             transfo_pre.trans(:,j)=(reshape(transfo.absrmat(j,:,:),3,3)^(-1))*transfo_pre.trans(:,j);
%             %transfo.trans(:,j)=trans(:,j);
%             %if absolute translations-----------------------------------------
%         end
        
        %trans_pre=transfo_pre.abstrans(:,:)';
        trans_pre_norm=transfo_pre_norm.trans(:,:)';
        %trans_post=transfo_post.abstrans(:,8:23)';
        trans_pre=transfo_pre.trans(:,:)';
        
        rvec_pre_norm=transfo_pre_norm.rvect(:,:)';
        rvec_pre=transfo_pre.rvect(:,:)';
        
        pcwrite(pointCloud(trans_pre_norm), dest_pre_norm_T);
        pcwrite(pointCloud(rvec_pre_norm), dest_pre_norm_R);
        
        pcwrite(pointCloud(trans_pre), dest_pre_T);
        pcwrite(pointCloud(rvec_pre), dest_pre_R);
        
        %% post
        
        Num_post = o32Num3D(sample_post);
        Num3D_post = axesvertebrescalc(Num_post);
        transfo_post= rigidtransfocalc(Num3D_post);
        transfo_post.trans = zeros(3,24);
        transfo_post.rvect = zeros(3,24);
        transfo_post_norm = transfo_post;
        
        [center_post vect]=axesextract(Num3D_post);
        center_post=center_post(:,7:24)'; 
        %center_post=center_post(:,:)';
        
        if strcmp(type_normalization,'LCN')
            curve_post=fnplt(cscvn(center_post(:,:)'));
            curve_post=curve_post';
            length_post=arclength(curve_post(:,1), curve_post(:,2), curve_post(:,3));
            center_post_normalized=center_post/length_post;
            center_post_normalized=[[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];center_post_normalized];
        end
        if strcmp(type_normalization,'MSN')
                mean_x= mean(center_post(:,1));
                mean_y= mean(center_post(:,2));
                mean_z= mean(center_post(:,3));
                std_x= std(center_post(:,1));
                std_y= std(center_post(:,2));
                std_z= std(center_post(:,3));
                x_norm_post=(abs(center_post(:,1)-mean_x))/std_x;
                y_norm_post=(abs(center_post(:,2)-mean_y))/std_y;
                z_norm_post=(abs(center_post(:,3)-mean_z))/std_z;
                center_post_normalized=[x_norm_post,y_norm_post,z_norm_post];
                center_post_normalized=[[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];center_post_normalized];
                center_post_normalized_= normalize(center_post);
          end
        center_post=[[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[0,0,0];center_post];
        
       if direction==1
            transfo_post_norm.transfolist=Num3D_pre.axelist((Num3D_pre.axelist(1:end-1)-Num3D_pre.axelist(2:end)==-1).*(1:length(Num3D_pre.axelist(1:end-1))));
            transfo_post_norm.transfolist=sort(transfo_post_norm.transfolist,'ascend');
            %j=1;
        end
        if direction==-1
            transfo_post_norm.transfolist=Num3D_pre.axelist((Num3D_pre.axelist(1:end-1)-Num3D_pre.axelist(2:end)==-1).*(1:length(Num3D_pre.axelist(1:end-1))))+1;
            transfo_post_norm.transfolist=sort(transfo_post_norm.transfolist,'descend');
            %j=size(center_pre_normalized,1);
        end

        % trans_pre=zeros(16,3);
        % for i=1:1:16
        %     trans_pre(i,:)=center_pre_normalized(i+direction*1,:)-center_pre_normalized(i,:);
        % end
        %j=1; 
        
        for i=transfo_post_norm.transfolist
            % Calcutation of the translation vector
%             if j==18 % 
%                 transfo_post_norm.abstrans(:,i)=[0 0 0];
%                 transfo_post.abstrans(:,i)=[0 0 0];
%             else
            transfo_post_norm.trans(:,i)=center_post_normalized(i+direction*1,:)-center_post_normalized(i,:);
            transfo_post.trans(:,i)=center_post(i+direction*1,:)-center_post(i,:);
%             end
            % Calculation of the rotation matrix input -> output
            R=Challismethod(reshape(vect(i,:,:),3,3),reshape(vect(i+direction*1,:,:),3,3));
            
            transfo_post_norm.rmat(i,:,:)=reshape(R,1,3,3);
            % Calculation of the rotation vector input -> output
            [transfo_post_norm.rvect(:,i) transfo_post_norm.rangle(i) transfo_post_norm.raxe(:,i)]=rmat2rvect(R);
            transfo_post.rvect(:,i)=transfo_post_norm.rvect(:,i);
%             transfo_post.rmat(i,:,:)=reshape(R,1,3,3);
%             % Calculation of the rotation vector input -> output
%             [transfo_post.rvect(:,i) transfo_post.rangle(i) transfo_post.raxe(:,i)]=rmat2rvect(R);
%             j=j+1;
        end
        
        %we apply here the inverse absolute rotation matrice in order to have the
        %translation vector in the local axes.
        for j=transfo_post_norm.transfolist
            transfo_post_norm.trans(:,j)=(reshape(transfo_post_norm.absrmat(j,:,:),3,3)^(-1))*transfo_post_norm.trans(:,j);
            transfo_post.trans(:,j)=(reshape(transfo_post.absrmat(j,:,:),3,3)^(-1))*transfo_post.trans(:,j);
            %if absolute translations-----------------------------------------
        end
        
        trans_post_norm=transfo_post_norm.trans(:,:)';
        %trans_post=transfo_post.abstrans(:,8:23)'
        rvec_post_norm=transfo_post_norm.rvect(:,:)';
        
        trans_post=transfo_post.trans(:,:)';
        %trans_post=transfo_post.abstrans(:,8:23)'
        rvec_post=transfo_post.rvect(:,:)';
        
        pcwrite(pointCloud(trans_post_norm), dest_post_norm_T);
        pcwrite(pointCloud(rvec_post_norm), dest_post_norm_R);
        
        pcwrite(pointCloud(trans_post), dest_post_T);
        pcwrite(pointCloud(rvec_post), dest_post_R);
        
        disp(['job is done for sample=' sample]);
        
    end
    
catch e
    fprintf(1,'There was an error! The message was:\n%s',e.message);
    disp(sample);
    fprintf(1,'chech data with ID=%s',sample);
end

