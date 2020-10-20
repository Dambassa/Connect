function [] = DrawLines(Way,CheckPoint,cost,Start,Fin,FullRute,x,y,z,colormatrix)

rotate3d on
plot3(x(:),y(:),z(:),'o','MarkerEdgeColor','#ff7b00','Hittest','off');
StartColor = 'Green'; 
FinColor = 'Red'; 
LineColor = '#4800ff';
CheckPColor = '#4DBEEE';
RandomDotsColor = '#ffb845'; 

xOffset=zeros(1,length(FullRute));
yOffset=zeros(1,length(FullRute));
zOffset=zeros(1,length(FullRute));
for i=1:1:length(FullRute)
        switch FullRute(1,i)
            case num2cell(1:9)
                xOffset(1,i)=Way(1,i) -1.1;
                yOffset(1,i)=Way(2,i) +5;
            case num2cell(10:99)
                xOffset(1,i)=Way(1,i) -2;
                yOffset(1,i)=Way(2,i) +5;
            otherwise 
                xOffset(1,i)=Way(1,i)-3.8;
                yOffset(1,i)=Way(2,i) +5;
        end
end

for i=1:1:length(x)
    plot3(x(1,i),y(1,i),z(1,i),'Marker','o','MarkerFaceColor',colormatrix(1,i),'MarkerEdgeColor',RandomDotsColor,'Hittest','off','MarkerSize',11);
end

if cost == Inf
    plot3(x(1,Start),y(1,Start),z(1,Start),'Marker','o','MarkerFaceColor',StartColor,'Hittest','off','MarkerSize',11);
    plot3(x(1,Fin),y(1,Fin),z(1,Fin),'Marker','o','MarkerFaceColor',FinColor,'Hittest','off','MarkerSize',11);
    msgbox('Way beetwen this dots with this radius do not exist.');
elseif  isempty(CheckPoint)
    plot3(Way(1,:),Way(2,:),Way(3,:),'Color',LineColor,'Hittest','off');
    plot3(x(1,Start),y(1,Start),z(1,Start),'Marker','o','MarkerFaceColor',StartColor,'Hittest','off','MarkerSize',11);
    plot3(x(1,Fin),y(1,Fin),z(1,Fin),'Marker','o','MarkerFaceColor',FinColor,'Hittest','off','MarkerSize',11);
    text(xOffset(:),yOffset(:),zOffset(:),string(FullRute),'Fontsize',10,'Hittest','off');
else
    plot3(x(1,CheckPoint(1,:)),y(1,CheckPoint(1,:)),z(1,CheckPoint(1,:)),'o','MarkerFaceColor',CheckPColor,'Hittest','off','MarkerSize',11);
    plot3(Way(1,:),Way(2,:),Way(3,:),'Color',LineColor,'Hittest','off');
    plot3(x(1,Start),y(1,Start),z(1,Start),'Marker','o','MarkerFaceColor',StartColor,'Hittest','off','MarkerSize',11);
    plot3(x(1,Fin),y(1,Fin),z(1,Fin),'Marker','o','MarkerFaceColor',FinColor,'Hittest','off','MarkerSize',11);
    text(xOffset(:),yOffset(:),zOffset(:),string(FullRute),'Fontsize',10,'Hittest','off');
end

end