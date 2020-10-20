function [CheckMinDist, CheckWay]=CheckPointCalc(Start,Fin,reshufle,x,y,Rad)
%reshufle - все возможные перестановки
   
%x,y - соответствующие координаты всех точек
CheckMinDist=Inf;
k=size(reshufle);
a=k(1);
b=k(2);
for i=1:1:a
Dist=sqrt((x(Start)-x(reshufle(i,1)))^2+(y(Start)-y(reshufle(i,1)))^2);
 
    for j=1:1:(b-1)
        temp =sqrt((x(reshufle(i,j))-x(reshufle(i,j+1)))^2+(y(reshufle(i,j+1))-y(reshufle(i,j+1)))^2); 
        Dist=Dist+temp;   
    end
temp=sqrt((x(Fin)-x(reshufle(i,b)))^2+(y(Fin)-y(reshufle(i,b)))^2);
Dist=Dist+temp;%расстояние между конечной точкой и первой точкой из массива всех перестановок
if Dist<CheckMinDist 
    CheckMinDist=Dist;
    CheckWay=[Start reshufle(i,:) Fin];
end
end
end