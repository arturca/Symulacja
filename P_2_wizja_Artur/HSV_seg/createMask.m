function [BW,maskedRGBImage] = createMask(RGB)

I = rgb2hsv(RGB);

% figure('name', 'HSV')
% subplot(2,1,1)
% imshow(I, []);
% hp = impixelinfo();
channel1MinGreen = 0.08; %0.00
channel1MaxGreen = 0.20;

channel2MinGreen = 0.15;
channel2MaxGreen = 0.65; %0.60

channel3MinGreen = 0.35;%0.5;
channel3MaxGreen = 1.0;%1.0;



channel1MinRed = 0.8;
channel1MaxRed = 1.0;

channel2MinRed = 0.20;
channel2MaxRed = 0.8;

channel3MinRed = 0.45;
channel3MaxRed = 1.0;

sliderBW_GREEN = (I(:,:,1) >= channel1MinGreen ) & (I(:,:,1) <= channel1MaxGreen) & ...
  (I(:,:,2) >= channel2MinGreen ) & (I(:,:,2) <= channel2MaxGreen) & ...
  (I(:,:,3) >= channel3MinGreen ) & (I(:,:,3) <= channel3MaxGreen);
    
sliderBW_RED = (I(:,:,1) >= channel1MinRed ) & (I(:,:,1) <= channel1MaxRed) & ...
  (I(:,:,2) >= channel2MinRed ) & (I(:,:,2) <= channel2MaxRed) & ...
  (I(:,:,3) >= channel3MinRed ) & (I(:,:,3) <= channel3MaxRed);
    

% 
% subplot(2,1,2)
% imshow(sliderBW_GREEN)

% sliderBW = sliderBW_GREEN | sliderBW_RED;

BW_GREEN = sliderBW_GREEN;
SE = strel("disk",8);
BW_GREEN = imerode(BW_GREEN,SE);
SE = strel("disk",12);



BW_GREEN = imdilate(BW_GREEN,SE);
BW_GREEN = bwareaopen(BW_GREEN, 60);
BW_GREEN = imfill( BW_GREEN ,'holes');


BW_RED = sliderBW_RED;
SE = strel("disk",4);
BW_RED = imerode(BW_RED,SE);
SE = strel("disk",10);
BW_RED = imdilate(BW_RED,SE);
BW_RED = bwareaopen(BW_RED, 60);
BW_RED = imfill( BW_RED ,'holes');

SE = strel("disk",2);

BW_GREEN = imerode(BW_GREEN, SE);
BW_RED = imerode(BW_RED, SE);




BW =  BW_GREEN | BW_RED;

BW = imfill(BW,'holes');
% Initialize output masked image based on input image.

% subplot(2,1,2)
% imshow(BW)

maskedRGBImage = RGB;
% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end