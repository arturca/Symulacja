% NIE TRZEBA TEGO ROBIC - straw_4_detector juz w folderze

% wymagany toolbox: Computer Vision Toolbox
clear all; close all;clc;


% straw_4_dataset.mat-przygotowany zesataw danych na podsatwie zdje� przy
% u�yciu Matlab: imageLabeler.
% data= load('straw_4_dataset.mat');  
% data= load('test_do_delete.mat');
data= load('straw_4_wider.mat');
source = [data.gTruth.DataSource.Source];
values = [data.gTruth.LabelData];

positiveInstances = [source, values];
negativeFolder = 'detector_builder_negative';
negativeImages = imageDatastore(negativeFolder);

trainCascadeObjectDetector('straw_4_detector.xml',positiveInstances, ...
    negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',10);
