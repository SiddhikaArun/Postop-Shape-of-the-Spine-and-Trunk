function plotvertebresaxes(Num3D,varargin)
%this function permits to draw the local vertebra axes of a Num3D structure
%the first argument is the axes limites of the plot(define as for the axes() 
%function).The second argument is the normalisation of the axes to make 
%them more visible(by default 20) 
%
% By: Xavier Glorot August 2008
% xavier.glorot@cpe.fr

scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(1) scrsz(2) int16(scrsz(3)/1.003) int16(scrsz(4)/1.08 ) ]);
Init;

axeslim=[-inf,inf,-inf,inf,-inf,inf];
N=20;
if nargin>=2
    axeslim=cell2mat(varargin(1));
    if nargin>=3
        N=cell2mat(varargin(2));
    end
end

[centre vect]=axesextract(Num3D);
xlabel('X absolute');
ylabel('Y absolute');
zlabel('Z absolute');
for i=Num3D.axelist
    lx=line([centre(1,i) centre(1,i)+N*vect(i,1,1)],[centre(2,i) centre(2,i)+N*vect(i,2,1)],[centre(3,i) centre(3,i)+N*vect(i,3,1)],'Color','r');
    ly=line([centre(1,i) centre(1,i)+N*vect(i,1,2)],[centre(2,i) centre(2,i)+N*vect(i,2,2)],[centre(3,i) centre(3,i)+N*vect(i,3,2)],'Color','g');
    lz=line([centre(1,i) centre(1,i)+N*vect(i,1,3)],[centre(2,i) centre(2,i)+N*vect(i,2,3)],[centre(3,i) centre(3,i)+N*vect(i,3,3)],'Color','b');
end
xlabel('X absolute');
ylabel('Y absolute');
zlabel('Z absolute');
view(30,30)
grid on;
axis(axeslim)
set(gca,'XLimMode','manual','YLimMode','manual','ZLimMode','manual','DataAspectRatioMode','manual','DataAspectRatio',[1 1 1]);
legend([lx ly lz],{'Local vertebra axe X','Local vertebra axe Y','Local vertebra axe Z'})
pos=get(gca,'Position');


for v=1:length(Num3D.axelist)

    tb=annotation('textbox',[pos(1)*0.25 pos(4)+pos(2)-v*(pos(4))/(length(Num3D.axelist)) pos(1)*0.75 (pos(4)-pos(2))/length(Num3D.axelist)]);
    set(tb,'FitHeightToText','on','HorizontalAlignment','center','VerticalAlignment','middle')

    strin=cell2mat(Vertebres(Num3D.axelist(v)));
    indstr=findstr(strin,'Vertebre_');
    strin(indstr(1)+8)=' ';

    set(tb,'String',strin);
end