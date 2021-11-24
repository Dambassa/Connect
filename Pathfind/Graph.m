function [Matrix] = Graph(priority,x,y,z,Rad)                 %i - индекс исследуемой точки; j - индекс точки до которой ищем расстояние
N=length(x);
Matrix = zeros(N, N);     % матрица нулей заданного размера
for i=1:1:(N)
    for j=1:1:(N)
        d = sqrt((x(i)-x(j))^2 + (y(i) - y(j))^2+(z(i)-z(j))^2);
        if (d>=Rad)
            Matrix(i,j)=Inf;
            Matrix(j,i)=Inf;
        elseif isempty(priority)
            Matrix(i,j)=d;
            Matrix(j,i)=d;
        elseif priority(1,j)==0 || priority(1,j)==1
            Matrix(i,j)=d*0.00001;
            Matrix(j,i)=d*0.00001;
        else  
            Matrix(i,j)=d*(exp(priority(1,i)*0.4));
            Matrix(j,i)=d*(exp(priority(1,i)*0.4));
        end
    end
end
end

