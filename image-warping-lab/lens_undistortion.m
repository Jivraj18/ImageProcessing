img = im2double(imread('window.jpg'));
output = zeros(size(img));

K = [474.53 0 405.96; 0 474.53 217.81; 0 0 1];
fx = K(1,1);
py = K(1,3);
fy = K(2,2);
px = K(2,3);

k1k2k3 = [-0.27194 0.11517 -0.029859];
k1 = k1k2k3(1);
k2 = k1k2k3(2);
k3 = k1k2k3(3);

numberOfRows = size(output, 2);
numberOfColumns = size(output, 1);

for v = 1 : numberOfRows
    for u = 1 : numberOfColumns
        x = (u - px) / fx;
        y = (v - py) / fy;
        r_squared = (x*x) + (y*y);
        x_dash = x * (1 + (k1*r_squared) + (k2 * r_squared * r_squared) + (k3 * r_squared * r_squared * r_squared));
        y_dash = y * (1 + (k1*r_squared) + (k2 * r_squared * r_squared) + (k3 * r_squared * r_squared * r_squared));
        u_dash = round((x_dash * fx) + px);
        v_dash = round((y_dash * fx) + py);
        output(u, v, :) = img(u_dash, v_dash, :);
    end
end

imshow([img output]);
