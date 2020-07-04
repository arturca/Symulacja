clear;
close all;

total_positive_good =  0;
total_positive_green =  0;
total_good = 0;
total_green = 0;
total_picked = 0;
total_score = 0;

iterations = 50;

positive_good = zeros(1,iterations);
positive_green = zeros(1,iterations);

percent_pos_good = zeros(1,iterations);
percent_pos_green = zeros(1,iterations);

distance = zeros(1,iterations);

picked_on_bush = zeros(1,iterations);
score_on_bush = zeros(1,iterations);

for counter = 1:iterations
    counter
    figure(1)
    %subplot(2,5,mod(counter-1,5)+1 + 10*floor((counter-1)/5));
    run("krzak/binary_tree")
    
    % run visual algo and recognise type of strawberry
    
    
    
    good_pict_list = dir("P_2_wizja_Artur/HSV_seg/good_std/*.jpg");
    rotten_pict_list = dir("P_2_wizja_Artur/HSV_seg/rotten_std/*.jpg");
    green_pict_list = dir("P_2_wizja_Artur/HSV_seg/green_std/*.jpg");
    n_good = length(good_pict_list);
    n_rotten = length(rotten_pict_list);
    n_green = length(green_pict_list);
    
    
    to_pick = [];
    
    addpath './P_2_wizja_Artur/HSV_seg'
    addpath './Komiwojazer_dzialajacy/Komiwojazer'
    
    for i = 1:size(good_strwber,1)
        current_filename = good_pict_list(randi(n_good,1));
        image = imread(strcat("P_2_wizja_Artur/HSV_seg/good_std/",current_filename.name));
        [good_present, green_present] = vision_algo(image);
        if (good_present == 1) 
            positive_good(counter) = positive_good(counter) + 1;
            to_pick = [to_pick; good_strwber(i,1:3)];
        end
        chance_to_pick = 1 - good_strwber(i,4);
        if good_present & rand()<chance_to_pick %zbieramy
            picked_on_bush(counter) = picked_on_bush(counter) + 1;
            score_on_bush(counter) = score_on_bush(counter) + 10*good_strwber(i,4);
        end
    end
    
    for i = 1:size(green_strwber,1)
        current_filename = green_pict_list(randi(n_green,1));
        image = imread(strcat("P_2_wizja_Artur/HSV_seg/green_std/",current_filename.name));
        [good_present, green_present] = vision_algo(image);
        if (green_present == 1) 
            positive_green(counter) = positive_green(counter) + 1; 
        end
    end
    
    for i = 1:size(rotten_strwber,1)
        current_filename = rotten_pict_list(randi(n_rotten,1));
        image = imread(strcat("P_2_wizja_Artur/HSV_seg/rotten_std/",current_filename.name));
        [good_present, green_present] = vision_algo(image);
    end
    
    total_good = total_good + size(good_strwber,1);
    total_green = total_green + size(green_strwber,1);
    
    if size(good_strwber,1) ~= 0
    percent_pos_good(counter) = positive_good(counter)/size(good_strwber,1);
    total_positive_good = total_positive_good + positive_good(counter);
    else
        percent_pos_good(counter) = -1;
    end
    
    if size(green_strwber,1) ~= 0
    percent_pos_green(counter) = positive_green(counter)/size(green_strwber,1);
    total_positive_green = total_positive_green + positive_green(counter);
    else
        percent_pos_green(counter) = -1;
    end
    
    total_picked = total_picked + picked_on_bush(counter);
    total_score = total_score + score_on_bush(counter);
    
    title(sprintf("rozpoznane:\ngood: %i/%i green: %i/%i\nzebrane: %i/%i\nscore on bush: %1.2f"...
        ,positive_good(counter),size(good_strwber,1)...
        ,positive_green(counter),size(green_strwber,1)...
        ,picked_on_bush(counter),positive_good(counter)...
        ,score_on_bush(counter)));
    
    
    [distance(counter),route] = komi(to_pick,to_pick(1,:));
    %figure(1);
    %subplot(2,5,mod(counter-1,5)+1 + 10*floor((counter-1)/5) + 5);
    %plot3(route(:,1),route(:,2),route(:,3),'g');
    %daspect([1 1 1])
    %axis([-1 1 -1 1 -0.5 1])
    %title(sprintf("distance: %2.2f",distance));
end

total_percent_good = total_positive_good/total_good
total_percent_green = total_positive_green/total_green
sgtitle(sprintf("rozpoznane\ntotal good: %i/%i total green: %i/%i\n total picked: %i\ntotal score: %1.2f"...
    ,total_positive_good,total_good...
    ,total_positive_green,total_green...
    ,total_picked,total_score));