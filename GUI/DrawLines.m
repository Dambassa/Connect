function [] = DrawLines(Way,CheckPoint,cost,Start,Fin,FullRute,x,y,z,colormatrix)

grid on

StartColor = 'Green'; 
FinColor = 'Red'; 
LineColor = '#4800ff';
CheckPColor = '#4DBEEE';
RandomDotsColor = '#ffb845';
Textsize=9;
Markersize=11;


if (isempty(FullRute) && isempty(Way)) 
    FullRute=zeros(1,length(x));
    Way=zeros(3,length(x));
    for i=1:1:length(x)
        Way(1,i)=x(1,i);
        Way(2,i)=y(1,i);
        Way(3,i)=z(1,i);
        FullRute(1,i)=i;
    end    
end

xOffset=zeros(1,length(FullRute));
yOffset=zeros(1,length(FullRute));
zOffset=zeros(1,length(FullRute));
for i=1:1:length(FullRute)
        switch FullRute(1,i)
            case num2cell(1:9)
                xOffset(1,i)=Way(1,i) -1.5;
                yOffset(1,i)=Way(2,i) +0.2;
                zOffset(1,i)=Way(3,i) +10;
            case num2cell(10:99)
                xOffset(1,i)=Way(1,i) -3;
                yOffset(1,i)=Way(2,i) +0.5;
                zOffset(1,i)=Way(3,i) +10;
            otherwise 
                xOffset(1,i)=Way(1,i)-5;
                yOffset(1,i)=Way(2,i) +1;
                zOffset(1,i)=Way(3,i) +10;
        end
end

if  size(colormatrix,2)==1
    color="#" + string(dec2hex(colormatrix,6));
    color=char(color);
    for i=1:1:Fin
        plot3(x(1,i),y(1,i),z(1,i),'Marker','o','MarkerFaceColor',  color,'MarkerEdgeColor',RandomDotsColor,'Hittest','off','MarkerSize',Markersize);
    end
else   
    plot3(x(:),y(:),z(:),'o','MarkerEdgeColor','#ff7b00','Hittest','off');
    for i=1:1:length(x)
        plot3(x(1,i),y(1,i),z(1,i),'Marker','o','MarkerFaceColor',colormatrix(1,i),'MarkerEdgeColor',RandomDotsColor,'Hittest','off','MarkerSize',Markersize);
    end
end

if cost == Inf
    plot3(x(1,Start),y(1,Start),z(1,Start),'Marker','o','MarkerFaceColor',StartColor,'Hittest','off','MarkerSize',Markersize);
    plot3(x(1,Fin),y(1,Fin),z(1,Fin),'Marker','o','MarkerFaceColor',FinColor,'Hittest','off','MarkerSize',Markersize);
    msgbox('Way beetwen this dots with this radius do not exist.');
elseif cost==0
elseif (isempty(Start) && isempty(Fin))
    text(xOffset(:),yOffset(:),zOffset(:),string(FullRute),'Fontsize',7,'Hittest','off');
elseif  isempty(CheckPoint)
    plot3(Way(1,:),Way(2,:),Way(3,:),'Color',LineColor,'Hittest','off');
    for i=1:1:length(Way)
        plot3(Way(1,i),Way(2,i),Way(3,i),'Marker','o','MarkerFaceColor',colormatrix(1,i),'MarkerEdgeColor',RandomDotsColor,'Hittest','off','MarkerSize',Markersize);
    end
    plot3(x(1,Start),y(1,Start),z(1,Start),'Marker','o','MarkerFaceColor',StartColor,'Hittest','off','MarkerSize',Markersize);
    plot3(x(1,Fin),y(1,Fin),z(1,Fin),'Marker','o','MarkerFaceColor',FinColor,'Hittest','off','MarkerSize',Markersize);
    text(xOffset(:),yOffset(:),zOffset(:),string(FullRute),'Fontsize',Textsize,'Hittest','off');
elseif ~isempty(CheckPoint) 
    plot3(Way(1,:),Way(2,:),Way(3,:),'Color',LineColor,'Hittest','off');
    for i=1:1:length(Way)
        plot3(Way(1,i),Way(2,i),Way(3,i),'Marker','o','MarkerFaceColor',colormatrix(1,i),'MarkerEdgeColor',RandomDotsColor,'Hittest','off','MarkerSize',Markersize);
    end
    plot3(x(1,CheckPoint(1,:)),y(1,CheckPoint(1,:)),z(1,CheckPoint(1,:)),'o','MarkerFaceColor',CheckPColor,'Hittest','off','MarkerSize',Markersize);
    plot3(x(1,Start),y(1,Start),z(1,Start),'Marker','o','MarkerFaceColor',StartColor,'Hittest','off','MarkerSize',Markersize);
    plot3(x(1,Fin),y(1,Fin),z(1,Fin),'Marker','o','MarkerFaceColor',FinColor,'Hittest','off','MarkerSize',Markersize);
    text(xOffset(:),yOffset(:),zOffset(:),string(FullRute),'Fontsize',Textsize,'Hittest','off');
end

end