function [Index] = FindCoord(x,y,pt)
    pt=[pt(1,1) pt(1,2)]; %берутся только 2 координаты из того  что выдаёт функция
    coordinates=[x(:),y(:)];%матрица всех координат
for i=1:1:length(x)
dist(1,i)=sqrt((pt(1,1)-coordinates(i,1))^2+(pt(1,2)-coordinates(i,2))^2);
end
[~, Index] = min(dist);
coordinateSelected = coordinates(Index,:);
end
