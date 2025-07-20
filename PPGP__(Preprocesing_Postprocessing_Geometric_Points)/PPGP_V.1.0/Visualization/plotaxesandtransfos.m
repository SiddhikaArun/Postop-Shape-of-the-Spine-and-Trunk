function plotaxesandtransfos(Num3D,transfos)
% This function permits to plot the values of the local axes
% of each vertebra in the absolute coordinates and then the 
% rigid transfo (rotation matrice and translation vector) 
% and in a thrid window the rotation axe and angle.
%
% By Xavier Glorot August 2008
% xavier.glorot@cpe.fr

color=['r','b','c','g','m','y','k'];
type=['+','o','*','.','x','s','d','^','v','<','>','p','h'];

fig(1)=figure();
fig(2)=figure();
fig(3)=figure();


    clear vect centre transfo
    [centre vect]=axesextract(Num3D);
    
    figure(fig(1))
    t=mod(1,length(color));
    if t==0
        t=length(color);
    end
    p=mod(floor(1/length(color)),length(type));
    if p==0 
        p=length(type);
    end
    
    subplot(4,3,1)
    plot(Num3D.axelist,vect(Num3D.axelist,1,1),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('X.x');
    subplot(4,3,2)
    plot(Num3D.axelist,vect(Num3D.axelist,2,1),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('X.y');
    subplot(4,3,3)
    plot(Num3D.axelist,vect(Num3D.axelist,3,1),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('X.z');
    subplot(4,3,4)
    plot(Num3D.axelist,vect(Num3D.axelist,1,2),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('Y.x');
    subplot(4,3,5)
    plot(Num3D.axelist,vect(Num3D.axelist,2,2),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('Y.y');
    subplot(4,3,6)
    plot(Num3D.axelist,vect(Num3D.axelist,3,2),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('Y.z');
    subplot(4,3,7)
    plot(Num3D.axelist,vect(Num3D.axelist,1,3),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('Z.x');
    subplot(4,3,8)
    plot(Num3D.axelist,vect(Num3D.axelist,2,3),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('Z.y');
    subplot(4,3,9)
    plot(Num3D.axelist,vect(Num3D.axelist,3,3),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('Z.z');
    subplot(4,3,10)
    plot(Num3D.axelist,centre(1,Num3D.axelist),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('x');
    subplot(4,3,11)
    plot(Num3D.axelist,centre(2,Num3D.axelist),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('y');
    subplot(4,3,12)
    plot(Num3D.axelist,centre(3,Num3D.axelist),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Vertèbre N°');
    ylabel('z');
    
    figure(fig(2))
    indtransf=transfos.transfolist;
    subplot(4,3,1)
    plot(indtransf,transfos.rmat(indtransf,1,1),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xx yx');
    subplot(4,3,2)
    plot(indtransf,transfos.rmat(indtransf,2,1),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xx yy');
    subplot(4,3,3)
    plot(indtransf,transfos.rmat(indtransf,3,1),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xx yz');
    subplot(4,3,4)
    plot(indtransf,transfos.rmat(indtransf,1,2),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xy yx');
    subplot(4,3,5)
    plot(indtransf,transfos.rmat(indtransf,2,2),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xy yy');
    subplot(4,3,6)
    plot(indtransf,transfos.rmat(indtransf,3,2),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xy yz');
    subplot(4,3,7)
    plot(indtransf,transfos.rmat(indtransf,1,3),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xz yx');
    subplot(4,3,8)
    plot(indtransf,transfos.rmat(indtransf,2,3),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xz yy');
    subplot(4,3,9)
    plot(indtransf,transfos.rmat(indtransf,3,3),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('xz yz');
    subplot(4,3,10)
    plot(indtransf,transfos.trans(1,indtransf),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('x');
    subplot(4,3,11)
    plot(indtransf,transfos.trans(2,indtransf),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('y');
    subplot(4,3,12)
    plot(indtransf,transfos.trans(3,indtransf),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('z');
    
    figure(fig(3))
    subplot(2,2,1)
    plot(indtransf,transfos.raxe(1,indtransf),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('r axe x');
    subplot(2,2,2)
    plot(indtransf,transfos.raxe(2,indtransf),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('r axe y');
    subplot(2,2,3)
    plot(indtransf,transfos.raxe(3,indtransf),['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('r axe z');
    subplot(2,2,4)
    plot(indtransf,transfos.rangle(indtransf)/(2*pi)*360,['-', color(t),type(p)]);
    hold on
    grid on
    xlabel('Transition N°');
    ylabel('r angle');
    
    figure(fig(1))
legend(Folderslist.name,'Location','SouthEast')
figure(fig(2))
legend(Folderslist.name,'Location','SouthEast')
figure(fig(3))
legend(Folderslist.name,'Location','SouthEast')
clear fig color type t p Folderslist Folderpath path j indtransf %vect centre 

end

