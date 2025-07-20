function [ref_x, ref_y, ref_z]= extract_ref(Num3D)

Init;

% last vertebra translation reference (different system have differents
% absolute axes centres, so the origin is define as the lowest vertebra centre)
% % % % eval(['ref_1_x= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.x;']);
% % % % eval(['ref_1_y= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.y;']);
% % % % eval(['ref_1_z= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(1)) , '.z;']);
% % % % 
% % % % eval(['ref_2_x= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.x;']);
% % % % eval(['ref_2_y= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.y;']);
% % % % eval(['ref_2_z= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(2)) , '.z;']);
% % % % 
% % % % eval(['ref_3_x= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.x;']);
% % % % eval(['ref_3_y= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.y;']);
% % % % eval(['ref_3_z= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(3)) , '.z;']);
% % % % 
% % % % eval(['ref_4_x= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.x;']);
% % % % eval(['ref_4_y= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.y;']);
% % % % eval(['ref_4_z= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(4)) , '.z;']);
% % % % 
% % % % eval(['ref_5_x= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.x;']);
% % % % eval(['ref_5_y= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.y;']);
% % % % eval(['ref_5_z= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.z;']);
% % % % 
% % % % eval(['ref_6_x= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.x;']);
% % % % eval(['ref_6_y= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.y;']);
% % % % eval(['ref_6_z= Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.z;']);

eval(['refx=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.x+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.x)/2;']);
eval(['refy=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.y+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.y)/2;']);
eval(['refz=(Num3D.' , cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(6)) , '.z+Num3D.' ,cell2mat(Vertebres(Num3D.axelist(end))) , '.' , cell2mat(Landmarks(5)) , '.z)/2;']);
% 
% ref_x=[ref_1_x; ref_2_x; ref_3_x; ref_4_x; ref_5_x; ref_6_x];
% ref_x=[ref_1_y; ref_2_y; ref_3_y; ref_4_y; ref_5_y; ref_6_y];
% ref_z=[ref_1_z; ref_2_z; ref_3_z; ref_4_z; ref_5_z; ref_6_z];
ref_x=refx;
ref_y=refy;
ref_z=refz;



end