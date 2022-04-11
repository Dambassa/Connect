function [] = kmean_normalize(idx, C,x,y,z,data)
figure('Name',string(data),'NumberTitle','off'); 
Color=unique(idx);
Color1=colorset(size(Color,1));
%%формирование colormatrix
for i=1:size(idx,1)
    colormatrix(i)=Color1(1,idx(i,1));
end
%%
z=zeros(1,length(x));
hold on
DrawLines([],[],0,[],[],[],x,y,z,colormatrix);
for i=1:size(C,1)
plot(C(i,1),C(i,2),'Marker','o','MarkerFaceColor','black','Hittest','off','MarkerSize',10);
end
end