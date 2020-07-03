function [good_present, green_present] = vision_algo(rgbImage)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[rows, columns, numberOfColorChannels] = size(rgbImage);
[BW, maskedRGBImage] = createMask(rgbImage);
regions_with_strawberry = regionprops(BW, 'all');
[img_h, img_w, img_s] = size(rgbImage);

%imshow(rgbImage);
%hold on

regions_with_strawberry_table = struct2table(regions_with_strawberry);
regions_with_strawberry_table = sortrows(regions_with_strawberry_table,-1); %sortowanie malej¹co po area
regions_with_strawberry = table2struct(regions_with_strawberry_table);
regions_with_strawberry = regions_with_strawberry(1:min(3,(size(regions_with_strawberry,1)))); %przeszukujemy 3 najwiêksze obszary

for i=1:size(regions_with_strawberry,1)
   if regions_with_strawberry(i).Area > img_h*img_w*0.001 %ripval
        rip_val(i) = check_ripness(regions_with_strawberry(i).PixelList, rgbImage);
        [height, width] = size(regions_with_strawberry(i).Image);
        cent_x = regions_with_strawberry(i).Centroid(1);
        cent_y = regions_with_strawberry(i).Centroid(2);        
                
        lebeled_strawberry(i) = compose('St, R:%.2f, W:%.0f, H:%.0f, P=[%.0f;%.0f]',...
            rip_val(i), width*0.15625, height*0.15625, (cent_x-img_w/2)*0.16, (img_h-cent_y)*0.16);
                
        %rectangle('Position', regions_with_strawberry(i).BoundingBox,...
        %'EdgeColor','r', 'LineWidth', 3);
        x = regions_with_strawberry(i).BoundingBox(1)-10;
        y = regions_with_strawberry(i).BoundingBox(2)-10;
        %text(x,y, lebeled_strawberry(i),'Color','red','BackgroundColor','yellow','FontSize',10);
   end
end

% regions_with_green_strawberry = [];
% regions_with_good_strawberry = [];
% for i=1:size(regions_with_strawberry,1)
%     if rip_val(i)>0.6 & rip_val(i) <1.5
%         regions_with_good_strawberry = [regions_with_good_strawberry; regions_with_strawberry(i)];
%     elseif rip_val(i)>0 & rip_val(i)<0.4 
%         regions_with_green_strawberry = [regions_with_green_strawberry; regions_with_strawberry(i)];
%     end
% end

if(~(rip_val>0.6 & rip_val<1.5)) good_present = 0; 
else good_present = 1;
end

if(~(rip_val>0 & rip_val<0.6)) green_present = 0; 
else green_present = 1;
end


end

