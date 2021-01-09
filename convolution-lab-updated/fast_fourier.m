function [iOut] = fast_fourier(iSource, k)
% Hint: use 'fft' and 'ifft2' here.  

%% TODO: finish the rest part of the fast_fourier.

kernelRows = size(k, 2);
kernelColumns = size(k,1);
midKernelRows = round(kernelRows / 2) - 1;
midKernelColumns = round(kernelColumns / 2) - 1;

imagePadWidth = midKernelRows;
imagePadHeight = midKernelColumns;
img = iSource;
image = padarray(img, [imagePadWidth imagePadHeight], 'replicate', 'both');

numberOfRows = size(image, 1);
numberOfColumns = size(image, 2);

fftImage = fft2(image, numberOfRows, numberOfColumns); 
fftKernel = fft2(k, numberOfRows, numberOfColumns);
fft = fftImage .* fftKernel;
unpaddedOut = ifft2(fft);

iOut = unpaddedOut( kernelRows:numberOfRows , kernelColumns:numberOfColumns );
end