% User Drawing
template = 'template.png';
copyfile(template, 'user_drawing.png');
system(['mspaint "user_drawing.png"']);

if isfile("user_drawing.png")
    I = rgb2gray(imread('user_drawing.png'));
    figure
    imshow(I)
    % Classify the image using the network
    label = classify(net, I);
    title([' Recognized Digit is ' char(label)])
else
    disp('No changes detected or the file was not saved.');
end