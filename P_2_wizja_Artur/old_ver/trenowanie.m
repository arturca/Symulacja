% NIE TRZEBA TEGO ROBIC - straw_4_detector juz w folderze
clear all; close all;clc;
data= load('straw_4_dataset.mat');
source = [data.gTruth.DataSource.Source];
values = [data.gTruth.LabelData];

positiveInstances = [source, values];
negativeFolder = 'tes_negative';
negativeImages = imageDatastore(negativeFolder);

trainCascadeObjectDetector('straw_4_detector.xml',positiveInstances, ...
    negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',10);

%% uzywanie detektora do pracy
clear all; close all; clc;
detector = vision.CascadeObjectDetector('straw_4_detector.xml');
% not 1,3,6 , 8, 12
% maybe 2 but, maybe more 9
% ok 4, 5, 7, 11

% 1, 4, 5, 7, test_11
img = imread('DLA_TESTU/test_5.jpg');
bbox = step(detector,img);


%%
for i = 1:size(bbox(:,1,1))
    fruit_img = imcrop(img, bbox(i,:));
    figure(1)
    imshow(fruit_img)
    ripness_values(i) = ripness_checker(fruit_img)
    ripness_values_str(i) = compose('St: %.2f', ripness_values(i));
end

%%
detectedImg = insertObjectAnnotation(img,'rectangle',bbox(1,:), ripness_values_str(1));

for i =2:size(ripness_values_str,2)
    detectedImg = insertObjectAnnotation(detectedImg,'rectangle',bbox(i,:), ripness_values_str(i));
end

figure(1); 
subplot(1,2,1)
imshow(img, []);
subplot(1,2,2)
imshow(detectedImg, []);






