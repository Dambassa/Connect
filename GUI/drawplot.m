function [] = drawplot(x,y,z,data,cltype,colormatrix)
figure
hold on
title(data);
for i=1:1:length(x)
plot3(x(i),y(i),z(i),'Marker','o');
end
hold off
end