function [matrix0] = OutOfArray (matrix0,FullRute)
a=size(matrix0);
    for i=1:1:length(FullRute)
            for j=1:1:a(1,1)
                matrix0(FullRute(i),j)=Inf;
            end    
    end
end