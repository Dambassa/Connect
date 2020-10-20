function [colormatrix] = colorPriority(priority)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for i=1:1:length(priority)
    switch priority(1,i)
        case 2
          colormatrix(1,i)="#e6fffd";   
        case 3
           colormatrix(1,i)="#ccfffa";  
        case 4
           colormatrix(1,i)="#b3fff8";  
        case 5
           colormatrix(1,i)="#92fcf2";  
        case 6
           colormatrix(1,i)="#77f2e6";  
        case 7
           colormatrix(1,i)="#51e8d9";  
        case 8
           colormatrix(1,i)="#34d9c9"; 
        case 9
            colormatrix(1,i)="#1ac9b8";
        case 10
            colormatrix(1,i)="#009183";
        otherwise 
            colormatrix(1,i)="#ffffff";
    end
end

