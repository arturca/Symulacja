%test
clear all;
close all;
data = [0 1 3; -5 -5 -5; -4 -2 -3; 2 1 4; 5 1 9; 0 4 7;10 10 10;3 5 4; 5 5 5; 1 3 7;-1 -1 -1;10 7 8; 9 0 2; 1 2 3];
startpoint = [0 0 0];
[dist route] = komi(data,startpoint);
        
       
        
