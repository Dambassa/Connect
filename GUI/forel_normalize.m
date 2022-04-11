function [] = forel_normalize(clusterCoord, clusterDots, data, clusterRad) 
figure('Name',string(data),'NumberTitle','off'); 
colors=colorset(size(clusterDots,3));
hold on
for i=1:1:size(clusterDots,3)
    color=colors(1,i);
    tempx(1,:)=clusterDots(:,1,i);
    tempy(1,:)=clusterDots(:,2,i);
    tempz(1,:)=clusterDots(:,3,i);
    dotsCount=clusterDots(1,4,i); 
    DrawLines([],[],0,[],dotsCount,[],tempx,tempy,tempz,color);
end
for i=1:size(clusterCoord,1)
circleCenter=[clusterCoord(i,1) clusterCoord(i,2)];
plot(circleCenter(1),circleCenter(2),'Marker','o','MarkerFaceColor','black','MarkerSize',10);
%viscircles(circleCenter,clusterRad,'Color','blue','LineWidth',1); 
end
hold off
end