function [x, y, z]=gen_area(Scale,RNG,PointCount)
rng(RNG);
x=rand(1,PointCount)*Scale;
y=rand(1,PointCount)*Scale;
z=zeros(1,PointCount);   
if RNG==0.2    
pd = makedist('Normal','mu',Scale/2,'sigma',20); %нормальное распределение
x = random(pd,[1,PointCount]);
y = random (pd,[1,PointCount]);    
end
if RNG ==0.3
pd = makedist('Normal','mu',Scale/2,'sigma',100); %нормальное распределение
x = random(pd,[1,PointCount]);
y = random (pd,[1,PointCount]);   
end
if RNG==0.4
pd = makedist('Normal','mu',Scale/2,'sigma',140); %нормальное распределение
x = random(pd,[1,PointCount]);
y = random (pd,[1,PointCount]);      
end
end