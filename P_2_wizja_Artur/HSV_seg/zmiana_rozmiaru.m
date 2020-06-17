clear all; close all; clc;
image = imread('dzialka_art/da_10.jpg');
figure(1)
imshow(image, []);

image = imresize(image,[576, 1024]);
figure(2)
imshow(image, [])
imwrite(image, 'dzialka_small/da_10_s.jpg');
