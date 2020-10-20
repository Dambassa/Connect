function [ProbabilityMatrix] = probability (priority,sigma,x,y,rad)
N=length(x); %количество элементов
format long
deltaX0=0.5;
deltaX1=0.5;
deltaY0=0.5;
deltaY1=0.5;
deltaZ0=0.5;
deltaZ1=0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ProbabilityMatrix=zeros(N,N);
i=1;
j=1;
while i<=N
j=1;
    while j<=N
        x0=x(1,i);
        y0=y(1,i);
        x1=x(1,j);
        y1=y(1,j);
        V=sqrt((x0+deltaX0-x1-deltaX1)^2+(y0+deltaY0-y1-deltaY1)^2+(z0+deltaZ0-z1+deltaZ1)^2);%ню по сути расстояние
        %a=V/sigma;
        %b=rad/sigma;
        %P=1-marcumq(a,b);
        if V>=rad
            c=10000;
        elseif (isempty(priority) || (priority(1,j)==0) || (priority(1,j)==1))
            E=exp(((-1)*(rad-V))/(sigma/2));
            P=1/(1+E);
            c=(-1)*log10(P); 
        else 
            E=exp(((-1)*(rad-V+(priority(1,j)*2)))/(sigma/2));
            P=1/(1+E);                       %придумать что сделать с приоритетами
            c=(-1)*log10(P); 
        end
        ProbabilityMatrix(i,j)=c;
        ProbabilityMatrix(j,i)=c;
        j=j+1;
    end
    i=i+1;
end
end

