clear all; close all; clc;
image = imread('dir');
% figure(1)
% imshow(image, []);

image = imresize(image,[636, 1024]);
% figure(2)
% imshow(image, [])
imwrite(image, 'st_small/da_63_s.jpg');
