test_img = imread('user_drawing.png');
test_img = rgb2gray(test_img);
test_img = imbinarize(test_img);
test_img = test_img(:);

test = repmat(test_img,1,5000);
test2 = test - x;
distanceMatrix = sum((test - x).^2);

[sorted_distanceMatrix,idx] = sort(distanceMatrix);

output = [];
for i = 1:3
    output = [output y(idx(i))];
end
mode(output)