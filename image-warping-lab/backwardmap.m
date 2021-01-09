clear all;
close all;

source = im2double(imread('mona.jpg'));
target = zeros(size(source));

T = [1 0 -size(source, 2) / 2; 0 1 -size(source, 1) / 2; 0 0 1];
t = pi / 4;
R = [cos(t) -sin(t) 0; sin(t) cos(t) 0; 0 0 1];
S = [4 0 0; 0 4 0; 0 0 1];

% The warping transformation (rotation + scale about an arbitrary point).
M = inv(T) * R * S * T;
M_inverse = inv(M);

numberOfRows = size(target, 2);
numberOfColumns = size(target, 1);

for x = 1 : numberOfRows
    for y = 1 : numberOfColumns
        p = [y; x; 1];
        q = M_inverse * p;
        u = round(q(1) / q(3));
        v = round(q(2) / q(3));
        
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
target = imrotate(target, -90);
imshow([source target]);