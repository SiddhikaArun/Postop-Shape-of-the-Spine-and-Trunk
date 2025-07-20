%% save predicted as o3
clear all;
clc;
dir_Input= 'D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postoperative Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years';
dir_output= 'D:\1-Polymtl\1-Project\3-Coding-New\Obj-2-Prediction of Postopartive Shape of Spine\PPSS_Predcition_Postoperative_Spine_Shape\Codes\PPGP__(Preprocesing_Postprocessing_Geometric_Points)__Maryam\PPGP_V.1.0\Data\SJ0001333.o3';
input_sample = 'SJ0000110';
type_data='points'; %'translation';
if strcmp(type_data,'translation') 
 newNum3D=predicted_transfo2Num3D(dir_Input, input_sample);
else
 newNum3D=plytoNum3D(dir_Input, input_sample);
end
Num3D2o3(newNum3D,dir_output);