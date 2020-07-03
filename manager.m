clear;
close all;

total_positive_good =  0;
total_positive_green =  0;
total_good = 0;
total_green = 0;

for counter = 1:12
    figure(1)
    subplot(3,4,counter);
    run("krzak/binary_tree")
    
    % run visual algo and recognise type of strawberry
    
    
    
    good_pict_list = dir("P_2_wizja_Artur/HSV_seg/good_std/*.jpg");
    rotten_pict_list = dir("P_2_wizja_Artur/HSV_seg/rotten_std/*.jpg");
    green_pict_list = dir("P_2_wizja_Artur/HSV_seg/green_std/*.jpg");
    n_good = length(good_pict_list);
    n_rotten = length(rotten_pict_list);
    n_green = length(green_pict_list);
    
    positive_good = 0;
    positive_green = 0;
    
    addpath './P_2_wizja_Artur/HSV_seg'
    
    for i = 1:size(good_strwber,1)
        current_filename = good_pict_list(randi(n_good,1));
        image = imread(strcat("P_2_wizja_Artur/HSV_seg/good_std/",current_filename.name));
        [good_present, green_present] = vision_algo(image);
        if (good_present == 1) positive_good = positive_good + 1; end
    end
    
    for i = 1:size(green_strwber,1)
        current_filename = green_pict_list(randi(n_green,1));
        image = imread(strcat("P_2_wizja_Artur/HSV_seg/green_std/",current_filename.name));
        [good_present, green_present] = vision_algo(image);
        if (green_present == 1) positive_green = positive_green + 1; end
    end
    
    for i = 1:size(rotten_strwber,1)
        current_filename = rotten_pict_list(randi(n_rotten,1));
        image = imread(strcat("P_2_wizja_Artur/HSV_seg/rotten_std/",current_filename.name));
        [good_present, green_present] = vision_algo(image);
    end
    
    total_good = total_good + size(good_strwber,1);
    total_green = total_green + size(green_strwber,1);
    
    if size(good_strwber,1) ~= 0
    percent_pos_good = positive_good/size(good_strwber,1)
    total_positive_good = total_positive_good + positive_good
    else percent_pos_good = -1
    end
    if size(green_strwber,1) ~= 0
    percent_pos_green = positive_green/size(green_strwber,1)
    total_positive_green = total_positive_green + positive_green
    else percent_pos_green = -1
    end
    
    title(sprintf("good: %i/%i\ngreen: %i/%i"...
        ,positive_good,size(good_strwber,1)...
        ,positive_green,size(green_strwber,1)));
    
end

total_percent_good = total_positive_good/total_good
total_percent_green = total_positive_green/total_green
sgtitle(sprintf("total good: %i/%i\ntotal green: %i/%i"...
    ,total_positive_good,total_good...
    ,total_positive_green,total_green));