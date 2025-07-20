function [Num3D] = o32Num3D_Normalized(Filepath,length_curve)
%This function permits to create a Num3D structure from a .o3 file.
%specified with the Filepath argument
%
% Num3D struct:
%
%  For the fields specified between { } please refer to the Init.m
%  Warning: the order of definition is important, it must follow the
%           following order (for the {Vertebres} fields they must be ascent)
%
%        .axelist -> index of the existing Vertebra's number (see Init.m)
%        .Filepath -> path of the linked File (.o3 or .xo2)
%        .Name -> name of the linked file alone
%        .instrum -> information over the instrumentation  [empty if no information]
%                    (0 -> level not instrumented, 1 level instrumented)
%        .apex -> relative position vector of the apical vertebrae (hard-coded at the moment)
%                 (0= apical +/-n= offset to closer apical) [empty if no information]
%        other no struct fields -> other complementary information present in the file
%        .{Vertebres}.{Landmarks}.x -> absolute x position of the {Vertebres}'s {Landmarks}
%        .{Vertebres}.{Landmarks}.y -> absolute y position of the {Vertebres}'s {Landmarks}
%        .{Vertebres}.{Landmarks}.z -> absolute z position of the {Vertebres}'s {Landmarks}
%        .{Vertebres}.{Landmarks}.err -> err of the {Vertebres}'s {Landmarks}
%        .{Vertebres}.{Landmarks}.src -> src of the {Vertebres}'s {Landmarks}
%
% By: Xavier Glorot June 2008
% xavier.glorot@cpe.fr

% Initialisation
Init;

% Open the o3 
%Filepath ='D:\1-Polymtl\Project\Coding\SIRT\archive_Xavier_Glorot\SIRT V1.0\Test\'
fid=fopen(Filepath);

% First Num3D fields definitions 
Num3D.axelist=[];
Num3D.Filepath=Filepath;
index=findstr(Filepath,'\');
Num3D.Name=Filepath(index(end)+1:end-3);

Num3D.instrum=[];
Num3D.apex=[];
instrum=instrumentationdef;
for i=1:length(instrum)
    if strcmp(Num3D.Name,instrum(i).name)
        Num3D.instrum=instrum(i).niv;
        Num3D.apex=instrum(i).apex;
    end
end


%C = fgetl(fid);
C = fgets(fid);

% Read the file line by line
while isempty(C) || C(1)~=-1
    if length(C)>6
        index=findstr(C,':');
        % Complementary information
        if ~isempty(index) && ~strcmp(C(1:7),'Grid_3D') && ~strcmp(C(1:7),'Line_3D') && ~strcmp(C(1:5),'Objet')
            [tag,text]=strtok(C);
            C = fgetl(fid);
            while ~isempty(C)
                text=[text C]; %#ok<AGROW>
                C = fgetl(fid);
            end
            text(findstr(text,['''']))=' ';
            eval(['Num3D.' , tag(1:end-1) , '=''' , text , ''';']);
        else
            %new Num3D field
            if strcmp(C(1:6),'Objet:')
                Objet=C(8:end);
                %suppress the '-' and ' ' from the Projection field to be compatible
                %with Matlab structures
                Objet(findstr(Objet,' '))=[]; 
                Objet(findstr(Objet,'-'))=[];
                if strcmp(Objet(1),'_')
                    Objet(1)=[];
                end
                if length(Objet)>=10
                    for ii=1:length(Vertebres)
                        if strcmp(Objet(1:end), cell2mat(Vertebres(ii)))
                            Num3D.axelist=[Num3D.axelist ii];
                        end
                    end
                end
                fgetl(fid);
                C = fgetl(fid);
                
                %read the x y z err src values for each tag
                while ~isempty(C) && C(1)~=-1
                    [tag,C]=strtok(C);
                    tag(find(tag=='-'))=[];
                    [x,C]=strtok(C);
                    [y,C]=strtok(C);
                    [z,C]=strtok(C);
                    if ~isempty(C) % if err field
                        [err,C]=strtok(C);
                        if ~isempty(C) % if src field
                            [src,C]=strtok(C);
                        else
                            src=[];
                        end
                    else
                        err=[];
                    end
                    if isstrprop(tag, 'digit')
                        tag=['Nb' tag]; %#ok<AGROW>
                         % Conversion to the Matlab struct for the Côtes Landmarks from 1,2... to Nb1,Nb2...
                         % to be compatible to Matlab structure  
                    end
                    % Save in the Num3D
                    % Normilized based on the length of curve spine which is made by centers
                    x_normalized=str2num(x)/length_curve;
                    y_normalized=str2num(y)/length_curve;
                    z_normalized=str2num(z)/length_curve;
                    eval(['Num3D.',Objet,'.',tag,'.x=',num2str(x_normalized),';']);
                    eval(['Num3D.',Objet,'.',tag,'.y=',num2str(y_normalized),';']);
                    eval(['Num3D.',Objet,'.',tag,'.z=',num2str(z_normalized),';']);
                    if ~isempty(err)
                        eval(['Num3D.',Objet,'.',tag,'.err=',err,';']);
                        if ~isempty(src)
                            if ischar(src)
                                eval(['Num3D.',Objet,'.',tag,'.src=''',src,''';']);
                            else
                                eval(['Num3D.',Objet,'.',tag,'.src=',src,';']);
                            end
                        end
                    end
                    C = fgetl(fid);
                end
            end
        end
    end
    C = fgetl(fid);
end

% Close the file
fclose(fid);