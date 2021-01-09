
function [iOut] = extended_convolution(iSource, k)
% extended_convolution - returns resultant image of convolution of an 
% image(img) and kernel(k) input a grayscale image (2D matrix) and a 
% filtering kernel (2D matrix), and returns the convolved image result 
% as a greyscale image with the same size and datatype as the input image.
% Hint: use 'padarray' here

%% TODO: finish the rest part of the extended_convolution.

kernelRows = size(k, 2);
kernelColumns = size(k,1);
midKernelRows = round(kernelRows(1) / 2) - 1;
midKernelColumns = round(kernelColumns(1,1) / 2) - 1;

padWidth = midKernelRows;
padHeight = midKernelColumns;
if(padHeight == 0)
    padHeight = 1;
end
if(padWidth == 0)
    padWidth = 1;
end
image = padarray(iSource, [padWidth padHeight], 'replicate', 'both');

iOut = basic_convolution(image, k);
iOut = iOut(padWidth+1:end-padWidth,padHeight+1:end-padHeight); % unpad array
end