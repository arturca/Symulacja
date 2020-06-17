function ripness = ripness_checker(img_of_fruit)
    img_of_fruit = rgb2gray(img_of_fruit);

%     figure(1)
%     imshow(img_of_fruit, [])
    % Average filter
    h = ones(6,6)/25;
    img_of_fruit = imfilter(img_of_fruit,h, 'replicate');
    
    figure(2)
    [rows, cols] = size(img_of_fruit);
    
    red_val = mean(max(max(img_of_fruit(uint16(rows*0.2):uint16(rows-rows*0.2), uint16(cols*0.2):uint16(cols-cols*0.2)))));

%     nn = uint16([size(img_of_fruit,1)*0.25,size(img_of_fruit,1)*0.75, size(img_of_fruit,2)*0.25, size(img_of_fruit,2)*0.75]);
%     red_val = max(max(imcrop(img_of_fruit, nn));
    
    green_val = mean(min(min(img_of_fruit(size(img_of_fruit,1)-20:size(img_of_fruit,1),1:20))));
    
    % get rid of borders
%     size_of_im = size(img_of_fruit);
%     rows = size_of_im(1,1);
%     cols = size_of_im(1,2);
    
%     subimage = imcrop(img_of_fruit,[int16(rows*0.2), int16(rows-rows*0.2), int16(cols*0.2), int16(cols-cols*0.2)]);     % TODO: change -5 to diferent depend on size of image
%     subimage = 255.0-subimage;
    subimage = img_of_fruit(uint16(rows*0.2):uint16(rows-rows*0.2), uint16(cols*0.2):uint16(cols-cols*0.2));
        figure(3)
    imshow(subimage, [])

    size_of_im = size(subimage);
    % color_values
    ripness = ((sum(sum(subimage))-size_of_im(1,1)*size_of_im(1,2)*green_val)...
        /(red_val*size_of_im(1,1)*size_of_im(1,2)...
        - green_val*size_of_im(1,1)*size_of_im(1,2)));
    
end