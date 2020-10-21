function [sigma] = findSigma(anySigmaRute,Rad)
a=size(anySigmaRute,1);
b=size(anySigmaRute,2);
minSigma=Inf;
    for i=5:Rad
        if (anySigmaRute(i,b)~=0) && (anySigmaRute(i,b)<=minSigma)
            minSigma=anySigmaRute(i,b);
            sigma(1,1)=i;
        end
    end
    minSigma=Inf;
    for i=Rad:round(Rad*2)
        if (anySigmaRute(i,b)~=0) && (anySigmaRute(i,b)<=minSigma)
            minSigma=anySigmaRute(i,b);
            sigma(1,2)=i;
        end
    end
    minSigma=Inf;
    for i=round(Rad*2):round(Rad*4)
        if (anySigmaRute(i,b)~=0) && (anySigmaRute(i,b)<=minSigma)
            minSigma=anySigmaRute(i,b);
            sigma(1,3)=i;
        end
    end
    minSigma=Inf;
    for i=round(Rad*4):round(Rad*6)
        if (anySigmaRute(i,b)~=0) && (anySigmaRute(i,b)<=minSigma)
            minSigma=anySigmaRute(i,b);
            sigma(1,4)=i;
        end
    end 
sigma(1,5)=Rad*10;
end

