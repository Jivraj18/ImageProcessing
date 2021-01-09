clc; clear all; close all;

% Basic Convolution
image = im2double(imread('cameraman.tif'));
kernelA =  ones(5) / 25;
kernelB = [-1 0 1];

basic = basic_convolution(image, kernelA);

figure('Name', 'Basic Convolution');
subplot(131); imshow(image); title('Input image');
subplot(132); imshow(basic); title('Filtered image');
subplot(133); imshow(basic_convolution(image, kernelB)); title('[-1 0 1]');

% Extended Convolution
tic;
extendedA = extended_convolution(image, kernelA);
elapsedTime = toc;
fprintf('Extended Convolution Time (5*5) =  %f\n', elapsedTime);

referenceA = imfilter(image, kernelA,'replicate');
differenceA = 0.5 + 10 * (extendedA - referenceA);
ssdA = sum((extendedA(:) - referenceA(:)) .^ 2);

extendedB = extended_convolution(image, kernelB);
referenceB = imfilter(image, kernelB,'replicate');
differenceB = 0.5 + 10 * (extendedB - referenceB);
ssdB = sum((extendedB(:) - referenceB(:)) .^ 2);

figure('Name', 'Extended Convolution');
subplot(231); imshow(extendedA); title('Extended convolution');
subplot(232); imshow(referenceA); title('Reference result');
subplot(233); imshow(differenceA); title(sprintf('Difference (SSD=%.1f)',ssdA));
subplot(234); imshow(extendedB); title('[-1 0 1]');
subplot(235); imshow(referenceB); title('Reference result');
subplot(236); imshow(differenceB); title(sprintf('Difference (SSD=%.1f)',ssdB));

% Filters
% Task: edit the kernels in the following cells according to their names.

hKernal = [ 1 2 1 ; 0 0 0 ; -1 -2 -1 ]; % horizontal
vKernal = [ 1 0 -1 ; 2 0 -2 ; 1 0 -1 ]; % vertical
dKernal = [ 2 1 0 ; 1 0 -1 ; 0 -1 -2 ]; % any dialog iamge gradients
sKernal = [ 0 -1 0 ; -1 5 -1 ; 0 -1 0 ]; % sharpening
gKernal = zeros(5,5);
row = 1;
column = 1;
sigma = 1;
for x = -2 : 2
    for y = -2 : 2
        expComp = -(x .^ 2 + y .^ 2) / (2 * sigma * sigma);
        gKernal(row, column) = exp(expComp) / (2 * pi * sigma * sigma);
        column = column + 1;
    end
    column = 1;
    row = row + 1;
end

figure('Name', 'Image Filtering');
subplot(221); imshow(extended_convolution(image, hKernal)); title('Horizontal');
subplot(222); imshow(extended_convolution(image, vKernal)); title('Vertical');
subplot(223); imshow(extended_convolution(image, dKernal)); title('Diagonal');
subplot(224); imshow(extended_convolution(image, sKernal)); title('Sharpening');

figure('Name', 'Gaussian');
imshow(extended_convolution(image, gKernal)); title(sprintf('sum(K(:)) = %.1f', sum(gKernal(:))));

% FFT
tic;
fft_img = fast_fourier(image, gKernal);
elapsedTime = toc;
fprintf('Fast Foruier Transform Time (5*5) =  %f\n', elapsedTime);

referenceC = imfilter(image, gKernal,'replicate');
differenceC = 0.5 + 10 * (fft_img - referenceC);
ssdC = sum((fft_img(:) - referenceC(:)) .^ 2);

figure('Name', 'Extended Convolution');
subplot(131); imshow(fft_img); title('Extended convolution');
subplot(132); imshow(referenceC); title('Reference result');
subplot(133); imshow(differenceC); title(sprintf('Difference (SSD=%.1f)',ssdC));

%FFT Comparisons
% TODO: finish the missing part of the FFT Comparisons.

for i = 5 : 40 : 285
    kernel = zeros(i,i);
    tic;
    fft_img = fast_fourier(image, kernel);
    elapsedTime = toc;
    fprintf('Fast Foruier Transform Time for kernel size %d*%d =  %f\n', i, i, elapsedTime);
end




