function [clusterCoord clusterDots] = Forel(x,y,z,clusterRad,scale)
clusterCoord=[];
clusterCount=0;

size=20;%размер сегмента
tempX=0;
tempY=0;
tempZ=0;
counter=1;

% segment=zeros([3 round(scale/size)]);
% for i=0:size:scale
% tempX=0;    
%     for j=0:size:scale
%         tempZ=0;
%         for k=0:size:scale
%             segment(1,counter)=tempX;
%             segment(2,counter)=tempY;
%             segment(3,counter)=tempZ;
%             tempZ=tempZ+size;
%             counter=counter+1;
%         end
%         tempX=tempX+size; 
%     end
% tempY=tempY+size;
% end


while ((~isempty(x))&&(~isempty(y)) && (~isempty(z)))
distance_matrix=zeros(length(x));

for i=1:length(x)%расстояние от одной до кажлой другой
    for j=1:length(x)
        distance_matrix(i,j)= sqrt((x(1,i)-x(1,j))^2+(y(1,i)-y(1,j))^2+(z(1,i)-z(1,j))^2);
    end
end

concMax=0;
for i=1:length(x)%поиск наибольшего сгущения точек
    conc=0;
    for j=1:length(x)
        if (distance_matrix(i,j)<=clusterRad)
            conc=conc+1;
        end
    end
    if (conc>=concMax)
        concMax=conc;
        cluster=i;
        tempCoord=[x(1,i) y(1,i) z(1,i)];%координаты центра кластера
    end
end
clusterCoord=cat(1,clusterCoord,tempCoord);

tempDelDots=[];
for i=1:length(x)%исключение уже покрытых точек
    if distance_matrix(cluster,i)<=clusterRad 
        tempDelDots=cat(2,tempDelDots,i);
    end
end

clusterCount=clusterCount+1;

for i=1:length(tempDelDots)
temp(1,i)=i;
end
    
clusterDots(temp(:),1,clusterCount)=x(tempDelDots(:));
clusterDots(temp(:),2,clusterCount)=y(tempDelDots(:));
clusterDots(temp(:),3,clusterCount)=z(tempDelDots(:));
clusterDots(1,4,clusterCount)=length(temp);
temp=[];
x(tempDelDots(:))=[];
y(tempDelDots(:))=[];
z(tempDelDots(:))=[];
end 
   
end

