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
