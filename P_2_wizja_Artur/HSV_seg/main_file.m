close all; clear; clc;


workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 16;

% read an image:
rgbImage = imread('st_small/da_11_s.jpg');
[rows, columns, numberOfColorChannels] = size(rgbImage);

% figure(1)
% % subplot(1,2,1)
% imshow(rgbImage, [])


[BW, maskedRGBImage] = createMask(rgbImage);
% subplot(1, 2, 2);
% imshow(BW);


regions_with_strawberry = regionprops(BW, 'all');


[img_h, img_w,img_s] = size(rgbImage);

figure(2)
% subplot(1,2,2)
imshow(rgbImage)
hold on
% hp = impixelinfo();
regions_with_strawberry_table = struct2table(regions_with_strawberry);
regions_with_strawberry_table = sortrows(regions_with_strawberry_table,-1);
regions_with_strawberry = table2struct(regions_with_strawberry_table);

for i=1:size(regions_with_strawberry,1)
   if regions_with_strawberry(i).Area > 500;
        rip_val(i) = check_ripness(regions_with_strawberry(i).PixelList, rgbImage);
        [height, width] = size(regions_with_strawberry(i).Image);
        cent_x = regions_with_strawberry(i).Centroid(1);
        cent_y = regions_with_strawberry(i).Centroid(2);
        
        
        
        lebeled_strawberry(i) = compose('St, R:%.2f, W:%.0f, H:%.0f, P=[%.0f;%.0f]',...
            rip_val(i), width*0.15625, height*0.15625, (cent_x-img_w/2)*0.16, (img_h-cent_y)*0.16);
        
        
        rectangle('Position', regions_with_strawberry(i).BoundingBox,...
        'EdgeColor','r', 'LineWidth', 3);
        x = regions_with_strawberry(i).BoundingBox(1)-10;
        y = regions_with_strawberry(i).BoundingBox(2)-10;
        text(x,y, lebeled_strawberry(i),'Color','red','BackgroundColor','yellow','FontSize',10);
   end
end

figure(3)
imshow(rgbImage)
hold on
regions_with_strawberry = regions_with_strawberry(1);
for i=1:size(regions_with_strawberry,1)
   if regions_with_strawberry(i).Area > img_h*img_w*0.001 %strawberry should have at least 0,1% of picture area
        rip_val(i) = check_ripness(regions_with_strawberry(i).PixelList, rgbImage);
        [height, width] = size(regions_with_strawberry(i).Image);
        cent_x = regions_with_strawberry(i).Centroid(1);
        cent_y = regions_with_strawberry(i).Centroid(2);
        
        
        
        lebeled_strawberry(i) = compose('St, R:%.2f, W:%.0f, H:%.0f, P=[%.0f;%.0f]',...
            rip_val(i), width*0.15625, height*0.15625, (cent_x-img_w/2)*0.16, (img_h-cent_y)*0.16);
        
        
        rectangle('Position', regions_with_strawberry(i).BoundingBox,...
        'EdgeColor','r', 'LineWidth', 3);
        x = regions_with_strawberry(i).BoundingBox(1)-10;
        y = regions_with_strawberry(i).BoundingBox(2)-10;
        text(x,y, lebeled_strawberry(i),'Color','red','BackgroundColor','yellow','FontSize',10);
   end
end

(rip_val>0.7 & rip_val<1.1)

(rip_val>0 & rip_val<0.4)


