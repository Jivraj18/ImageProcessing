close all;
clear all;

% Read in two photos of the library.
left  = im2double(imread('parade1.bmp'));
right = im2double(imread('parade2.bmp'));

% Draw the left image.
figure(1);
image(left);
axis equal;
axis off;
title('Left image');
hold on;

% Draw the right image.
figure(2);
image(right);
axis equal;
axis off;
title('Right image');
hold on;

% Get 4 points on the left image.
figure(1);
[x, y] = ginput(4);
leftpts = [x'; y'];
% Plot left points on the left image.
figure(1)
plot(leftpts(1,:), leftpts(2,:), 'rx');

% Get 4 points on the right image.
figure(2);
[x, y] = ginput(4);
rightpts = [x'; y'];
% Plot the right points on the right image
figure(2)
plot(rightpts(1,:), rightpts(2,:), 'gx');

% Make leftpts and rightpts (clicked points) homogeneous.
leftpts(3,:) = 1;
rightpts(3,:) = 1;

H = calchomography(leftpts, rightpts);

save mymatrix H
load mymatrix

source = left;
target = zeros(size(source));

% The warping transformation (rotation + scale about an arbitrary point).
M = H;
M_inverse = inv(M);

numberOfRows = size(target, 2);
numberOfColumns = size(target, 1);

for x = 1 : numberOfRows
    for y = 1 : numberOfColumns
        p = [y; x; 1];
        q = M_inverse * p;
        u = round(q(1) / q(3));
        v = round(q(2) / q(3));
        
        if(u > 0 && u <= numberOfColumns && v <= numberOfRows && v > 0)
        f1 = [floor(u) ; floor(v)];
        f2 = [floor(u) ; ceil(v)];
        f3 = [ceil(u) ; floor(v)];
        f4 = [ceil(u) ; ceil(v)];
        
        beta = u - f1(1);
        alpha = v - f1(2);
        
        f12 = ((1 - alpha) .* source(f1(1), f1(2), : )) + (alpha .* source(f2(1), f2(2), : ));
        f34 = ((1 - alpha) .* source(f3(1), f3(2), : )) + (alpha .* source(f4(1), f4(2), : ));
        f1234 = ((1 - alpha) .* f12) + (beta .* f34);
       
        target(y, x, :) = f1234;
        end
    end
end
imshow([left target]);