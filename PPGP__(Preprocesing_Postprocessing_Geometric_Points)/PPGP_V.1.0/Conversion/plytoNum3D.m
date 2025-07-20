function  newNum3D = plytoNum3D(dir_Input, input_sample)

Init;
source_predicted = [dir_Input '\' input_sample '\points-PLY\predicted\' input_sample '.ply'];
source_pre = [dir_Input '\' input_sample '\o3\' input_sample '.pre.o3'];

predicted_landmarks= pcread(source_predicted);
vector=predicted_landmarks.Location();

newNum3D=o32Num3D(source_pre);
i=7; % start from Vertebre_C7
% 6 landmarks per vertebra: Ped_Inf_D, Ped_Inf_G, Ped_Sup_D, Ped_Sup_G, Plat_Inf_Cent, Plat_Sup_Cent
for k=1:6:102
    index=k;
    for j=1:6;
        eval(['Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.x=', num2str(vector(index,1)),';']);
        eval(['Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.y=', num2str(vector(index,2)),';']);
        eval(['Num3D.' , cell2mat(Vertebres(i)) , '.' , cell2mat(Landmarks(j)) , '.z=', num2str(vector(index,3)),';']);
    index=index+1;
    end
    i=i+1;
end

newNum3D;