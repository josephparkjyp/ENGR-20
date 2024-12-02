% Discrete Test
[filename, pathname] = uigetfile('*.*', 'Select the Input Greyscale Image');
filewithpath = strcat(pathname, filename);
I = imread(filewithpath);
figure
imshow(I)
% Classify the image using the network
label = classify(net, I);
title([' Recognized Digit is ' char(label)])



