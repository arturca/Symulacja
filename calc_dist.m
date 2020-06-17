function [dist_matrix] = calc_dist(temp)

dist_matrix = zeros(size(temp,1));

for i = 1:length(dist_matrix)
    for j = 1:length(dist_matrix)
        dist_matrix(i,j) = sqrt((temp(i,1)-temp(j,1))^2+(temp(i,2)-temp(j,2))^2+(temp(i,3)-temp(j,3))^2);
    end
end

end