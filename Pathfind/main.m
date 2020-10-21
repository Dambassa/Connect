function [cost,FullRute]=main(x,y,z,priority,Start,Fin,Rad,Sigma,CheckPoint)
if ~isempty(CheckPoint)
    reshufle=perms(CheckPoint);
    [CheckMinDist,CheckWay]= CheckPointCalc(Start,Fin,reshufle,x,y,z,Rad);
    if Sigma==0
        [matrix]=Graph(priority,x,y,z,Rad);%norm
    else
        [matrix]=probability(priority,Sigma,x,y,z,Rad);%norm
    end
    %%%%%%%%%%%%%%%%%
    matrix0=matrix;
    FullRute=[];
    %%%%%%%%%%%%%%%%%
    for i=1:1:(length(CheckWay)-1)
        [cost, rute] = dijkstra(matrix0,CheckWay(i+1),CheckWay(i));
        if cost==Inf
            FullRute=[1 2];%фиктивный путь
            break
        end
        FullRute=cat(2,FullRute,rute);%объединение массивов
        matrix0=OutOfArray(matrix0,FullRute);%исключение пройденных точек из возможного пути 
    end 
elseif isempty(CheckPoint)
    if Sigma==0
        [matrix]=Graph(priority,x,y,z,Rad);
    else
        [matrix]=probability(priority,Sigma,x,y,z,Rad);
    end
    [cost, FullRute] = dijkstra(matrix,Fin,Start);
    assignin('base','Full',FullRute);   
end
end
