clear;
close all;
good_list = dir("good/*.jpg");
rotten_list = dir("rotten/*.jpg");
green_list = dir("green/*.jpg");
n_good = length(good_list);
n_rotten = length(rotten_list);
n_green = length(green_list);

for i = 1:n_good
   current_filename = good_list(i);
   current_image = imread(strcat("good/",current_filename.name));
   current_image = imresize(current_image,[636, 1024]);
   imwrite(current_image, sprintf('good_std/good_%i.jpg',i));
end

for i = 1:n_rotten
   current_filename = rotten_list(i);
   current_image = imread(strcat("rotten/",current_filename.name));
   current_image = imresize(current_image,[636, 1024]);
   imwrite(current_image, sprintf('rotten_std/rotten_%i.jpg',i));
end

for i = 1:n_green
   current_filename = green_list(i);
   current_image = imread(strcat("green/",current_filename.name));
   current_image = imresize(current_image,[636, 1024]);
   imwrite(current_image, sprintf('green_std/green_%i.jpg',i));
end