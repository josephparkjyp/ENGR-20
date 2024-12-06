% Read in an image, convert to grayscale, then convert to binary.
% Each pixel in this 28x28 png will serve as a dimension in our KNN
% analysis.

trainingSet = readtable('./DigitDataset/digitTrain.csv');
x = [];
y = [];

% Go through `trainingSet` and organize the pixels of the 28x28 png into a
% column array. Appends each column vector into `x`. Each column is a
% separate image, and each row represents a separate dimension. The vector
% `y` contains the actual digit value which we will use to calculate the
% accuracy/error of the KNN model.
for i = 1:height(trainingSet)
    img_name = trainingSet{i,1}{1};
    img_digit = trainingSet{i,2};
    img = imread(['DigitDataset/' num2str(img_digit) '/' img_name]);
    %img = rgb2gray(img);
    img = imbinarize(img);
    x = [x, img(:)];
    y = [y, img_digit];
end

