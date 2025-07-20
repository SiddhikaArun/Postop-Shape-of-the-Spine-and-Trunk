function newNum3D=predicted_transfo2Num3D(dir_folder_, input_sample)

% clc
% clear;
% close all;

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
sample = input_sample; %'SJ0001333';
%dir_folder='3-Between 1 year and 2 years';
%dir_folder='D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years';
dir_folder=dir_folder_;
%ascend means dir=1
%descend means dir=-1
dir=-1;

%% Extracting R and T from input data Num3D %%%%%%%%%%%%%%%%
sample_pre = [dir_folder '\' sample '\o3\' sample '.pre.o3'];
sample_post = [dir_folder '\' sample '\o3\' sample '.post.o3'];

% predicted_t = [dir_folder '\' sample '\T_R_ply\' sample '.pre_center_without_normilized_transfo_T.ply'];
% predicted_r = [dir_folder '\' sample '\T_R_ply\' sample '.pre_center_without_normilized_transfo_R.ply'];

predicted_t = [dir_folder '\' sample '\T_R_ply\' sample '.predicted_2_T_descend_CNN_Undirect_Cycle.ply'];
predicted_r = [dir_folder '\' sample '\T_R_ply\' sample '.predicted_1_R_descend_CNN_Undirect.ply'];


%% copy transform.trans as T and transform.rvect as R to an excel
%% write T and R in a .ply file with size 24*(T+R)=24*6
%% Run code python to predict T and R
%% Copy the result T and R into t and r in this file
%% Reverse: Adding R and T to pre to have post
%build transform structure for new R and T
%% 1- building transfo structure
%% read pre
NumPre =o32Num3D(sample_pre);
Num3D_Pre = axesvertebrescalc(NumPre);

NumPost =o32Num3D(sample_post);
Num3D_Post = axesvertebrescalc(NumPost);
% [centre vect]=axesextract(Num3D_Post);

%% read predicted t
t_= pcread(predicted_t);
t_vector_=t_.Location();
% % % % t=transform.trans;
% % % % t_vector_=[0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     -1.416058	-0.32846	-16.510702
% % % %     -1.173828	-2.320963	-17.737024
% % % %     -0.559527	0.148641	-18.971359
% % % %     0.402527	2.593618	-19.619709
% % % %     -0.817449	2.769774	-19.428617
% % % %     -1.268107	3.327823	-19.153406
% % % %     -0.518581	3.866414	-19.130907
% % % %     -2.134366	-0.111369	-21.888357
% % % %     -0.791173	1.52201	    -22.978689
% % % %     -0.007027	0.217692	-26.037016
% % % %     -0.481672	-0.495586	-25.564873
% % % %     -0.029651	-2.618585	-27.111385
% % % %     -1.551004	-2.471577	-27.47592
% % % %     -5.272481	0.435827	-28.963032
% % % %     -5.814138	4.415086	-30.245558
% % % %     -6.497099	3.577913	-28.581163
% % % %     0	0	0];
% if dir==-1
%     t_vector_=[
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%    -1.7148   -0.4443   19.1513		
%     0.2244   -0.4914   20.3071		
%     1.1097   -0.8849   21.5037		
%     1.1991   -0.2572   21.1236		
%     0.6386   -1.4201   21.3697		
%     0.2390    0.7679   21.2806		
%     0.4215    0.3873   22.5661		
%    -0.2991    0.3515   23.5594		
%     0.7433    0.9584   23.5009		
%     0.6996    0.8962   24.8483		
%    -1.0701    0.3070   27.1717		
%    -2.3429   -0.4455   29.9226		
%    -2.8581   -2.0458   32.2993		
%    -0.6533    0.2359   33.5988		
%    -3.5645   -3.9956   32.5573		
%    -4.8880    0.6237   36.8690		
%    -4.3139   -0.7382   35.1541			
%         ];
% else
%     t_vector_=[
%   0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%    -1.3179    0.0587  -19.1877		
%    -0.0813   -0.9223  -20.2932		
%    -0.7417   -0.3544  -21.5348		
%     1.2006    0.5396  -21.1182		
%     1.5192   -1.1185  -21.3432		
%     0.6866    1.2657  -21.2471		
%     0.4890   -1.1109  -22.5407		
%     1.0487   -0.3720  -23.5377		
%     0.0242    0.8311  -23.5175		
%     0.7655    1.0496  -24.8404		
%     0.9123    0.4837  -27.1749		
%     2.9272    0.8380  -29.8627		
%     0.1659    4.9123  -32.1161		
%     0.6361    1.3769  -33.5717		
%    -2.4607   -2.3429  -32.8193		
%    -2.1233   -3.4187  -36.9785		
%    -3.0422   -5.3063  -34.8935		
%          0         0         0			
%         ];
% end
%% read predicted r
r_= pcread(predicted_r);
r_vector_=r_.Location();
%r_vector_=-r_vector_;
% % % %r_vector=transform.rvect';
% % % % r_vector_= [0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     0	0	0
% % % %     -1.112561	0.96885	1.032656
% % % %     -1.200244	1.048095	1.010504
% % % %     -1.116964	0.93566	0.977213
% % % %     -0.885216	0.891744	0.997895
% % % %     -0.880316	0.85753	0.976524
% % % %     -0.812946	1.022735	1.038771
% % % %     -0.748311	0.876288	1.011889
% % % %     -1.042043	1.064096	1.017298
% % % %     -0.97958	0.889734	1.267353
% % % %     -1.091174	1.019027	1.044195
% % % %     -1.169656	0.992311	0.914113
% % % %     -1.354779	0.973342	0.989663
% % % %     -1.221017	0.960276	0.992727
% % % %     -1.015631	1.248443	0.913255
% % % %     -0.881944	1.220266	0.756166
% % % %     -0.914334	1.260637	0.887229
% % % %     0	0	0
% % % %     ];
% if dir==-1
%     r_vector_= [
%      0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%     0.0231   -0.1600    0.0129		
%     0.0521    0.0139   -0.1018		
%     0.0810    0.0199    0.1154		
%    -0.0143    0.1129   -0.0285		
%     0.1193    0.1032    0.0758		
%    -0.0906    0.0483   -0.0241		
%     0.0290    0.0431    0.0487		
%    -0.0053    0.0380    0.0512		
%    -0.0679    0.0436   -0.0183		
%    -0.0490    0.0676   -0.0903		
%    -0.0180   -0.0024   -0.0377		
%    -0.0132    0.0198    0.0004		
%    -0.0781   -0.0744   -0.0565		
%    -0.0243    0.0168   -0.0968		
%     0.2079   -0.1652    0.0152		
%     0.0903   -0.1810    0.0210		
%     0.1904   -0.1887    0.0449					
%         ];
% else
%     %dir=1
%     r_vector_= [
%     0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%          0         0         0		
%    -0.0231    0.1600   -0.0129		
%    -0.0521   -0.0139    0.1018		
%    -0.0810   -0.0199   -0.1154		
%     0.0143   -0.1129    0.0285		
%    -0.1193   -0.1032   -0.0758		
%     0.0906   -0.0483    0.0241		
%    -0.0290   -0.0431   -0.0487		
%     0.0053   -0.0380   -0.0512		
%     0.0679   -0.0436    0.0183		
%     0.0490   -0.0676    0.0903		
%     0.0180    0.0024    0.0377		
%     0.0132   -0.0198   -0.0004		
%     0.0781    0.0744    0.0565		
%     0.0243   -0.0168    0.0968		
%    -0.2079    0.1652   -0.0152		
%    -0.0903    0.1810   -0.0210		
%    -0.1904    0.1887   -0.0449		
%          0         0         0				
%         ];
% end
r_mat_ = zeros(24,3,3);
%r_mat_post = zeros(16,3,3);
%for i = 1:23
for i = 1:24
    r = rvect2rmat(r_vector_(i,:));
    r_mat_(i,:,:) = reshape(r,1,3,3);
end

% %%
% [center_pre vect]=axesextract(Num3D_Pre);
% center_pre=center_pre(:,8:24)';
% 
% curve_pre=fnplt(cscvn(center_pre(:,:)'));
% curve_pre=curve_pre';
% length_pre=arclength(curve_pre(:,1), curve_pre(:,2), curve_pre(:,3));

%% %%%%%Extra: if we want to have normilized data
% Num_pre_normalized = o32Num3D_Normalized(sample_pre, length_pre);
% Num3D_pre_normalized = axesvertebrescalc(Num_pre_normalized); %% subtract from ref is done inside this file
% newtransfo = rigidtransfocalc(Num3D_pre_normalized,0,0,dir);
%% %%%%%

%% compute transfo for t and r
% t_vector_post=t_vector_*length_pre;
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

[centre_1 vect_1]=axesextract(newNum3D);
[centre vect]=axesextract(Num3D_Pre);

%% to draw the shapes
% plotvertebresaxes(newNum3D)
% plotvertebresaxes(Num3D_Post)
% plotvertebresaxes(Num3D_Pre)


% curve_pre=fnplt(cscvn(centre_1(:,:)));
% points=pointCloud(curve_pre');
% pointscolor=uint8(zeros(points.Count,3));
% %pointscolor=uint8(zeros(data_predicted_center.Count,3));
% pointscolor(:,1)=255;
% pointscolor(:,2)=255;
% pointscolor(:,3)=51;
% points.Color=pointscolor;
% pcshow(points);
% % data_predicted_center.Color=pointscolor;
% % pcshow(data_predicted_center);
% hold on;
% L=legend('\color{blue}preoperative shape','\color{red}real postoperative shape','\color{yellow}predicted postoperative shape');




