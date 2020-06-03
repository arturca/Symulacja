%% uzywanie detektora do pracy
close all; clc;

detector = vision.CascadeObjectDetector('straw_4_detector.xml');
img_1 = imread('DLA_TESTU/test_1.jpg');
img_2 = imread('DLA_TESTU/test_2.jpg');
img_3 = imread('DLA_TESTU/test_3.jpg');

img_4 = imread('DLA_TESTU/test_4.jpg');
img_5 = imread('DLA_TESTU/test_5.jpg');
img_6 = imread('DLA_TESTU/test_6.jpg');

img_7 = imread('DLA_TESTU/test_7.jpg');
img_8 = imread('DLA_TESTU/test_8.jpg');
img_9 = imread('DLA_TESTU/test_9.jpg');

% jak wiadac niekotre wychodza lepiej, a inne gorzej. Zesataw uczacy zostal
% zbudoawny na zbyt malej liczbie zdjec. Dlatego nie ktore restowy wychodza
% lepiej a inne gorzej.


% wynik - dobry
figure(1)
subplot(1,2,1)
imshow(img_5, [])
title('orginal')

subplot(1,2,2)
bbox = step(detector,img_5);
straw_detection = insertObjectAnnotation(img_5,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);


% wynik - poprawny
figure(2)
subplot(1,2,1)
imshow(img_4, [])
title('orginal')

subplot(1,2,2)
bbox = step(detector,img_4);
straw_detection = insertObjectAnnotation(img_4,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);


% wynik - tragiczny :)
figure(3)
subplot(1,2,1)
imshow(img_9, [])
title('orginal')

subplot(1,2,2)
bbox = step(detector,img_9);
straw_detection = insertObjectAnnotation(img_9,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);




%% SUBPLOTY

figure(4)
subplot(2,2,1)
imshow(img_1, [])
title('orginal')

subplot(2,2,2)
bbox = step(detector,img_1);
straw_detection = insertObjectAnnotation(img_1,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);


title('Detection')
subplot(2,2,3)
imshow(img_2, [])
title('orginal')

subplot(2,2,4)
bbox = step(detector,img_2);
straw_detection = insertObjectAnnotation(img_2,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);

figure(5)
subplot(3,2,1)
imshow(img_4, [])
title('orginal')

subplot(3,2,2)
bbox = step(detector,img_4);
straw_detection = insertObjectAnnotation(img_4,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);
title('Detection')

subplot(3,2,3)
imshow(img_5, [])
title('orginal')

subplot(3,2,4)
bbox = step(detector,img_5);
straw_detection = insertObjectAnnotation(img_5,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);
title('Detection')

subplot(3,2,5)
imshow(img_6, [])
title('orginal')

subplot(3,2,6)
bbox = step(detector,img_6);
straw_detection = insertObjectAnnotation(img_6,'rectangle',bbox,'Strawberry');
imshow(straw_detection, []);
title('Detection')

