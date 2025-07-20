%% Extracting R and T from input data O3 %%%%%%%%%%%%%%%%
clc
clear

addpath '.\Calculation_Geometrices'
addpath '.\Calculation_Statistiques'
addpath '.\Commands'
addpath '.\Conversion'
addpath '.\Defination'
addpath '.\Extraction'
addpath '.\Visualization'
sample = 'SJ0000110';

sample_pre = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years\' sample '\o3\' sample '.pre.o3'];
sample_post = ['D:\1-Polymtl\1-Project\4-Data\Obj-2-Prediction of Postopartive Shape of Spine\AIS-PreparedData\3-Between 1 year and 2 years\' sample '\o3\' sample '.post.o3'];

Num = o32Num3D(sample_pre);
Num3D = axesvertebrescalc(Num);
transfo = rigidtransfocalc(Num3D);
