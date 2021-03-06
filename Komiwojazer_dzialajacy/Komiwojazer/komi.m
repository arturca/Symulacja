%data - punkty w 3D
%startpoint - punkt startowy
%distance - koszt trasy optymalnej
%route - optymalna trasa
function [distance,route] = komi(data,startpoint) 
xyz = [startpoint; data];
userConfig = struct('xy',xyz);
resultStruct = tsp_ga(userConfig);
for i=1:length(resultStruct.optRoute)
        if resultStruct.optRoute(i)==1
            s = i;
        end
end
distance = resultStruct.minDist;
route = zeros(length(resultStruct.optRoute)+1,3);
if s==1
   for i=1:length(resultStruct.optRoute)
        route(i,:) = xyz(resultStruct.optRoute(i),:);
   end
else    
    for i=1:length(resultStruct.optRoute)-s+1
        route(i,:) = xyz(resultStruct.optRoute(s+i-1),:);
    end
    for i=length(resultStruct.optRoute)-s+2:length(resultStruct.optRoute)
        route(i,:) = xyz(resultStruct.optRoute(i-length(resultStruct.optRoute)+s-1),:);
    end
end

route(length(resultStruct.optRoute)+1,:) = startpoint;

end
