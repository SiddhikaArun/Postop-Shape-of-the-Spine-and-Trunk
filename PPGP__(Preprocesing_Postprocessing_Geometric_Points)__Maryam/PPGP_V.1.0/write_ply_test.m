function write_ply(fname, vec, num)
% Written by Chenxi cxliu@ucla.edu
% Input: fname: output file name, e.g. 'data.ply'
%        P: 3*m matrix with the rows indicating X, Y, Z
%        C: 3*m matrix with the rows indicating R, G, B

%num = size(P, 2);
header = 'ply\n';
header = [header, 'format ascii 1.0\n'];
header = [header, 'comment VCGLIB generated\n'];
header = [header, 'element vertex ', num2str(num), '\n'];
header = [header, 'property double x\n'];
header = [header, 'property double y\n'];
header = [header, 'property double z\n'];
header = [header, 'end_header\n'];

% data = [P', double(C')];
data=[];
for i=1:num
    data = [data;vec];
end

fid = fopen(fname, 'w');
fprintf(fid, header);
dlmwrite(fname, data, '-append', 'delimiter', '\t', 'precision', 3);
fclose(fid);
