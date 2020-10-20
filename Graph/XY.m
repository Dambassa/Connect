function [ X, Y, N ] = XY( Rad, Factor )
i=0;
j=0;
a=0;
 FloatVertDotCount = Factor/Rad;    %Количество точек по вертикали
 IntVertDotCount = FloatVertDotCount - fix(FloatVertDotCount);
 if (IntVertDotCount > 0)
    IntVertDotCount = FloatVertDotCount - IntVertDotCount+1;
 else
     IntVertDotCount = FloatVertDotCount;
 end
Rad=Factor/IntVertDotCount;
 N = 1;
 while (i<=Factor && j<=Factor)
     X(N) = i;
     Y(N) = j;
     i = i+Rad;
     if (i>Factor && j<Factor)
         i=0;
         j=j+Rad;
     end
     N=N+1;
 end 
 N=N-1;    %Пожилой костыль
end
