function [clusterCoord clusterDots] = Forel(x,y,clusterRad,scale)
clusterCoord=[];
size=5;%размер сегмента
clusterCount=0;

tempX=0;
tempY=0;
counter=1;
segment=zeros([2 round(scale/size)]);
for i=0:size:scale
tempX=0;    
    for j=0:size:scale
        segment(1,counter)=tempX;
        segment(2,counter)=tempY;
        tempX=tempX+size;
        counter=counter+1;
    end
tempY=tempY+size;
end


while (~isempty(x))&&(~isempty(y))
matrix=zeros(length(x));

for i=1:length(segment)%расстояние от сегментов до всех точек
    for j=1:length(x)
        matrix(i,j)= sqrt((segment(1,i)-x(1,j))^2+(segment(2,i)-y(1,j))^2);
    end
end


concMax=0;
for i=1:length(segment)%поиск наибольшего сгущения точек
    conc=0;
    for j=1:length(x)
        if (matrix(i,j)<=clusterRad)
            conc=conc+1;
        end
    end
    if (concMax<=conc)
        concMax=conc;
        cluster=i;
        tempCoord=[segment(1,i) segment(2,i)];%координаты центра кластера
    end
end
clusterCoord=cat(1,clusterCoord,tempCoord);

tempDelDots=[];
for i=1:length(x)%исключение уже покрытых точек
    if matrix(cluster,i)<=clusterRad 
        tempDelDots=cat(2,tempDelDots,i);
    end
end

clusterCount=clusterCount+1;

for i=1:length(tempDelDots)
temp(1,i)=i;
end
    
clusterDots(temp(:),1,clusterCount)=x(tempDelDots(:));
clusterDots(temp(:),2,clusterCount)=y(tempDelDots(:));
clusterDots(1,3,clusterCount)=length(temp);
temp=[];
x(tempDelDots(:))=[];
y(tempDelDots(:))=[]; 
end 
   
end

