function ripness = check_ripness(list_of_pixel, rgb_im)
    gray_img = rgb2gray(rgb_im);    
%     gray_img = blur(gray_img,10);

    green_val = 200.0;
    red_val = 100.0;
    diff = green_val-red_val;
    sum_of_s = double(0.0);
    for i=1:size(list_of_pixel)
        row = list_of_pixel(i,1);
        col = list_of_pixel(i,2);
        sum_of_s = sum_of_s + double(gray_img(col, row));
    end
    sum_of_s = double(sum_of_s);
    ripness = 1-(sum_of_s-size(list_of_pixel)*red_val)/(size(list_of_pixel)*diff);
end