clear;
close all;

run("krzak/binary_tree")

% run visual algo and recognise type of strawberry

good_pict_list = dir("P_2_wizja_Artur/HSV_seg/good_std/*.jpg");
rotten_pict_list = dir("P_2_wizja_Artur/HSV_seg/rotten_std/*.jpg");
green_pict_list = dir("P_2_wizja_Artur/HSV_seg/green_std/*.jpg");
n_good = length(good_pict_list);
n_rotten = length(rotten_pict_list);
n_green = length(green_pict_list);


addpath './P_2_wizja_Artur/HSV_seg'

for i = 1:size(good_strwber,1)
   current_filename = good_pict_list(randi(n_good,1));
   image = imread(strcat("P_2_wizja_Artur/HSV_seg/good_std/",current_filename.name));
   [good_present, green_present] = vision_algo(image);
end

for i = 1:size(green_strwber,1)
   current_filename = green_pict_list(randi(n_green),1);
   image = imread(strcat("P_2_wizja_Artur/HSV_seg/green_std/",current_filename.name));
   [good_present, green_present] = vision_algo(image);
end

for i = 1:size(rotten_strwber,1)
   current_filename = rotten_pict_list(randi(n_rotten),1);
   image = imread(strcat("P_2_wizja_Artur/HSV_seg/rotten_std/",current_filename.name));
   [good_present, green_present] = vision_algo(image);
end

